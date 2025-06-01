from sqlalchemy import Column, Integer, String, Text, DateTime, Boolean, ForeignKey, Enum
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from app.db.base import Base
import enum

class SkillCategory(str, enum.Enum):
    COMMUNICATION = "communication"
    LEADERSHIP = "leadership"
    TEAMWORK = "teamwork"
    PROBLEM_SOLVING = "problem_solving"
    TIME_MANAGEMENT = "time_management"
    ADAPTABILITY = "adaptability"
    EMOTIONAL_INTELLIGENCE = "emotional_intelligence"
    CRITICAL_THINKING = "critical_thinking"

class SkillLevel(str, enum.Enum):
    BEGINNER = "beginner"
    INTERMEDIATE = "intermediate"
    ADVANCED = "advanced"
    EXPERT = "expert"

class SoftSkill(Base):
    __tablename__ = "soft_skills"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)
    category = Column(Enum(SkillCategory), nullable=False)
    description = Column(Text)
    created_at = Column(DateTime(timezone=True), server_default=func.now())

    # Связи
    questions = relationship("SkillQuestion", back_populates="skill")
    assessments = relationship("UserSkillAssessment", back_populates="skill")

class SkillQuestion(Base):
    __tablename__ = "skill_questions"

    id = Column(Integer, primary_key=True, index=True)
    skill_id = Column(Integer, ForeignKey("soft_skills.id"), nullable=False)
    question_text = Column(Text, nullable=False)
    question_type = Column(String, default="multiple_choice")  # multiple_choice, scale, text
    is_active = Column(Boolean, default=True)
    order_index = Column(Integer, default=0)
    created_at = Column(DateTime(timezone=True), server_default=func.now())

    # Связи
    skill = relationship("SoftSkill", back_populates="questions")
    options = relationship("QuestionOption", back_populates="question")
    answers = relationship("UserAnswer", back_populates="question")

class QuestionOption(Base):
    __tablename__ = "question_options"

    id = Column(Integer, primary_key=True, index=True)
    question_id = Column(Integer, ForeignKey("skill_questions.id"), nullable=False)
    option_text = Column(Text, nullable=False)
    score_weight = Column(Integer, default=1)  # Вес ответа для подсчета баллов
    order_index = Column(Integer, default=0)

    # Связи
    question = relationship("SkillQuestion", back_populates="options")
    answers = relationship("UserAnswer", back_populates="selected_option")

class SkillAssessment(Base):
    __tablename__ = "skill_assessments"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    is_completed = Column(Boolean, default=False)
    started_at = Column(DateTime(timezone=True), server_default=func.now())
    completed_at = Column(DateTime(timezone=True))
    total_score = Column(Integer, default=0)

    # Связи
    user = relationship("User")
    answers = relationship("UserAnswer", back_populates="assessment")
    skill_results = relationship("UserSkillAssessment", back_populates="assessment")

class UserAnswer(Base):
    __tablename__ = "user_answers"

    id = Column(Integer, primary_key=True, index=True)
    assessment_id = Column(Integer, ForeignKey("skill_assessments.id"), nullable=False)
    question_id = Column(Integer, ForeignKey("skill_questions.id"), nullable=False)
    selected_option_id = Column(Integer, ForeignKey("question_options.id"))
    text_answer = Column(Text)  # Для текстовых ответов
    scale_value = Column(Integer)  # Для шкальных ответов (1-5)
    answered_at = Column(DateTime(timezone=True), server_default=func.now())

    # Связи
    assessment = relationship("SkillAssessment", back_populates="answers")
    question = relationship("SkillQuestion", back_populates="answers")
    selected_option = relationship("QuestionOption", back_populates="answers")

class UserSkillAssessment(Base):
    __tablename__ = "user_skill_assessments"

    id = Column(Integer, primary_key=True, index=True)
    assessment_id = Column(Integer, ForeignKey("skill_assessments.id"), nullable=False)
    skill_id = Column(Integer, ForeignKey("soft_skills.id"), nullable=False)
    score = Column(Integer, nullable=False)
    level = Column(Enum(SkillLevel), nullable=False)
    recommendations = Column(Text)
    created_at = Column(DateTime(timezone=True), server_default=func.now())

    # Связи
    assessment = relationship("SkillAssessment", back_populates="skill_results")
    skill = relationship("SoftSkill", back_populates="assessments") 