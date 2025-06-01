from pydantic import BaseModel
from typing import List, Optional
from datetime import datetime
from app.models.learning_material import MaterialType, DifficultyLevel, SkillType

class LearningTaskBase(BaseModel):
    title: str
    description: str
    order_position: int = 0

class LearningTaskCreate(LearningTaskBase):
    pass

class LearningTask(LearningTaskBase):
    id: int
    material_id: int
    created_at: datetime

    class Config:
        from_attributes = True

class LearningMaterialBase(BaseModel):
    title: str
    description: Optional[str] = None
    content_type: MaterialType
    skill_type: SkillType
    difficulty_level: DifficultyLevel
    duration_minutes: Optional[int] = None
    author: Optional[str] = None
    theory_content: Optional[str] = None
    video_url: Optional[str] = None
    video_id: Optional[str] = None
    source_url: Optional[str] = None
    is_published: bool = False

class LearningMaterialCreate(LearningMaterialBase):
    tasks: List[LearningTaskCreate] = []

class LearningMaterialUpdate(BaseModel):
    title: Optional[str] = None
    description: Optional[str] = None
    content_type: Optional[MaterialType] = None
    skill_type: Optional[SkillType] = None
    difficulty_level: Optional[DifficultyLevel] = None
    duration_minutes: Optional[int] = None
    author: Optional[str] = None
    theory_content: Optional[str] = None
    video_url: Optional[str] = None
    video_id: Optional[str] = None
    source_url: Optional[str] = None
    is_published: Optional[bool] = None

class LearningMaterial(LearningMaterialBase):
    id: int
    created_at: datetime
    updated_at: Optional[datetime] = None
    tasks: List[LearningTask] = []

    class Config:
        from_attributes = True

class LearningMaterialList(BaseModel):
    id: int
    title: str
    description: Optional[str]
    content_type: MaterialType
    skill_type: SkillType
    difficulty_level: DifficultyLevel
    duration_minutes: Optional[int]
    author: Optional[str]
    theory_content: Optional[str] = None
    video_url: Optional[str] = None
    video_id: Optional[str] = None
    source_url: Optional[str] = None
    is_published: bool
    created_at: datetime

    class Config:
        from_attributes = True 