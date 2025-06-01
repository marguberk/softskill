from typing import List, Optional
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from sqlalchemy import func
from datetime import datetime

from app.db.base import get_db
from app.models.user import User
from app.models.quiz import Quiz, Question, QuizAttempt, QuestionResponse
from app.schemas.quiz import (
    QuizCreate, Quiz as QuizSchema,
    QuizAttempt as QuizAttemptSchema,
    SubmitQuizResponse, QuizResult
)
from app.api.deps import get_current_user

router = APIRouter()


@router.post("/", response_model=QuizSchema)
async def create_quiz(
        quiz_data: QuizCreate,
        lesson_id: int,
        db: Session = Depends(get_db),
        current_user: User = Depends(get_current_user)
):
    """Создание нового квиза"""
    if current_user.role not in ["teacher", "admin"]:
        raise HTTPException(status_code=403, detail="Not enough permissions")

    # Создаем квиз
    quiz = Quiz(
        lesson_id=lesson_id,
        **quiz_data.dict(exclude={'questions'})
    )
    db.add(quiz)
    db.commit()

    # Добавляем вопросы
    for question_data in quiz_data.questions:
        question = Question(
            quiz_id=quiz.id,
            **question_data.dict()
        )
        db.add(question)

    db.commit()
    db.refresh(quiz)
    return quiz


@router.get("/{quiz_id}", response_model=QuizSchema)
async def get_quiz(
        quiz_id: int,
        db: Session = Depends(get_db),
        current_user: User = Depends(get_current_user)
):
    """Получение информации о квизе"""
    quiz = db.query(Quiz).filter(Quiz.id == quiz_id).first()
    if not quiz:
        raise HTTPException(status_code=404, detail="Quiz not found")
    return quiz


@router.post("/{quiz_id}/start", response_model=QuizAttemptSchema)
async def start_quiz(
        quiz_id: int,
        db: Session = Depends(get_db),
        current_user: User = Depends(get_current_user)
):
    """Начать попытку прохождения квиза"""
    quiz = db.query(Quiz).filter(Quiz.id == quiz_id).first()
    if not quiz:
        raise HTTPException(status_code=404, detail="Quiz not found")

    # Проверяем количество попыток
    attempts_count = db.query(QuizAttempt).filter(
        QuizAttempt.quiz_id == quiz_id,
        QuizAttempt.user_id == current_user.id
    ).count()

    if attempts_count >= quiz.attempts_allowed:
        raise HTTPException(
            status_code=400,
            detail="Maximum number of attempts reached"
        )

    # Создаем новую попытку
    attempt = QuizAttempt(
        quiz_id=quiz_id,
        user_id=current_user.id
    )
    db.add(attempt)
    db.commit()
    db.refresh(attempt)

    return attempt


@router.post("/{quiz_id}/submit", response_model=QuizResult)
async def submit_quiz(
        quiz_id: int,
        submission: SubmitQuizResponse,
        db: Session = Depends(get_db),
        current_user: User = Depends(get_current_user)
):
    """Отправка ответов на квиз"""
    attempt = db.query(QuizAttempt).filter(
        QuizAttempt.id == submission.attempt_id,
        QuizAttempt.user_id == current_user.id
    ).first()

    if not attempt:
        raise HTTPException(status_code=404, detail="Attempt not found")

    if attempt.completed_at:
        raise HTTPException(status_code=400, detail="Quiz already completed")

    quiz = db.query(Quiz).filter(Quiz.id == quiz_id).first()
    total_points = 0
    max_points = 0
    correct_answers = 0

    # Проверяем каждый ответ
    for response_data in submission.responses:
        question = db.query(Question).filter(
            Question.id == response_data.question_id,
            Question.quiz_id == quiz_id
        ).first()

        if not question:
            continue

        max_points += question.points
        is_correct = False
        points_earned = 0

        # Проверка ответа в зависимости от типа вопроса
        if question.type in ['single_choice', 'multiple_choice']:
            is_correct = set(response_data.answer) == set(question.correct_answer)
            points_earned = question.points if is_correct else 0
        elif question.type == 'text':
            # Простое сравнение текста (можно улучшить)
            is_correct = response_data.answer.lower() == question.correct_answer.lower()
            points_earned = question.points if is_correct else 0
        elif question.type == 'code':
            # Здесь должна быть логика проверки кода
            pass

        if is_correct:
            correct_answers += 1
        total_points += points_earned

        # Сохраняем ответ
        response = QuestionResponse(
            attempt_id=attempt.id,
            question_id=question.id,
            answer=response_data.answer,
            is_correct=is_correct,
            points_earned=points_earned
        )
        db.add(response)

    # Обновляем попытку
    score_percentage = (total_points / max_points * 100) if max_points > 0 else 0
    passed = score_percentage >= quiz.passing_score

    attempt.completed_at = datetime.utcnow()
    attempt.score = total_points
    attempt.max_score = max_points
    attempt.passed = passed

    db.commit()
    db.refresh(attempt)

    # Формируем результат
    result = QuizResult(
        attempt=attempt,
        total_questions=len(quiz.questions),
        correct_answers=correct_answers,
        score_percentage=score_percentage,
        passed=passed,
        feedback=("Congratulations! You passed the quiz!"
                  if passed else "Keep practicing and try again!")
    )

    return result