from typing import Optional, Dict, Any
from sqlalchemy.orm import Session
from app.models.notification import Notification, NotificationPreference, NotificationType
from app.schemas.notification import NotificationCreate
from datetime import datetime


class NotificationService:
    def __init__(self, db: Session):
        self.db = db

    async def create_notification(
            self,
            user_id: int,
            notification_type: NotificationType,
            title: str,
            message: str,
            data: Optional[Dict[str, Any]] = None,
            action_url: Optional[str] = None
    ) -> Notification:
        """Создать новое уведомление"""
        notification_data = NotificationCreate(
            user_id=user_id,
            type=notification_type,
            title=title,
            message=message,
            data=data or {},
            action_url=action_url,
            # Настройка иконки и цвета в зависимости от типа
            icon=self._get_notification_icon(notification_type),
            color=self._get_notification_color(notification_type)
        )

        notification = Notification(**notification_data.dict())
        self.db.add(notification)
        self.db.commit()
        self.db.refresh(notification)

        # Отправляем email если включено в настройках
        await self._send_email_notification(notification)

        return notification

    def _get_notification_icon(self, notification_type: NotificationType) -> str:
        """Получить иконку для типа уведомления"""
        icons = {
            NotificationType.DISCUSSION_REPLY: "message-circle",
            NotificationType.SOLUTION_MARKED: "check-circle",
            NotificationType.COURSE_UPDATE: "book-open",
            NotificationType.ACHIEVEMENT_UNLOCKED: "award",
            NotificationType.QUIZ_GRADED: "file-text",
            NotificationType.LEVEL_UP: "trending-up",
            NotificationType.NEW_REVIEW: "star",
            NotificationType.COURSE_COMPLETED: "check-square",
            NotificationType.ASSIGNMENT_DUE: "clock",
            NotificationType.SYSTEM_UPDATE: "bell"
        }
        return icons.get(notification_type, "bell")

    def _get_notification_color(self, notification_type: NotificationType) -> str:
        """Получить цвет для типа уведомления"""
        colors = {
            NotificationType.DISCUSSION_REPLY: "blue",
            NotificationType.SOLUTION_MARKED: "green",
            NotificationType.COURSE_UPDATE: "purple",
            NotificationType.ACHIEVEMENT_UNLOCKED: "yellow",
            NotificationType.QUIZ_GRADED: "orange",
            NotificationType.LEVEL_UP: "indigo",
            NotificationType.NEW_REVIEW: "pink",
            NotificationType.COURSE_COMPLETED: "green",
            NotificationType.ASSIGNMENT_DUE: "red",
            NotificationType.SYSTEM_UPDATE: "gray"
        }
        return colors.get(notification_type, "gray")

    async def _send_email_notification(self, notification: Notification):
        """Отправить email уведомление"""
        preferences = self.db.query(NotificationPreference).filter(
            NotificationPreference.user_id == notification.user_id
        ).first()

        if not preferences or not preferences.email_notifications:
            return

        # Здесь будет логика отправки email
        # Пока просто отмечаем что email отправлен
        notification.is_email_sent = True
        self.db.commit()

    def mark_as_read(self, notification_id: int, user_id: int) -> bool:
        """Отметить уведомление как прочитанное"""
        notification = self.db.query(Notification).filter(
            Notification.id == notification_id,
            Notification.user_id == user_id
        ).first()

        if notification and not notification.is_read:
            notification.is_read = True
            notification.read_at = datetime.utcnow()
            self.db.commit()
            return True
        return False

    def mark_all_as_read(self, user_id: int) -> int:
        """Отметить все уведомления пользователя как прочитанные"""
        result = self.db.query(Notification).filter(
            Notification.user_id == user_id,
            Notification.is_read == False
        ).update({
            Notification.is_read: True,
            Notification.read_at: datetime.utcnow()
        })
        self.db.commit()
        return result

    def get_or_create_preferences(self, user_id: int) -> NotificationPreference:
        """Получить или создать настройки уведомлений пользователя"""
        preferences = self.db.query(NotificationPreference).filter(
            NotificationPreference.user_id == user_id
        ).first()

        if not preferences:
            preferences = NotificationPreference(user_id=user_id)
            self.db.add(preferences)
            self.db.commit()
            self.db.refresh(preferences)

        return preferences

    def should_notify(self, user_id: int, notification_type: NotificationType) -> bool:
        """Проверить, нужно ли отправлять уведомление"""
        preferences = self.get_or_create_preferences(user_id)

        type_mapping = {
            NotificationType.DISCUSSION_REPLY: preferences.discussion_replies,
            NotificationType.SOLUTION_MARKED: preferences.solution_marked,
            NotificationType.COURSE_UPDATE: preferences.course_updates,
            NotificationType.ACHIEVEMENT_UNLOCKED: preferences.achievements,
            NotificationType.QUIZ_GRADED: preferences.quiz_results,
            NotificationType.LEVEL_UP: preferences.level_ups,
            NotificationType.NEW_REVIEW: preferences.reviews,
            NotificationType.COURSE_COMPLETED: preferences.course_completion,
            NotificationType.ASSIGNMENT_DUE: preferences.assignment_reminders,
            NotificationType.SYSTEM_UPDATE: preferences.system_updates
        }

        return type_mapping.get(notification_type, True)