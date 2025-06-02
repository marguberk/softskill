from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from typing import List

from app.db.base import get_db
from app.models.user import User
from app.models.course import Course
from app.models.learning_material import LearningMaterial
from app.core.auth import get_current_user
from app.services.gamification import GamificationService
from app.schemas.gamification import (
    CourseCompletionResult, LessonCompletionResult, 
    ProgressSummary, DashboardProgress, XPGainResult
)

router = APIRouter()


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


@router.post("/complete-task/{task_id}", response_model=dict)
async def complete_task(
    task_id: int,
    score: float = 100,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Отмечает задание как завершенное и начисляет XP"""
    service = GamificationService(db)
    
    try:
        # Начисляем XP за выполнение задания (5 XP за задание)
        xp_result = service.complete_task(current_user.id, task_id, score)
        
        return {
            "task_id": task_id,
            "xp_gained": xp_result.xp_gained,
            "new_level": xp_result.new_level,
            "level_up": xp_result.level_up,
            "message": f"🎯 Задание выполнено! Получено {xp_result.xp_gained} XP!"
        }
        
    except ValueError as e:
        if "already completed" in str(e):
            raise HTTPException(status_code=400, detail="Задание уже выполнено")
        raise HTTPException(status_code=400, detail=str(e))


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