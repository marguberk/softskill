from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from typing import List

from app.db.base import get_db
from app.core.auth import get_current_user
from app.models.user import User
from app.schemas.tasks import (
    DailyTasksPageResponse, 
    CompleteTaskRequest, 
    CompleteTaskResponse,
    UserLevelResponse
)
from app.services.tasks import TasksService

router = APIRouter()


@router.get("/daily", response_model=DailyTasksPageResponse)
async def get_daily_tasks_page(
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Получить данные для страницы ежедневных заданий"""
    service = TasksService(db)
    return service.get_daily_tasks_page_data(current_user.id)


@router.post("/complete", response_model=CompleteTaskResponse)
async def complete_task(
    request: CompleteTaskRequest,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Отметить задание как выполненное"""
    service = TasksService(db)
    result = service.complete_task(current_user.id, request.task_id)
    
    if not result.success:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail=result.message
        )
    
    return result


@router.get("/level", response_model=UserLevelResponse)
async def get_user_level(
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Получить уровень пользователя"""
    service = TasksService(db)
    user_level = service.get_or_create_user_level(current_user.id)
    return user_level 