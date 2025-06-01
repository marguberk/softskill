from pydantic import BaseModel
from typing import List, Optional, Union
from datetime import datetime
from app.models.skills import SkillCategory, SkillLevel

# Базовые схемы для навыков
class SoftSkillBase(BaseModel):
    name: str
    category: SkillCategory
    description: Optional[str] = None

class SoftSkillCreate(SoftSkillBase):
    pass

class SoftSkill(SoftSkillBase):
    id: int
    created_at: datetime

    class Config:
        from_attributes = True

# Схемы для вопросов
class QuestionOptionBase(BaseModel):
    option_text: str
    score_weight: int = 1
    order_index: int = 0

class QuestionOptionCreate(QuestionOptionBase):
    pass

class QuestionOption(QuestionOptionBase):
    id: int

    class Config:
        from_attributes = True

class SkillQuestionBase(BaseModel):
    question_text: str
    question_type: str = "multiple_choice"
    order_index: int = 0

class SkillQuestionCreate(SkillQuestionBase):
    skill_id: int
    options: List[QuestionOptionCreate] = []

class SkillQuestion(SkillQuestionBase):
    id: int
    skill_id: int
    is_active: bool
    created_at: datetime
    options: List[QuestionOption] = []

    class Config:
        from_attributes = True

# Схемы для ответов пользователей
class UserAnswerCreate(BaseModel):
    question_id: int
    selected_option_id: Optional[int] = None
    text_answer: Optional[str] = None
    scale_value: Optional[int] = None

class UserAnswer(UserAnswerCreate):
    id: int
    assessment_id: int
    answered_at: datetime

    class Config:
        from_attributes = True

# Схемы для тестирования
class SkillAssessmentCreate(BaseModel):
    pass

class SkillAssessmentUpdate(BaseModel):
    answers: List[UserAnswerCreate]

class UserSkillResult(BaseModel):
    skill_id: int
    skill_name: str
    skill_category: SkillCategory
    score: int
    level: SkillLevel
    recommendations: Optional[str] = None

    class Config:
        from_attributes = True

class SkillAssessment(BaseModel):
    id: int
    user_id: int
    is_completed: bool
    started_at: datetime
    completed_at: Optional[datetime] = None
    total_score: int
    skill_results: List[UserSkillResult] = []

    class Config:
        from_attributes = True

# Схемы для начала и прохождения теста
class AssessmentStart(BaseModel):
    message: str
    assessment_id: int
    total_questions: int

class AssessmentQuestion(BaseModel):
    id: int
    question_text: str
    question_type: str
    skill_category: SkillCategory
    options: List[QuestionOption] = []
    current_question: int
    total_questions: int

class AssessmentSubmit(BaseModel):
    assessment_id: int
    answers: List[UserAnswerCreate]

class AssessmentResult(BaseModel):
    assessment_id: int
    total_score: int
    skill_results: List[UserSkillResult]
    recommendations: List[str]
    completion_message: str

# Схема для проверки необходимости прохождения теста
class AssessmentStatus(BaseModel):
    needs_assessment: bool
    has_completed_assessment: bool
    last_assessment_date: Optional[datetime] = None
    message: str 