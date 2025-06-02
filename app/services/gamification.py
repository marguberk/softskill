from sqlalchemy.orm import Session
from sqlalchemy import func, and_
from datetime import datetime
from typing import Dict, List, Optional, Tuple
import math

from app.models.course import Course, CourseCompletion
from app.models.gamification import UserGameProfile, UserActivity, Reward, UserReward, Leaderboard
from app.models.progress import (
    UserProgress, LessonProgress, Achievement, UserAchievement
)
from app.models.skills import (
    SoftSkill, SkillLevel, UserSkillAssessment, SkillAssessment
)
from app.models.learning_material import LearningMaterial
from app.schemas.gamification import (
    LevelUpResult, XPGainResult, SkillProgressResult, ProgressSummary
)


class GamificationService:
    def __init__(self, db: Session):
        self.db = db
        
        # Настройки начисления XP
        self.XP_REWARDS = {
            "lesson_complete": 10,
            "course_complete": 50,
            "perfect_score": 15,
            "first_course": 25,
            "streak_bonus": 5
        }
        
        # Настройки уровней (XP требуемый для каждого уровня)
        self.LEVEL_THRESHOLDS = [
            0,    # Уровень 1: 0 XP
            150,  # Уровень 2: 150 XP
            350,  # Уровень 3: 350 XP
            600,  # Уровень 4: 600 XP
            900,  # Уровень 5: 900 XP
            1250, # Уровень 6: 1250 XP
            1650, # Уровень 7: 1650 XP
            2100, # Уровень 8: 2100 XP
            2600, # Уровень 9: 2600 XP
            3150  # Уровень 10: 3150 XP
        ]

    def get_or_create_game_profile(self, user_id: int) -> UserGameProfile:
        """Получает или создает игровой профиль пользователя"""
        profile = self.db.query(UserGameProfile).filter(
            UserGameProfile.user_id == user_id
        ).first()
        
        if not profile:
            profile = UserGameProfile(
                user_id=user_id,
                level=1,
                experience_points=0,
                courses_completed=0,
                lessons_completed=0,
                perfect_scores=0,
                login_streak=0,
                longest_streak=0,
                badges=[],
                titles=[]
            )
            self.db.add(profile)
            self.db.commit()
            self.db.refresh(profile)
        
        return profile

    def complete_lesson(self, user_id: int, lesson_id: int, score: float = None) -> XPGainResult:
        """Обрабатывает завершение урока и начисляет XP"""
        profile = self.get_or_create_game_profile(user_id)
        
        # Базовый XP за урок
        xp_gained = self.XP_REWARDS["lesson_complete"]
        
        # Бонус за отличную оценку
        if score and score >= 90:
            xp_gained += self.XP_REWARDS["perfect_score"]
            profile.perfect_scores += 1
        
        # Начисляем XP
        old_level = profile.level
        profile.experience_points += xp_gained
        profile.lessons_completed += 1
        
        # Проверяем повышение уровня
        new_level = self.calculate_level(profile.experience_points)
        level_up = False
        
        if new_level > old_level:
            profile.level = new_level
            level_up = True
        
        profile.last_action = datetime.utcnow()
        self.db.commit()
        
        return XPGainResult(
            xp_gained=xp_gained,
            total_xp=profile.experience_points,
            old_level=old_level,
            new_level=profile.level,
            level_up=level_up,
            reason="lesson_complete"
        )

    def complete_course(self, user_id: int, course_id: int) -> Tuple[XPGainResult, SkillProgressResult]:
        """Обрабатывает завершение курса, начисляет XP и обновляет навыки"""
        profile = self.get_or_create_game_profile(user_id)
        
        # Получаем информацию о курсе
        course = self.db.query(Course).filter(Course.id == course_id).first()
        if not course:
            raise ValueError(f"Course {course_id} not found")
        
        # Проверяем, не завершал ли пользователь уже этот курс
        existing_completion = self.db.query(CourseCompletion).filter(
            CourseCompletion.user_id == user_id,
            CourseCompletion.course_id == course_id
        ).first()
        
        if existing_completion:
            raise ValueError("Course already completed")
        
        # Создаем запись о завершении курса
        completion = CourseCompletion(
            user_id=user_id,
            course_id=course_id,
            completed_at=datetime.utcnow()
        )
        self.db.add(completion)
        
        # Базовый XP за курс
        xp_gained = self.XP_REWARDS["course_complete"]
        
        # Бонус за первый курс
        if profile.courses_completed == 0:
            xp_gained += self.XP_REWARDS["first_course"]
        
        # Начисляем XP
        old_level = profile.level
        profile.experience_points += xp_gained
        profile.courses_completed += 1
        
        # Проверяем повышение уровня
        new_level = self.calculate_level(profile.experience_points)
        level_up = False
        
        if new_level > old_level:
            profile.level = new_level
            level_up = True
        
        profile.last_action = datetime.utcnow()
        
        # Обновляем навык
        skill_result = self.update_skill_progress(user_id, course.skill_type)
        
        self.db.commit()
        
        xp_result = XPGainResult(
            xp_gained=xp_gained,
            total_xp=profile.experience_points,
            old_level=old_level,
            new_level=profile.level,
            level_up=level_up,
            reason="course_complete"
        )
        
        return xp_result, skill_result

    def update_skill_progress(self, user_id: int, skill_type: str) -> SkillProgressResult:
        """Обновляет прогресс навыка после завершения курса"""
        
        # Получаем последнюю оценку навыков пользователя
        latest_assessment = self.db.query(SkillAssessment).filter(
            SkillAssessment.user_id == user_id,
            SkillAssessment.is_completed == True
        ).order_by(SkillAssessment.completed_at.desc()).first()
        
        if not latest_assessment:
            # Если нет оценки, создаем базовый результат
            return SkillProgressResult(
                skill_name=self.get_skill_name_by_type(skill_type),
                old_score=0,
                new_score=10,
                old_level="BEGINNER",
                new_level="BEGINNER",
                level_up=False,
                courses_completed=1
            )
        
        # Получаем текущий результат по навыку
        skill = self.db.query(SoftSkill).filter(
            SoftSkill.category == skill_type
        ).first()
        
        if not skill:
            raise ValueError(f"Skill type {skill_type} not found")
        
        skill_assessment = self.db.query(UserSkillAssessment).filter(
            UserSkillAssessment.assessment_id == latest_assessment.id,
            UserSkillAssessment.skill_id == skill.id
        ).first()
        
        if not skill_assessment:
            return SkillProgressResult(
                skill_name=skill.name,
                old_score=0,
                new_score=10,
                old_level="BEGINNER",
                new_level="BEGINNER",
                level_up=False,
                courses_completed=1
            )
        
        # Считаем количество завершенных курсов по этому навыку
        completed_courses = self.db.query(CourseCompletion).join(Course).filter(
            CourseCompletion.user_id == user_id,
            Course.skill_type == skill_type
        ).count()
        
        # Рассчитываем улучшение навыка (5-15 баллов за курс)
        old_score = skill_assessment.score
        old_level = skill_assessment.level
        
        # Прогрессия зависит от текущего уровня и сложности курса
        score_improvement = self.calculate_skill_improvement(old_score, completed_courses)
        new_score = min(100, old_score + score_improvement)
        
        # Определяем новый уровень
        new_level = self.determine_skill_level_by_score(new_score)
        level_up = new_level != old_level
        
        # Обновляем результат оценки навыка
        skill_assessment.score = new_score
        skill_assessment.level = new_level
        
        # Обновляем рекомендации
        skill_assessment.recommendations = self.get_skill_recommendations(skill, new_level)
        
        return SkillProgressResult(
            skill_name=skill.name,
            old_score=old_score,
            new_score=new_score,
            old_level=old_level.value,
            new_level=new_level.value,
            level_up=level_up,
            courses_completed=completed_courses
        )

    def calculate_level(self, total_xp: int) -> int:
        """Рассчитывает уровень на основе общего XP"""
        for level, threshold in enumerate(self.LEVEL_THRESHOLDS):
            if total_xp < threshold:
                return level
        return len(self.LEVEL_THRESHOLDS)  # Максимальный уровень

    def calculate_skill_improvement(self, current_score: int, courses_completed: int) -> int:
        """Рассчитывает улучшение навыка за курс"""
        if current_score < 30:
            return 15  # Быстрый рост для новичков
        elif current_score < 60:
            return 12  # Средний рост
        elif current_score < 80:
            return 8   # Замедленный рост
        else:
            return 5   # Медленный рост для экспертов

    def determine_skill_level_by_score(self, score: int) -> SkillLevel:
        """Определяет уровень навыка по баллам"""
        if score >= 85:
            return SkillLevel.EXPERT
        elif score >= 70:
            return SkillLevel.ADVANCED
        elif score >= 50:
            return SkillLevel.INTERMEDIATE
        else:
            return SkillLevel.BEGINNER

    def get_skill_name_by_type(self, skill_type: str) -> str:
        """Получает название навыка по типу"""
        skill = self.db.query(SoftSkill).filter(
            SoftSkill.category == skill_type
        ).first()
        return skill.name if skill else skill_type

    def get_skill_recommendations(self, skill: SoftSkill, level: SkillLevel) -> str:
        """Генерирует рекомендации для навыка"""
        recommendations = {
            SkillLevel.BEGINNER: f"Рекомендуем изучить основы {skill.name.lower()}. Начните с базовых курсов.",
            SkillLevel.INTERMEDIATE: f"У вас средний уровень {skill.name.lower()}. Изучите продвинутые техники.",
            SkillLevel.ADVANCED: f"Отличный уровень {skill.name.lower()}! Можете помогать другим и углублять знания.",
            SkillLevel.EXPERT: f"Экспертный уровень {skill.name.lower()}! Рассмотрите возможность наставничества."
        }
        return recommendations.get(level, f"Продолжайте развивать {skill.name.lower()}.")

    def get_progress_summary(self, user_id: int) -> ProgressSummary:
        """Получает сводку прогресса пользователя"""
        profile = self.get_or_create_game_profile(user_id)
        
        # XP до следующего уровня
        current_level_xp = self.LEVEL_THRESHOLDS[profile.level - 1] if profile.level > 1 else 0
        next_level_xp = self.LEVEL_THRESHOLDS[profile.level] if profile.level < len(self.LEVEL_THRESHOLDS) else self.LEVEL_THRESHOLDS[-1]
        xp_to_next_level = next_level_xp - profile.experience_points
        
        # Общий прогресс (процент от максимального уровня)
        max_xp = self.LEVEL_THRESHOLDS[-1]
        overall_progress = min(100, (profile.experience_points / max_xp) * 100)
        
        return ProgressSummary(
            level=profile.level,
            current_xp=profile.experience_points,
            xp_to_next_level=max(0, xp_to_next_level),
            overall_progress=round(overall_progress),
            courses_completed=profile.courses_completed,
            lessons_completed=profile.lessons_completed,
            perfect_scores=profile.perfect_scores,
            current_streak=profile.login_streak,
            longest_streak=profile.longest_streak
        )

    def check_and_award_achievements(self, user_id: int) -> List[Achievement]:
        """Проверяет и выдает достижения пользователю"""
        profile = self.get_or_create_game_profile(user_id)
        awarded_achievements = []
        
        # Получаем все возможные достижения
        all_achievements = self.db.query(Achievement).all()
        
        for achievement in all_achievements:
            # Проверяем, не получено ли уже это достижение
            existing = self.db.query(UserAchievement).filter(
                UserAchievement.user_id == user_id,
                UserAchievement.achievement_id == achievement.id
            ).first()
            
            if existing:
                continue
            
            # Проверяем условия получения
            if self.check_achievement_conditions(profile, achievement):
                user_achievement = UserAchievement(
                    user_id=user_id,
                    achievement_id=achievement.id,
                    achieved_at=datetime.utcnow()
                )
                self.db.add(user_achievement)
                awarded_achievements.append(achievement)
        
        if awarded_achievements:
            self.db.commit()
        
        return awarded_achievements

    def check_achievement_conditions(self, profile: UserGameProfile, achievement: Achievement) -> bool:
        """Проверяет условия получения достижения"""
        if achievement.required_courses and profile.courses_completed < achievement.required_courses:
            return False
        
        if achievement.required_lessons and profile.lessons_completed < achievement.required_lessons:
            return False
        
        # Дополнительные условия можно добавить здесь
        
        return True 