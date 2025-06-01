from pydantic import BaseModel, Field
from typing import Optional, List, Dict, Any
from datetime import datetime
from enum import Enum

class ActionType(str, Enum):
    LESSON_COMPLETE = "lesson_complete"
    COURSE_COMPLETE = "course_complete"
    QUIZ_COMPLETE = "quiz_complete"
    PERFECT_SCORE = "perfect_score"
    DAILY_LOGIN = "daily_login"
    STREAK_MILESTONE = "streak_milestone"
    HELP_OTHERS = "help_others"
    FIRST_COURSE = "first_course"

class UserGameProfileBase(BaseModel):
    level: int = 1
    experience: int = 0
    total_points: int = 0
    courses_completed: int = 0
    lessons_completed: int = 0
    perfect_scores: int = 0
    login_streak: int = 0
    longest_streak: int = 0
    badges: List[str] = Field(default_factory=list)
    titles: List[str] = Field(default_factory=list)

class UserGameProfile(UserGameProfileBase):
    id: int
    user_id: int
    last_login: Optional[datetime] = None
    last_action: Optional[datetime] = None
    created_at: datetime
    updated_at: Optional[datetime] = None

    class Config:
        from_attributes = True

class UserActivityBase(BaseModel):
    action_type: ActionType
    points_earned: int = 0
    exp_earned: int = 0
    action_details: Optional[Dict[str, Any]] = None

class UserActivity(UserActivityBase):
    id: int
    profile_id: int
    created_at: datetime

    class Config:
        from_attributes = True

class RewardBase(BaseModel):
    title: str
    description: Optional[str] = None
    reward_type: str
    image_url: Optional[str] = None
    required_level: int = 0
    required_points: int = 0

class RewardCreate(RewardBase):
    pass

class Reward(RewardBase):
    id: int
    created_at: datetime

    class Config:
        from_attributes = True

class LeaderboardEntry(BaseModel):
    user_id: int
    user_name: str
    score: int
    rank: int
    level: int
    badges: List[str] = []

    class Config:
        from_attributes = True

class LevelProgress(BaseModel):
    current_level: int
    current_exp: int
    exp_to_next_level: int
    progress_percentage: float
    total_exp_needed: int