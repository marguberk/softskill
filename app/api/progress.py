from typing import List
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from app.db.base import get_db
from app.models.user import User
from app.models.progress import UserProgress, LessonProgress, Achievement, UserAchievement
from app.models.course import Course, Lesson
from app.schemas.progress import (
    UserProgress as UserProgressSchema,
    LessonProgressCreate,
    LessonProgress as LessonProgressSchema,
    Achievement as AchievementSchema
)
from app.api.deps import get_current_user
from datetime import datetime

router = APIRouter()


@router.get("/courses/{course_id}", response_model=UserProgressSchema)
async def get_course_progress(
        course_id: int,
        db: Session = Depends(get_db),
        current_user: User = Depends(get_current_user)
):
    """
    Получить прогресс пользователя по конкретному курсу
    """
    progress = db.query(UserProgress).filter(
        UserProgress.user_id == current_user.id,
        UserProgress.course_id == course_id
    ).first()

    if not progress:
        # Создаем запись о прогрессе, если её нет
        course = db.query(Course).filter(Course.id == course_id).first()
        if not course:
            raise HTTPException(status_code=404, detail="Course not found")

        total_lessons = sum(len(module.lessons) for module in course.modules)
        progress = UserProgress(
            user_id=current_user.id,
            course_id=course_id,
            total_lessons=total_lessons
        )
        db.add(progress)
        db.commit()
        db.refresh(progress)

    return progress


@router.post("/lessons/{lesson_id}", response_model=LessonProgressSchema)
async def update_lesson_progress(
        lesson_id: int,
        progress_data: LessonProgressCreate,
        db: Session = Depends(get_db),
        current_user: User = Depends(get_current_user)
):
    """
    Обновить прогресс по конкретному уроку
    """
    # Находим урок и проверяем его существование
    lesson = db.query(Lesson).filter(Lesson.id == lesson_id).first()
    if not lesson:
        raise HTTPException(status_code=404, detail="Lesson not found")

    # Получаем или создаем прогресс по курсу
    course_progress = db.query(UserProgress).filter(
        UserProgress.user_id == current_user.id,
        UserProgress.course_id == lesson.module.course_id
    ).first()

    if not course_progress:
        raise HTTPException(status_code=404, detail="Course progress not found")

    # Обновляем или создаем прогресс по уроку
    lesson_progress = db.query(LessonProgress).filter(
        LessonProgress.user_progress_id == course_progress.id,
        LessonProgress.lesson_id == lesson_id
    ).first()

    if not lesson_progress:
        lesson_progress = LessonProgress(
            user_progress_id=course_progress.id,
            lesson_id=lesson_id
        )
        db.add(lesson_progress)

    # Обновляем данные
    for field, value in progress_data.dict().items():
        setattr(lesson_progress, field, value)

    if progress_data.status == "completed" and not lesson_progress.completed_at:
        lesson_progress.completed_at = datetime.utcnow()

        # Обновляем общий прогресс по курсу
        course_progress.completed_lessons += 1
        course_progress.progress_percentage = (
                course_progress.completed_lessons / course_progress.total_lessons * 100
        )

    course_progress.last_accessed = datetime.utcnow()
    db.commit()
    db.refresh(lesson_progress)

    # Проверяем достижения
    await check_achievements(db, current_user.id)

    return lesson_progress


@router.get("/achievements", response_model=List[AchievementSchema])
async def get_user_achievements(
        db: Session = Depends(get_db),
        current_user: User = Depends(get_current_user)
):
    """
    Получить список достижений пользователя
    """
    achievements = db.query(Achievement).join(
        UserAchievement,
        UserAchievement.achievement_id == Achievement.id
    ).filter(
        UserAchievement.user_id == current_user.id
    ).all()

    return achievements


async def check_achievements(db: Session, user_id: int):
    """
    Проверка и выдача достижений пользователю
    """
    user_progress = db.query(UserProgress).filter(
        UserProgress.user_id == user_id
    ).all()

    total_completed_lessons = sum(p.completed_lessons for p in user_progress)
    completed_courses = len([p for p in user_progress if p.progress_percentage == 100])
    average_score = sum(p.average_score for p in user_progress) / len(user_progress) if user_progress else 0

    # Проверяем каждое достижение
    achievements = db.query(Achievement).all()
    for achievement in achievements:
        # Пропускаем уже полученные достижения
        if db.query(UserAchievement).filter(
                UserAchievement.user_id == user_id,
                UserAchievement.achievement_id == achievement.id
        ).first():
            continue

        # Проверяем условия
        if (completed_courses >= achievement.required_courses and
                total_completed_lessons >= achievement.required_lessons and
                average_score >= achievement.required_score):
            # Выдаем достижение
            user_achievement = UserAchievement(
                user_id=user_id,
                achievement_id=achievement.id
            )
            db.add(user_achievement)

    db.commit()