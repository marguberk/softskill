from pydantic import BaseModel, Field
from typing import Optional, List, Dict, Any
from datetime import datetime
from enum import Enum

class SkillType(str, Enum):
    COMMUNICATION = "communication"
    LEADERSHIP = "leadership"
    PROBLEM_SOLVING = "problem_solving"
    TIME_MANAGEMENT = "time_management"
    EMOTIONAL_INTELLIGENCE = "emotional_intelligence"
    TEAMWORK = "teamwork"

class DifficultyLevel(str, Enum):
    BEGINNER = "beginner"
    INTERMEDIATE = "intermediate"
    ADVANCED = "advanced"

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
    skill_type: SkillType
    difficulty_level: DifficultyLevel
    duration_hours: Optional[int] = None
    price: float = Field(default=0.0, ge=0)
    is_published: bool = False

class CourseCreate(CourseBase):
    pass

class CourseUpdate(BaseModel):
    title: Optional[str] = None
    description: Optional[str] = None
    skill_type: Optional[SkillType] = None
    difficulty_level: Optional[DifficultyLevel] = None
    duration_hours: Optional[int] = None
    price: Optional[float] = None
    is_published: Optional[bool] = None

class Course(CourseBase):
    id: int
    author_id: int
    created_at: datetime
    updated_at: Optional[datetime] = None

    class Config:
        from_attributes = True

class CourseLessonBase(BaseModel):
    material_id: int
    order_position: int = 0
    is_required: bool = True

class CourseLessonCreate(CourseLessonBase):
    pass

class CourseLesson(CourseLessonBase):
    id: int
    course_id: int
    created_at: datetime

    class Config:
        from_attributes = True

class CourseEnrollmentBase(BaseModel):
    course_id: int

class CourseEnrollmentCreate(CourseEnrollmentBase):
    pass

class CourseEnrollment(CourseEnrollmentBase):
    id: int
    user_id: int
    enrolled_at: datetime
    is_active: bool

    class Config:
        from_attributes = True

class CourseExamBase(BaseModel):
    title: str
    description: Optional[str] = None
    passing_score: int = Field(default=70, ge=0, le=100)
    time_limit_minutes: int = Field(default=30, ge=1)
    questions: Dict[str, Any]

class CourseExamCreate(CourseExamBase):
    course_id: int

class CourseExam(CourseExamBase):
    id: int
    course_id: int
    created_at: datetime
    updated_at: Optional[datetime] = None

    class Config:
        from_attributes = True

class ExamAttemptBase(BaseModel):
    answers: Dict[str, Any]

class ExamAttemptCreate(ExamAttemptBase):
    exam_id: int

class ExamAttempt(ExamAttemptBase):
    id: int
    user_id: int
    exam_id: int
    score: Optional[int] = None
    passed: bool = False
    started_at: datetime
    completed_at: Optional[datetime] = None

    class Config:
        from_attributes = True

class CourseCompletionBase(BaseModel):
    final_score: Optional[int] = None

class CourseCompletion(CourseCompletionBase):
    id: int
    user_id: int
    course_id: int
    completed_at: datetime

    class Config:
        from_attributes = True

class CertificateBase(BaseModel):
    certificate_number: str
    template_data: Dict[str, Any]

class Certificate(CertificateBase):
    id: int
    completion_id: int
    issued_at: datetime

    class Config:
        from_attributes = True

class CourseWithLessons(Course):
    course_lessons: List[CourseLesson] = []

class CourseWithDetails(Course):
    course_lessons: List[CourseLesson] = []
    exams: List[CourseExam] = []
    enrollments_count: Optional[int] = None
    completions_count: Optional[int] = None