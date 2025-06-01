from pydantic import BaseModel, Field
from typing import Optional, List
from datetime import datetime
from enum import Enum

class LessonStatus(str, Enum):
    NOT_STARTED = "not_started"
    IN_PROGRESS = "in_progress"
    COMPLETED = "completed"

class LessonProgressBase(BaseModel):
    status: LessonStatus = LessonStatus.NOT_STARTED
    score: Optional[float] = None
    time_spent: int = 0
    notes: Optional[str] = None
    last_position: int = 0

class LessonProgressCreate(LessonProgressBase):
    pass

class LessonProgress(LessonProgressBase):
    id: int
    user_progress_id: int
    lesson_id: int
    completed_at: Optional[datetime] = None
    created_at: datetime
    updated_at: Optional[datetime] = None

    class Config:
        from_attributes = True

class UserProgressBase(BaseModel):
    completed_lessons: int = 0
    total_lessons: int = 0
    progress_percentage: float = 0.0
    total_time_spent: int = 0
    average_score: float = 0.0

class UserProgressCreate(UserProgressBase):
    course_id: int

class UserProgress(UserProgressBase):
    id: int
    user_id: int
    course_id: int
    last_accessed: Optional[datetime] = None
    lesson_progress: List[LessonProgress] = []
    created_at: datetime
    updated_at: Optional[datetime] = None

    class Config:
        from_attributes = True

class AchievementBase(BaseModel):
    title: str
    description: Optional[str] = None
    badge_image: Optional[str] = None
    required_courses: int = 0
    required_lessons: int = 0
    required_score: float = 0.0

class AchievementCreate(AchievementBase):
    pass

class Achievement(AchievementBase):
    id: int
    created_at: datetime

    class Config:
        from_attributes = True

class UserAchievementBase(BaseModel):
    achievement_id: int

class UserAchievement(UserAchievementBase):
    id: int
    user_id: int
    achieved_at: datetime
    achievement: Achievement

    class Config:
        from_attributes = True