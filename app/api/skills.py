from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List
from datetime import datetime

from app.db.base import get_db
from app.models.user import User
from app.models.skills import (
    SoftSkill, SkillQuestion, QuestionOption, SkillAssessment, 
    UserAnswer, UserSkillAssessment, SkillCategory, SkillLevel
)
from app.schemas.skills import (
    AssessmentStatus, AssessmentStart, AssessmentQuestion, 
    AssessmentSubmit, AssessmentResult, UserSkillResult
)
from app.core.auth import get_current_user
from app.services.skills import SkillAssessmentService

router = APIRouter()

@router.get("/status", response_model=AssessmentStatus)
async def get_assessment_status(
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Проверяет, нужно ли пользователю пройти тест на гибкие навыки"""
    service = SkillAssessmentService(db)
    return service.get_user_assessment_status(current_user.id)

@router.post("/start", response_model=AssessmentStart)
async def start_assessment(
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Начинает новый тест на гибкие навыки"""
    service = SkillAssessmentService(db)
    
    # Проверяем, есть ли незавершенный тест
    existing_assessment = service.get_incomplete_assessment(current_user.id)
    if existing_assessment:
        total_questions = service.get_total_questions_count()
        return AssessmentStart(
            message="У вас есть незавершенный тест. Продолжите прохождение.",
            assessment_id=existing_assessment.id,
            total_questions=total_questions
        )
    
    # Создаем новый тест
    assessment = service.create_assessment(current_user.id)
    total_questions = service.get_total_questions_count()
    
    return AssessmentStart(
        message="Тест на гибкие навыки запущен. Удачи!",
        assessment_id=assessment.id,
        total_questions=total_questions
    )

@router.get("/question/{question_number}", response_model=AssessmentQuestion)
async def get_question(
    question_number: int,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Получает вопрос по номеру"""
    service = SkillAssessmentService(db)
    
    # Проверяем, есть ли активный тест
    assessment = service.get_incomplete_assessment(current_user.id)
    if not assessment:
        raise HTTPException(status_code=404, detail="Активный тест не найден")
    
    question = service.get_question_by_number(question_number)
    if not question:
        raise HTTPException(status_code=404, detail="Вопрос не найден")
    
    total_questions = service.get_total_questions_count()
    
    return AssessmentQuestion(
        id=question.id,
        question_text=question.question_text,
        question_type=question.question_type,
        skill_category=question.skill.category,
        options=[{
            "id": opt.id,
            "option_text": opt.option_text,
            "score_weight": opt.score_weight,
            "order_index": opt.order_index
        } for opt in question.options],
        current_question=question_number,
        total_questions=total_questions
    )

@router.post("/submit", response_model=AssessmentResult)
async def submit_assessment(
    submission: AssessmentSubmit,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Отправляет ответы и завершает тест"""
    service = SkillAssessmentService(db)
    
    # Проверяем, что тест принадлежит пользователю
    assessment = db.query(SkillAssessment).filter(
        SkillAssessment.id == submission.assessment_id,
        SkillAssessment.user_id == current_user.id
    ).first()
    
    if not assessment:
        raise HTTPException(status_code=404, detail="Тест не найден")
    
    if assessment.is_completed:
        raise HTTPException(status_code=400, detail="Тест уже завершен")
    
    # Сохраняем ответы и рассчитываем результаты
    result = service.submit_assessment(assessment, submission.answers)
    
    return result

@router.get("/results", response_model=AssessmentResult)
async def get_latest_assessment_results(
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Получает результаты последнего завершенного теста пользователя"""
    service = SkillAssessmentService(db)
    
    # Находим последний завершенный тест пользователя
    assessment = db.query(SkillAssessment).filter(
        SkillAssessment.user_id == current_user.id,
        SkillAssessment.is_completed == True
    ).order_by(SkillAssessment.completed_at.desc()).first()
    
    if not assessment:
        raise HTTPException(status_code=404, detail="Завершенные тесты не найдены")
    
    return service.get_assessment_results(assessment)

@router.get("/results/{assessment_id}", response_model=AssessmentResult)
async def get_assessment_results(
    assessment_id: int,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Получает результаты завершенного теста"""
    service = SkillAssessmentService(db)
    
    assessment = db.query(SkillAssessment).filter(
        SkillAssessment.id == assessment_id,
        SkillAssessment.user_id == current_user.id,
        SkillAssessment.is_completed == True
    ).first()
    
    if not assessment:
        raise HTTPException(status_code=404, detail="Результаты теста не найдены")
    
    return service.get_assessment_results(assessment)

@router.get("/skills", response_model=List[UserSkillResult])
async def get_user_skills(
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Получает текущие навыки пользователя"""
    service = SkillAssessmentService(db)
    return service.get_user_current_skills(current_user.id) 