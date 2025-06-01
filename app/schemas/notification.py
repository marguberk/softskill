from pydantic import BaseModel
from typing import Optional, Dict, Any
from datetime import datetime
from enum import Enum

class NotificationType(str, Enum):
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

class NotificationBase(BaseModel):
    type: NotificationType
    title: str
    message: str
    data: Optional[Dict[str, Any]] = None
    icon: Optional[str] = None
    color: Optional[str] = None
    action_url: Optional[str] = None

class NotificationCreate(NotificationBase):
    user_id: int

class Notification(NotificationBase):
    id: int
    is_read: bool = False
    is_email_sent: bool = False
    created_at: datetime
    read_at: Optional[datetime] = None

    class Config:
        from_attributes = True

class NotificationPreferenceBase(BaseModel):
    discussion_replies: bool = True
    solution_marked: bool = True
    course_updates: bool = True
    achievements: bool = True
    quiz_results: bool = True
    level_ups: bool = True
    reviews: bool = True
    course_completion: bool = True
    assignment_reminders: bool = True
    system_updates: bool = True
    email_notifications: bool = True
    push_notifications: bool = True
    email_digest_frequency: str = "daily"

class NotificationPreferenceUpdate(NotificationPreferenceBase):
    pass

class NotificationPreference(NotificationPreferenceBase):
    id: int
    user_id: int
    created_at: datetime
    updated_at: Optional[datetime] = None

    class Config:
        from_attributes = True

class NotificationCounter(BaseModel):
    total: int
    unread: int