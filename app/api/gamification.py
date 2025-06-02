from fastapi import APIRouter, Depends, HTTPException, status
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
from app.models.course import Course
from app.models.learning import LearningMaterial
from app.core.auth import get_current_user
from app.services.gamification import GamificationService
from app.schemas.gamification import (
    UserGameProfile as UserGameProfileSchema,
    UserActivity as UserActivitySchema,
    LeaderboardEntry,
    LevelProgress,
    CourseCompletionResult,
    LessonCompletionResult,
    ProgressSummary,
    DashboardProgress,
    XPGainResult
)

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


@router.post("/complete-course/{course_id}", response_model=CourseCompletionResult)
async def complete_course(
    course_id: int,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Отмечает курс как завершенный и начисляет XP/обновляет навыки"""
    service = GamificationService(db)
    
    try:
        # Получаем информацию о курсе
        course = db.query(Course).filter(Course.id == course_id).first()
        if not course:
            raise HTTPException(status_code=404, detail="Курс не найден")
        
        # Обрабатываем завершение курса
        xp_result, skill_result = service.complete_course(current_user.id, course_id)
        
        # Проверяем достижения
        achievements = service.check_and_award_achievements(current_user.id)
        achievement_titles = [ach.title for ach in achievements]
        
        return CourseCompletionResult(
            course_id=course_id,
            course_title=course.title,
            xp_result=xp_result,
            skill_result=skill_result,
            achievements=achievement_titles,
            completion_message=f"🎉 Поздравляем! Вы успешно завершили курс \"{course.title}\"!"
        )
        
    except ValueError as e:
        if "already completed" in str(e):
            raise HTTPException(status_code=400, detail="Курс уже завершен")
        raise HTTPException(status_code=400, detail=str(e))


@router.post("/complete-lesson/{lesson_id}", response_model=LessonCompletionResult)
async def complete_lesson(
    lesson_id: int,
    score: float = None,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Отмечает урок как завершенный и начисляет XP"""
    service = GamificationService(db)
    
    # Получаем информацию об уроке (в данном случае это материал из learning_materials)
    material = db.query(LearningMaterial).filter(LearningMaterial.id == lesson_id).first()
    if not material:
        raise HTTPException(status_code=404, detail="Урок не найден")
    
    # Обрабатываем завершение урока
    xp_result = service.complete_lesson(current_user.id, lesson_id, score)
    
    # Проверяем достижения
    achievements = service.check_and_award_achievements(current_user.id)
    achievement_titles = [ach.title for ach in achievements]
    
    return LessonCompletionResult(
        lesson_id=lesson_id,
        lesson_title=material.title,
        xp_result=xp_result,
        achievements=achievement_titles
    )


@router.get("/progress", response_model=ProgressSummary)
async def get_progress_summary(
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Получает сводку прогресса пользователя"""
    service = GamificationService(db)
    return service.get_progress_summary(current_user.id)


@router.get("/dashboard", response_model=DashboardProgress)
async def get_dashboard_progress(
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Получает данные прогресса для дашборда"""
    service = GamificationService(db)
    progress = service.get_progress_summary(current_user.id)
    
    # Получаем сводку по навыкам
    from app.services.skills import SkillAssessmentService
    skill_service = SkillAssessmentService(db)
    user_skills = skill_service.get_user_current_skills(current_user.id)
    
    # Общее количество курсов
    total_courses = db.query(Course).filter(Course.is_published == True).count()
    
    # Определяем название уровня
    level_names = {
        1: "Новичок",
        2: "Начинающий",
        3: "Практик",
        4: "Опытный",
        5: "Эксперт",
        6: "Мастер",
        7: "Гуру",
        8: "Легенда",
        9: "Чемпион",
        10: "Великий мастер"
    }
    
    # XP для следующего уровня
    level_thresholds = service.LEVEL_THRESHOLDS
    next_level_xp = level_thresholds[progress.level] if progress.level < len(level_thresholds) else level_thresholds[-1]
    progress_percentage = round((progress.current_xp / next_level_xp) * 100) if next_level_xp > 0 else 100
    
    # Форматируем навыки для дашборда
    skills_summary = []
    for skill in user_skills:
        level_map = {
            "BEGINNER": "начальный",
            "INTERMEDIATE": "средний", 
            "ADVANCED": "продвинутый",
            "EXPERT": "экспертный"
        }
        skills_summary.append({
            "name": skill.skill_name,
            "score": skill.score,
            "level": level_map.get(skill.level, skill.level.lower())
        })
    
    return DashboardProgress(
        level=progress.level,
        level_name=level_names.get(progress.level, f"Уровень {progress.level}"),
        current_xp=progress.current_xp,
        next_level_xp=next_level_xp,
        progress_percentage=progress_percentage,
        total_courses=total_courses,
        completed_courses=progress.courses_completed,
        skills_summary=skills_summary,
        recent_achievements=[]  # TODO: Добавить последние достижения
    )


@router.get("/profile", response_model=dict)
async def get_game_profile(
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Получает игровой профиль пользователя"""
    service = GamificationService(db)
    profile = service.get_or_create_game_profile(current_user.id)
    
    return {
        "user_id": profile.user_id,
        "level": profile.level,
        "experience_points": profile.experience_points,
        "courses_completed": profile.courses_completed,
        "lessons_completed": profile.lessons_completed,
        "perfect_scores": profile.perfect_scores,
        "login_streak": profile.login_streak,
        "longest_streak": profile.longest_streak,
        "badges": profile.badges or [],
        "titles": profile.titles or [],
        "last_login": profile.last_login,
        "last_action": profile.last_action
    }