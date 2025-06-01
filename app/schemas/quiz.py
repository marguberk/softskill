from pydantic import BaseModel, Field
from typing import Optional, List, Dict, Any, Union
from datetime import datetime

class QuestionBase(BaseModel):
    type: str
    text: str
    options: Optional[List[str]] = None
    correct_answer: Union[str, List[str]]
    points: float = 1.0
    explanation: Optional[str] = None
    code_template: Optional[str] = None
    test_cases: Optional[List[Dict[str, Any]]] = None

class QuestionCreate(QuestionBase):
    pass

class Question(QuestionBase):
    id: int
    quiz_id: int
    created_at: datetime

    class Config:
        from_attributes = True

class QuizBase(BaseModel):
    title: str
    description: Optional[str] = None
    time_limit: Optional[int] = None
    passing_score: float = 70.0
    attempts_allowed: int = 3
    is_randomized: bool = False

class QuizCreate(QuizBase):
    questions: List[QuestionCreate]

class Quiz(QuizBase):
    id: int
    lesson_id: int
    questions: List[Question]
    created_at: datetime
    updated_at: Optional[datetime] = None

    class Config:
        from_attributes = True

class QuestionResponseBase(BaseModel):
    question_id: int
    answer: Union[str, List[str]]

class QuestionResponseCreate(QuestionResponseBase):
    pass

class QuestionResponse(QuestionResponseBase):
    id: int
    attempt_id: int
    is_correct: bool
    points_earned: float
    feedback: Optional[str] = None
    created_at: datetime

    class Config:
        from_attributes = True

class QuizAttemptBase(BaseModel):
    quiz_id: int

class QuizAttemptCreate(QuizAttemptBase):
    pass

class QuizAttempt(QuizAttemptBase):
    id: int
    user_id: int
    started_at: datetime
    completed_at: Optional[datetime] = None
    score: Optional[float] = None
    max_score: Optional[float] = None
    passed: bool = False
    responses: List[QuestionResponse] = []

    class Config:
        from_attributes = True

class SubmitQuizResponse(BaseModel):
    attempt_id: int
    responses: List[QuestionResponseCreate]

class QuizResult(BaseModel):
    attempt: QuizAttempt
    total_questions: int
    correct_answers: int
    score_percentage: float
    passed: bool
    feedback: str