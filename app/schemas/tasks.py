from pydantic import BaseModel
from datetime import datetime
from typing import List, Optional
from app.models.tasks import TaskType, TaskDifficulty


class DailyTaskBase(BaseModel):
    title: str
    description: str
    task_type: TaskType
    difficulty: TaskDifficulty
    points: int


class DailyTaskCreate(DailyTaskBase):
    pass


class DailyTaskResponse(DailyTaskBase):
    id: int
    is_active: bool
    created_at: datetime
    
    class Config:
        from_attributes = True


class TaskCompletionResponse(BaseModel):
    id: int
    task_id: int
    completed_at: datetime
    points_earned: int
    task: DailyTaskResponse
    
    class Config:
        from_attributes = True


class UserDailyTaskAssignmentResponse(BaseModel):
    id: int
    task_id: int
    assigned_date: datetime
    is_completed: bool
    completed_at: Optional[datetime]
    task: DailyTaskResponse
    
    class Config:
        from_attributes = True


class UserLevelResponse(BaseModel):
    user_id: int
    total_points: int
    current_level: int
    points_to_next_level: int
    
    class Config:
        from_attributes = True


class DailyTasksPageResponse(BaseModel):
    today_tasks: List[UserDailyTaskAssignmentResponse]
    user_level: UserLevelResponse
    recent_completions: List[TaskCompletionResponse]


class CompleteTaskRequest(BaseModel):
    task_id: int


class CompleteTaskResponse(BaseModel):
    success: bool
    points_earned: int
    new_level: Optional[int]
    message: str 