from typing import List, Optional
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session, joinedload
from sqlalchemy import func
from app.db.base import get_db
from app.models.course import (
    Course, CourseLesson, CourseEnrollment, CourseExam, 
    ExamAttempt, CourseCompletion, Certificate
)
from app.models.learning_material import LearningMaterial
from app.models.user import User
from app.schemas.course import (
    CourseCreate, CourseUpdate, Course as CourseSchema,
    CourseWithLessons, CourseWithDetails,
    CourseEnrollmentCreate, CourseEnrollment as CourseEnrollmentSchema,
    CourseExamCreate, CourseExam as CourseExamSchema,
    ExamAttemptCreate, ExamAttempt as ExamAttemptSchema,
    SkillType, DifficultyLevel
)
from app.core.auth import get_current_user
import json
import uuid
from datetime import datetime

router = APIRouter()

@router.get("/", response_model=List[CourseSchema])
async def get_courses(
    db: Session = Depends(get_db),
    skip: int = 0,
    limit: int = 100,
    skill_type: Optional[SkillType] = None,
    difficulty_level: Optional[DifficultyLevel] = None,
    is_published: Optional[bool] = None,
    current_user: User = Depends(get_current_user)
):
    """Получение списка курсов с фильтрацией"""
    query = db.query(Course)
    
    # Фильтры
    if skill_type:
        query = query.filter(Course.skill_type == skill_type)
    if difficulty_level:
        query = query.filter(Course.difficulty_level == difficulty_level)
    if is_published is not None:
        query = query.filter(Course.is_published == is_published)
    
    # Обычные пользователи видят только опубликованные курсы
    if current_user.role != "admin":
        query = query.filter(Course.is_published == True)
    
    courses = query.offset(skip).limit(limit).all()
    return courses

@router.get("/{course_id}", response_model=CourseWithDetails)
async def get_course(
    course_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    """Получение детальной информации о курсе"""
    course = db.query(Course).options(
        joinedload(Course.course_lessons),
        joinedload(Course.exams)
    ).filter(Course.id == course_id).first()
    
    if not course:
        raise HTTPException(status_code=404, detail="Курс не найден")
    
    # Проверка доступа
    if not course.is_published and current_user.role != "admin" and course.author_id != current_user.id:
        raise HTTPException(status_code=403, detail="Доступ запрещен")
    
    # Добавляем статистику
    enrollments_count = db.query(func.count(CourseEnrollment.id)).filter(
        CourseEnrollment.course_id == course_id,
        CourseEnrollment.is_active == True
    ).scalar()
    
    completions_count = db.query(func.count(CourseCompletion.id)).filter(
        CourseCompletion.course_id == course_id
    ).scalar()
    
    course_dict = course.__dict__.copy()
    course_dict['enrollments_count'] = enrollments_count
    course_dict['completions_count'] = completions_count
    
    return course_dict

@router.post("/", response_model=CourseSchema)
async def create_course(
    course_in: CourseCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    """Создание нового курса"""
    if current_user.role not in ["admin", "teacher"]:
        raise HTTPException(status_code=403, detail="Недостаточно прав для создания курса")
    
    course = Course(
        **course_in.dict(),
        author_id=current_user.id
    )
    
    db.add(course)
    db.commit()
    db.refresh(course)
    return course 