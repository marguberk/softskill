from sqlalchemy import Column, Integer, String, Text, ForeignKey, DateTime, Boolean, Enum, JSON
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from app.db.base import Base
import enum


class NotificationType(str, enum.Enum):
    DISCUSSION_REPLY = "discussion_reply"
    SOLUTION_MARKED = "solution_marked"
    COURSE_UPDATE = "course_update"
    ACHIEVEMENT_UNLOCKED = "achievement_unlocked"
    QUIZ_GRADED = "quiz_graded"
    LEVEL_UP = "level_up"
    NEW_REVIEW = "new_review"
    COURSE_COMPLETED = "course_completed"
    ASSIGNMENT_DUE = "assignment_due"
    SYSTEM_UPDATE = "system_update"


class Notification(Base):
    __tablename__ = "notifications"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"))
    type = Column(Enum(NotificationType))
    title = Column(String, nullable=False)
    message = Column(Text, nullable=False)

    # Дополнительные данные (например, ID связанного контента)
    data = Column(JSON, default=dict)

    # Статус уведомления
    is_read = Column(Boolean, default=False)
    is_email_sent = Column(Boolean, default=False)

    # Настройки отображения
    icon = Column(String)
    color = Column(String)
    action_url = Column(String)

    # Временные метки
    created_at = Column(DateTime(timezone=True), server_default=func.now())
    read_at = Column(DateTime(timezone=True))

    # Связи
    user = relationship("User", back_populates="notifications")


class NotificationPreference(Base):
    __tablename__ = "notification_preferences"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"))

    # Типы уведомлений
    discussion_replies = Column(Boolean, default=True)
    solution_marked = Column(Boolean, default=True)
    course_updates = Column(Boolean, default=True)
    achievements = Column(Boolean, default=True)
    quiz_results = Column(Boolean, default=True)
    level_ups = Column(Boolean, default=True)
    reviews = Column(Boolean, default=True)
    course_completion = Column(Boolean, default=True)
    assignment_reminders = Column(Boolean, default=True)
    system_updates = Column(Boolean, default=True)

    # Каналы уведомлений
    email_notifications = Column(Boolean, default=True)
    push_notifications = Column(Boolean, default=True)

    # Частота email-дайджестов
    email_digest_frequency = Column(String, default="daily")  # daily, weekly, never

    user = relationship("User", back_populates="notification_preferences")

    created_at = Column(DateTime(timezone=True), server_default=func.now())
    updated_at = Column(DateTime(timezone=True), onupdate=func.now())