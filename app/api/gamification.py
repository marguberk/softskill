from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from sqlalchemy import func
from typing import List, Dict
from datetime import datetime, timedelta

from app.db.base import get_db
from app.models.user import User
from app.models.gamification import (
    UserGameProfile, UserActivity, Reward, UserReward,
    Leaderboard, ActionType
)
from app.schemas.gamification import (
    UserGameProfile as UserGameProfileSchema,
    UserActivity as UserActivitySchema,
    LeaderboardEntry,
    LevelProgress
)
from app.api.deps import get_current_user

router = APIRouter()

# Константы для системы уровней и наград
EXP_CONFIG = {
    "LESSON_COMPLETE": 50,
    "COURSE_COMPLETE": 500,
    "QUIZ_COMPLETE": 100,
    "PERFECT_SCORE": 200,
    "DAILY_LOGIN": 25,
    "STREAK_MILESTONE": 300,
    "HELP_OTHERS": 150,
    "FIRST_COURSE": 1000
}

LEVEL_CONFIG = {
    "BASE_EXP": 100,  # Базовый опыт для первого уровня
    "MULTIPLIER": 1.5  # Множитель для каждого следующего уровня
}


class GameSystem:
    def __init__(self, db: Session, user_id: int):
        self.db = db
        self.user_id = user_id
        self.profile = self._get_or_create_profile()

    def _get_or_create_profile(self) -> UserGameProfile:
        """Получить или создать игровой профиль пользователя"""
        profile = self.db.query(UserGameProfile).filter(
            UserGameProfile.user_id == self.user_id
        ).first()

        if not profile:
            profile = UserGameProfile(user_id=self.user_id)
            self.db.add(profile)
            self.db.commit()
            self.db.refresh(profile)

        return profile

    def calculate_level(self, exp: int) -> Dict:
        """Рассчитать текущий уровень и прогресс"""
        level = 1
        exp_needed = LEVEL_CONFIG["BASE_EXP"]
        exp_total = exp

        while exp_total >= exp_needed:
            exp_total -= exp_needed
            level += 1
            exp_needed = int(LEVEL_CONFIG["BASE_EXP"] *
                             (LEVEL_CONFIG["MULTIPLIER"] ** (level - 1)))

        next_level_exp = int(LEVEL_CONFIG["BASE_EXP"] *
                             (LEVEL_CONFIG["MULTIPLIER"] ** (level - 1)))
        progress = (exp_total / next_level_exp) * 100

        return {
            "level": level,
            "current_exp": exp_total,
            "exp_to_next_level": next_level_exp,
            "progress_percentage": progress
        }

    async def add_experience(self, action_type: str, action_details: Dict = None) -> Dict:
        """Добавить опыт и обработать изменение уровня"""
        exp_gained = EXP_CONFIG.get(action_type, 0)
        old_level = self.calculate_level(self.profile.experience)["level"]

        self.profile.experience += exp_gained
        new_level_data = self.calculate_level(self.profile.experience)

        # Записываем действие
        activity = UserActivity(
            profile_id=self.profile.id,
            action_type=action_type,
            exp_earned=exp_gained,
            action_details=action_details
        )
        self.db.add(activity)

        # Если уровень повысился, проверяем награды
        if new_level_data["level"] > old_level:
            await self.check_rewards()

        self.profile.level = new_level_data["level"]
        self.profile.last_action = datetime.utcnow()

        self.db.commit()

        return {
            "exp_gained": exp_gained,
            "new_level_data": new_level_data,
            "rewards_unlocked": []  # Здесь будут новые награды
        }

    async def check_rewards(self) -> List[Reward]:
        """Проверить и выдать доступные награды"""
        unlocked_rewards = []
        available_rewards = self.db.query(Reward).filter(
            Reward.required_level <= self.profile.level
        ).all()

        for reward in available_rewards:
            # Проверяем, не получена ли награда ранее
            existing = self.db.query(UserReward).filter(
                UserReward.profile_id == self.profile.id,
                UserReward.reward_id == reward.id
            ).first()

            if not existing:
                new_reward = UserReward(
                    profile_id=self.profile.id,
                    reward_id=reward.id
                )
                self.db.add(new_reward)
                unlocked_rewards.append(reward)

                # Добавляем награду в профиль
                if reward.reward_type == "badge":
                    self.profile.badges.append(reward.title)
                elif reward.reward_type == "title":
                    self.profile.titles.append(reward.title)

        return unlocked_rewards

    async def update_leaderboard(self):
        """Обновить позиции в таблице лидеров"""
        periods = {
            "daily": datetime.utcnow() - timedelta(days=1),
            "weekly": datetime.utcnow() - timedelta(weeks=1),
            "monthly": datetime.utcnow() - timedelta(days=30),
            "all-time": None
        }

        for period_name, period_start in periods.items():
            # Получаем счет за период
            query = self.db.query(func.sum(UserActivity.exp_earned))
            query = query.join(UserGameProfile)
            query = query.filter(UserGameProfile.user_id == self.user_id)

            if period_start:
                query = query.filter(UserActivity.created_at >= period_start)

            score = query.scalar() or 0

            # Обновляем или создаем запись
            leaderboard = self.db.query(Leaderboard).filter(
                Leaderboard.user_id == self.user_id,
                Leaderboard.period == period_name
            ).first()

            if leaderboard:
                leaderboard.score = score
            else:
                leaderboard = Leaderboard(
                    user_id=self.user_id,
                    period=period_name,
                    score=score
                )
                self.db.add(leaderboard)

        self.db.commit()


# API endpoints
@router.get("/profile", response_model=UserGameProfileSchema)
async def get_profile(
        db: Session = Depends(get_db),
        current_user: User = Depends(get_current_user)
):
    """Получить игровой профиль пользователя"""
    game_system = GameSystem(db, current_user.id)
    return game_system.profile


@router.post("/action/{action_type}")
async def record_action(
        action_type: str,
        action_details: Dict = None,
        db: Session = Depends(get_db),
        current_user: User = Depends(get_current_user)
):
    """Записать действие и начислить награды"""
    game_system = GameSystem(db, current_user.id)
    result = await game_system.add_experience(action_type, action_details)
    await game_system.update_leaderboard()
    return result


@router.get("/leaderboard/{period}", response_model=List[LeaderboardEntry])
async def get_leaderboard(
        period: str,
        limit: int = 10,
        db: Session = Depends(get_db)
):
    """Получить таблицу лидеров за определенный период"""
    if period not in ["daily", "weekly", "monthly", "all-time"]:
        raise HTTPException(status_code=400, detail="Invalid period")

    leaderboard = db.query(
        Leaderboard,
        User.full_name,
        UserGameProfile.level,
        UserGameProfile.badges
    ).join(
        User, Leaderboard.user_id == User.id
    ).join(
        UserGameProfile, UserGameProfile.user_id == User.id
    ).filter(
        Leaderboard.period == period
    ).order_by(
        Leaderboard.score.desc()
    ).limit(limit).all()

    return [
        LeaderboardEntry(
            user_id=entry.Leaderboard.user_id,
            user_name=entry.full_name,
            score=entry.Leaderboard.score,
            rank=idx + 1,
            level=entry.level,
            badges=entry.badges
        )
        for idx, entry in enumerate(leaderboard)
    ]