from pydantic import BaseModel, Field
from typing import Optional, List
from datetime import datetime
from enum import Enum

class CourseStatus(str, Enum):
    DRAFT = "draft"
    PUBLISHED = "published"
    ARCHIVED = "archived"

class LessonBase(BaseModel):
    title: str
    content: Optional[str] = None
    order: int = 0
    type: str = "text"
    duration: Optional[int] = None

class LessonCreate(LessonBase):
    pass

class Lesson(LessonBase):
    id: int
    module_id: int
    created_at: datetime
    updated_at: Optional[datetime] = None

    class Config:
        from_attributes = True

class ModuleBase(BaseModel):
    title: str
    description: Optional[str] = None
    order: int = 0

class ModuleCreate(ModuleBase):
    lessons: Optional[List[LessonCreate]] = None

class Module(ModuleBase):
    id: int
    course_id: int
    lessons: List[Lesson] = []
    created_at: datetime
    updated_at: Optional[datetime] = None

    class Config:
        from_attributes = True

class CourseBase(BaseModel):
    title: str
    description: Optional[str] = None
    image_url: Optional[str] = None
    price: float = Field(default=0.0, ge=0)
    status: CourseStatus = CourseStatus.DRAFT

class CourseCreate(CourseBase):
    modules: Optional[List[ModuleCreate]] = None

class Course(CourseBase):
    id: int
    author_id: int
    modules: List[Module] = []
    created_at: datetime
    updated_at: Optional[datetime] = None

    class Config:
        from_attributes = True