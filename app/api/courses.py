from typing import List, Optional
from fastapi import APIRouter, Depends, HTTPException, status, Query
from sqlalchemy.orm import Session
from app.db.base import get_db
from app.models.course import Course, Module, Lesson
from app.models.user import User
from app.schemas.course import CourseCreate, Course as CourseSchema, Module as ModuleSchema
from app.api.deps import get_current_user

router = APIRouter()


@router.post("/", response_model=CourseSchema)
async def create_course(
        *,
        db: Session = Depends(get_db),
        course_in: CourseCreate,
        current_user: User = Depends(get_current_user)
) -> Course:
    """
    Создание нового курса.
    """
    course = Course(
        **course_in.dict(exclude={'modules'}),
        author_id=current_user.id
    )

    # Добавляем модули если они есть
    if course_in.modules:
        for module_data in course_in.modules:
            module = Module(
                **module_data.dict(exclude={'lessons'}),
                course=course
            )
            if module_data.lessons:
                for lesson_data in module_data.lessons:
                    lesson = Lesson(**lesson_data.dict(), module=module)
                    db.add(lesson)
            db.add(module)

    db.add(course)
    db.commit()
    db.refresh(course)
    return course


@router.get("/", response_model=List[CourseSchema])
async def get_courses(
        db: Session = Depends(get_db),
        skip: int = 0,
        limit: int = 100,
        status: Optional[str] = None,
        current_user: User = Depends(get_current_user)
) -> List[Course]:
    """
    Получение списка курсов.
    """
    query = db.query(Course)

    if status:
        query = query.filter(Course.status == status)

    if current_user.role != "admin":
        # Обычные пользователи видят только опубликованные курсы
        query = query.filter(Course.status == "published")

    courses = query.offset(skip).limit(limit).all()
    return courses


@router.get("/{course_id}", response_model=CourseSchema)
async def get_course(
        course_id: int,
        db: Session = Depends(get_db),
        current_user: User = Depends(get_current_user)
) -> Course:
    """
    Получение информации о конкретном курсе.
    """
    course = db.query(Course).filter(Course.id == course_id).first()
    if not course:
        raise HTTPException(status_code=404, detail="Course not found")

    if (course.status != "published" and
            current_user.role != "admin" and
            course.author_id != current_user.id):
        raise HTTPException(status_code=403, detail="Access denied")

    return course


@router.put("/{course_id}", response_model=CourseSchema)
async def update_course(
        course_id: int,
        course_in: CourseCreate,
        db: Session = Depends(get_db),
        current_user: User = Depends(get_current_user)
) -> Course:
    """
    Обновление информации о курсе.
    """
    course = db.query(Course).filter(Course.id == course_id).first()
    if not course:
        raise HTTPException(status_code=404, detail="Course not found")

    if course.author_id != current_user.id and current_user.role != "admin":
        raise HTTPException(status_code=403, detail="Access denied")

    for field, value in course_in.dict(exclude={'modules'}).items():
        setattr(course, field, value)

    db.commit()
    db.refresh(course)
    return course


@router.delete("/{course_id}")
async def delete_course(
        course_id: int,
        db: Session = Depends(get_db),
        current_user: User = Depends(get_current_user)
) -> dict:
    """
    Удаление курса.
    """
    course = db.query(Course).filter(Course.id == course_id).first()
    if not course:
        raise HTTPException(status_code=404, detail="Course not found")

    if course.author_id != current_user.id and current_user.role != "admin":
        raise HTTPException(status_code=403, detail="Access denied")

    db.delete(course)
    db.commit()
    return {"message": "Course deleted successfully"}