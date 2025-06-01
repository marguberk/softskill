from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List
from app.db.base import get_db
from app.models.user import User
from app.services.notification import NotificationService
from app.schemas.notification import (
    Notification,
    NotificationPreference,
    NotificationPreferenceUpdate,
    NotificationCounter
)
from app.api.deps import get_current_user

router = APIRouter()


@router.get("/", response_model=List[Notification])
async def get_notifications(
        skip: int = 0,
        limit: int = 50,
        unread_only: bool = False,
        db: Session = Depends(get_db),
        current_user: User = Depends(get_current_user)
):
    """Получить уведомления пользователя"""
    query = db.query(Notification).filter(
        Notification.user_id == current_user.id
    )

    if unread_only:
        query = query.filter(Notification.is_read == False)

    notifications = query.order_by(
        Notification.created_at.desc()
    ).offset(skip).limit(limit).all()

    return notifications


@router.get("/count", response_model=NotificationCounter)
async def get_notification_count(
        db: Session = Depends(get_db),
        current_user: User = Depends(get_current_user)
):
    """Получить количество уведомлений"""
    total = db.query(Notification).filter(
        Notification.user_id == current_user.id
    ).count()

    unread = db.query(Notification).filter(
        Notification.user_id == current_user.id,
        Notification.is_read == False
    ).count()

    return NotificationCounter(total=total, unread=unread)


@router.post("/{notification_id}/read")
async def mark_notification_read(
        notification_id: int,
        db: Session = Depends(get_db),
        current_user: User = Depends(get_current_user)
):
    """Отметить уведомление как прочитанное"""
    notification_service = NotificationService(db)
    success = notification_service.mark_as_read(notification_id, current_user.id)

    if not success:
        raise HTTPException(status_code=404, detail="Notification not found")

    return {"message": "Notification marked as read"}


@router.post("/read-all")
async def mark_all_notifications_read(
        db: Session = Depends(get_db),
        current_user: User = Depends(get_current_user)
):
    """Отметить все уведомления как прочитанные"""
    notification_service = NotificationService(db)
    count = notification_service.mark_all_as_read(current_user.id)
    return {"message": f"{count} notifications marked as read"}


@router.get("/preferences", response_model=NotificationPreference)
async def get_notification_preferences(
        db: Session = Depends(get_db),
        current_user: User = Depends(get_current_user)
):
    """Получить настройки уведомлений"""
    notification_service = NotificationService(db)
    preferences = notification_service.get_or_create_preferences(current_user.id)
    return preferences


@router.put("/preferences", response_model=NotificationPreference)
async def update_notification_preferences(
        preferences: NotificationPreferenceUpdate,
        db: Session = Depends(get_db),
        current_user: User = Depends(get_current_user)
):
    """Обновить настройки уведомлений"""
    notification_service = NotificationService(db)
    user_preferences = notification_service.get_or_create_preferences(current_user.id)

    for field, value in preferences.dict().items():
        setattr(user_preferences, field, value)

    db.commit()
    db.refresh(user_preferences)
    return user_preferences


@router.delete("/{notification_id}")
async def delete_notification(
        notification_id: int,
        db: Session = Depends(get_db),
        current_user: User = Depends(get_current_user)
):
    """Удалить уведомление"""
    notification = db.query(Notification).filter(
        Notification.id == notification_id,
        Notification.user_id == current_user.id
    ).first()

    if not notification:
        raise HTTPException(status_code=404, detail="Notification not found")

    db.delete(notification)
    db.commit()
    return {"message": "Notification deleted"}


@router.delete("/")
async def delete_all_notifications(
        db: Session = Depends(get_db),
        current_user: User = Depends(get_current_user)
):
    """Удалить все уведомления пользователя"""
    db.query(Notification).filter(
        Notification.user_id == current_user.id
    ).delete()

    db.commit()
    return {"message": "All notifications deleted"}