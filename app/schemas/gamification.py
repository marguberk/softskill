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

class XPGainResult(BaseModel):
    """Результат начисления XP"""
    xp_gained: int
    total_xp: int
    old_level: int
    new_level: int
    level_up: bool
    reason: str
    
    class Config:
        from_attributes = True


class LevelUpResult(BaseModel):
    """Результат повышения уровня"""
    old_level: int
    new_level: int
    rewards: List[str] = []
    unlocked_features: List[str] = []
    
    class Config:
        from_attributes = True


class SkillProgressResult(BaseModel):
    """Результат прогресса навыка"""
    skill_name: str
    old_score: int
    new_score: int
    old_level: str
    new_level: str
    level_up: bool
    courses_completed: int
    
    class Config:
        from_attributes = True


class ProgressSummary(BaseModel):
    """Сводка прогресса пользователя"""
    level: int
    current_xp: int
    xp_to_next_level: int
    overall_progress: int  # Процент от максимального уровня
    courses_completed: int
    lessons_completed: int
    perfect_scores: int
    current_streak: int
    longest_streak: int
    
    class Config:
        from_attributes = True


class CourseCompletionResult(BaseModel):
    """Результат завершения курса"""
    course_id: int
    course_title: str
    xp_result: XPGainResult
    skill_result: SkillProgressResult
    achievements: List[str] = []
    completion_message: str
    
    class Config:
        from_attributes = True


class LessonCompletionResult(BaseModel):
    """Результат завершения урока"""
    lesson_id: int
    lesson_title: str
    xp_result: XPGainResult
    achievements: List[str] = []
    
    class Config:
        from_attributes = True


class DashboardProgress(BaseModel):
    """Прогресс для дашборда"""
    level: int
    level_name: str
    current_xp: int
    next_level_xp: int
    progress_percentage: int
    total_courses: int
    completed_courses: int
    skills_summary: List[dict] = []
    recent_achievements: List[dict] = []
    
    class Config:
        from_attributes = True