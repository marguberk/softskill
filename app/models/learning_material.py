from sqlalchemy import Column, Integer, String, Text, DateTime, Enum, Boolean
from sqlalchemy.sql import func
import enum
from app.db.base import Base

class MaterialType(str, enum.Enum):
    VIDEO = "video"
    ARTICLE = "article" 
    TUTORIAL = "tutorial"

class DifficultyLevel(str, enum.Enum):
    BEGINNER = "beginner"
    INTERMEDIATE = "intermediate"
    ADVANCED = "advanced"

class SkillType(str, enum.Enum):
    COMMUNICATION = "communication"
    LEADERSHIP = "leadership"
    PROBLEM_SOLVING = "problem_solving"
    TIME_MANAGEMENT = "time_management"
    EMOTIONAL_INTELLIGENCE = "emotional_intelligence"
    TEAMWORK = "teamwork"

class LearningMaterial(Base):
    __tablename__ = "learning_materials"

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String(255), nullable=False)
    description = Column(Text)
    content_type = Column(Enum(MaterialType), nullable=False)
    skill_type = Column(Enum(SkillType), nullable=False)
    difficulty_level = Column(Enum(DifficultyLevel), nullable=False)
    duration_minutes = Column(Integer)
    author = Column(String(100))
    
    # Контент
    theory_content = Column(Text)  # Markdown содержимое
    video_url = Column(String(500))
    video_id = Column(String(100))  # ID для YouTube
    source_url = Column(String(500))
    
    # Метаданные
    is_published = Column(Boolean, default=False)
    created_at = Column(DateTime(timezone=True), server_default=func.now())
    updated_at = Column(DateTime(timezone=True), onupdate=func.now())

class LearningTask(Base):
    __tablename__ = "learning_tasks"
    
    id = Column(Integer, primary_key=True, index=True)
    material_id = Column(Integer, nullable=False)  # Пока без ForeignKey
    title = Column(String(255), nullable=False)
    description = Column(Text)
    order_position = Column(Integer, default=0)
    created_at = Column(DateTime(timezone=True), server_default=func.now()) 