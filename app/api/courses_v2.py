from typing import List, Optional
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from sqlalchemy import text
from app.db.base import get_db
from app.models.course import Course
from app.models.user import User
from app.core.auth import get_current_user

router = APIRouter()

@router.get("/test")
async def test_endpoint():
    """Простой тестовый эндпоинт"""
    return {"status": "ok", "message": "API работает"}

@router.get("/health")
async def health_check():
    """Проверка здоровья API без зависимостей"""
    return {"status": "healthy"}

@router.get("/")
async def get_courses(
    db: Session = Depends(get_db),
    skip: int = 0,
    limit: int = 100
):
    """Получение списка курсов (публичный доступ)"""
    try:
        # Используем raw SQL для избежания проблем с enum
        result = db.execute(text("""
            SELECT id, title, description, skill_type, difficulty_level, 
                   duration_hours, price, is_published, created_at
            FROM courses 
            WHERE is_published = 1 
            LIMIT :limit OFFSET :skip
        """), {"limit": limit, "skip": skip})
        
        courses = []
        for row in result:
            courses.append({
                "id": row[0],
                "title": row[1],
                "description": row[2],
                "skill_type": row[3],
                "difficulty_level": row[4],
                "duration_hours": row[5],
                "price": row[6],
                "is_published": bool(row[7]),
                "created_at": row[8]
            })
        
        return courses
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Ошибка получения курсов: {str(e)}")

@router.get("/{course_id}")
async def get_course(
    course_id: int,
    db: Session = Depends(get_db)
):
    """Получение детальной информации о курсе (публичный доступ для опубликованных курсов)"""
    try:
        # Используем raw SQL для получения курса
        result = db.execute(text("""
            SELECT id, title, description, skill_type, difficulty_level, 
                   duration_hours, price, is_published, created_at
            FROM courses 
            WHERE id = :course_id AND is_published = 1
        """), {"course_id": course_id})
        
        course_row = result.fetchone()
        if not course_row:
            raise HTTPException(status_code=404, detail="Курс не найден")
        
        return {
            "id": course_row[0],
            "title": course_row[1],
            "description": course_row[2],
            "skill_type": course_row[3],
            "difficulty_level": course_row[4],
            "duration_hours": course_row[5],
            "price": course_row[6],
            "is_published": bool(course_row[7]),
            "created_at": course_row[8]
        }
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Ошибка получения курса: {str(e)}")

@router.get("/{course_id}/lessons")
async def get_course_lessons(
    course_id: int,
    db: Session = Depends(get_db)
):
    """Получение списка уроков курса с заданиями"""
    try:
        # Сначала проверяем существование курса
        course_result = db.execute(text("""
            SELECT id, title FROM courses 
            WHERE id = :course_id AND is_published = 1
        """), {"course_id": course_id})
        
        course_row = course_result.fetchone()
        if not course_row:
            raise HTTPException(status_code=404, detail="Курс не найден")
        
        # Получаем уроки курса с материалами
        lessons_result = db.execute(text("""
            SELECT 
                cl.id as lesson_id,
                cl.order_position,
                cl.is_required,
                lm.id as material_id,
                lm.title,
                lm.description,
                lm.content_type,
                lm.duration_minutes,
                lm.theory_content,
                lm.video_url,
                lm.video_id,
                lm.author
            FROM course_lessons cl
            JOIN learning_materials lm ON cl.material_id = lm.id
            WHERE cl.course_id = :course_id
            ORDER BY cl.order_position
        """), {"course_id": course_id})
        
        lessons = []
        for row in lessons_result:
            # Получаем задания для каждого урока
            tasks_result = db.execute(text("""
                SELECT id, title, description, order_position
                FROM learning_tasks
                WHERE material_id = :material_id
                ORDER BY order_position
            """), {"material_id": row[3]})
            
            tasks = []
            for task_row in tasks_result:
                tasks.append({
                    "id": task_row[0],
                    "title": task_row[1],
                    "description": task_row[2],
                    "order_position": task_row[3]
                })
            
            lessons.append({
                "lesson_id": row[0],
                "order_position": row[1],
                "is_required": bool(row[2]),
                "material": {
                    "id": row[3],
                    "title": row[4],
                    "description": row[5],
                    "content_type": row[6],
                    "duration_minutes": row[7],
                    "theory_content": row[8],
                    "video_url": row[9],
                    "video_id": row[10],
                    "author": row[11]
                },
                "tasks": tasks
            })
        
        return {
            "course": {
                "id": course_row[0],
                "title": course_row[1]
            },
            "lessons": lessons,
            "total_lessons": len(lessons)
        }
        
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Ошибка получения уроков курса: {str(e)}")

@router.get("/{course_id}/lessons/{lesson_id}")
async def get_lesson_details(
    course_id: int,
    lesson_id: int,
    db: Session = Depends(get_db)
):
    """Получение детальной информации об уроке"""
    try:
        # Получаем урок с материалом
        lesson_result = db.execute(text("""
            SELECT 
                cl.id as lesson_id,
                cl.order_position,
                cl.is_required,
                lm.id as material_id,
                lm.title,
                lm.description,
                lm.content_type,
                lm.duration_minutes,
                lm.theory_content,
                lm.video_url,
                lm.video_id,
                lm.author,
                c.title as course_title
            FROM course_lessons cl
            JOIN learning_materials lm ON cl.material_id = lm.id
            JOIN courses c ON cl.course_id = c.id
            WHERE cl.course_id = :course_id AND cl.id = :lesson_id
        """), {"course_id": course_id, "lesson_id": lesson_id})
        
        lesson_row = lesson_result.fetchone()
        if not lesson_row:
            raise HTTPException(status_code=404, detail="Урок не найден")
        
        # Получаем задания
        tasks_result = db.execute(text("""
            SELECT id, title, description, order_position
            FROM learning_tasks
            WHERE material_id = :material_id
            ORDER BY order_position
        """), {"material_id": lesson_row[3]})
        
        tasks = []
        for task_row in tasks_result:
            tasks.append({
                "id": task_row[0],
                "title": task_row[1],
                "description": task_row[2],
                "order_position": task_row[3]
            })
        
        # Получаем следующий и предыдущий уроки
        nav_result = db.execute(text("""
            SELECT 
                cl.id,
                cl.order_position,
                lm.title
            FROM course_lessons cl
            JOIN learning_materials lm ON cl.material_id = lm.id
            WHERE cl.course_id = :course_id 
            AND cl.order_position IN (:prev_order, :next_order)
        """), {
            "course_id": course_id, 
            "prev_order": lesson_row[1] - 1,
            "next_order": lesson_row[1] + 1
        })
        
        prev_lesson = None
        next_lesson = None
        for nav_row in nav_result:
            if nav_row[1] == lesson_row[1] - 1:  # предыдущий урок
                prev_lesson = {
                    "id": nav_row[0],
                    "title": nav_row[2],
                    "order_position": nav_row[1]
                }
            elif nav_row[1] == lesson_row[1] + 1:  # следующий урок
                next_lesson = {
                    "id": nav_row[0],
                    "title": nav_row[2],
                    "order_position": nav_row[1]
                }
        
        return {
            "lesson_id": lesson_row[0],
            "order_position": lesson_row[1],
            "is_required": bool(lesson_row[2]),
            "course_title": lesson_row[12],
            "material": {
                "id": lesson_row[3],
                "title": lesson_row[4],
                "description": lesson_row[5],
                "content_type": lesson_row[6],
                "duration_minutes": lesson_row[7],
                "theory_content": lesson_row[8],
                "video_url": lesson_row[9],
                "video_id": lesson_row[10],
                "author": lesson_row[11]
            },
            "tasks": tasks,
            "navigation": {
                "prev_lesson": prev_lesson,
                "next_lesson": next_lesson
            }
        }
        
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Ошибка получения урока: {str(e)}") 