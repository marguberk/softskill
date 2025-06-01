from sqlalchemy import Column, Integer, String, Text, DateTime, Boolean, ForeignKey, Enum, Float
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from app.db.base import Base
from app.models.skills import SkillCategory
import enum


class TaskType(str, enum.Enum):
    """Типы заданий"""
    COMMUNICATION = "communication"
    LEADERSHIP = "leadership"
    TEAMWORK = "teamwork"
    PROBLEM_SOLVING = "problem_solving"
    TIME_MANAGEMENT = "time_management"
    EMOTIONAL_INTELLIGENCE = "emotional_intelligence"


class TaskDifficulty(str, enum.Enum):
    """Уровни сложности заданий"""
    EASY = "easy"
    MEDIUM = "medium"
    HARD = "hard"


class DailyTask(Base):
    """Модель ежедневного задания"""
    __tablename__ = "daily_tasks"

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String(200), nullable=False)
    description = Column(Text, nullable=False)
    task_type = Column(Enum(TaskType), nullable=False)
    difficulty = Column(Enum(TaskDifficulty), nullable=False, default=TaskDifficulty.EASY)
    points = Column(Integer, nullable=False, default=10)
    is_active = Column(Boolean, default=True)
    created_at = Column(DateTime, server_default=func.now())

    # Связи
    completions = relationship("TaskCompletion", back_populates="task")


class TaskCompletion(Base):
    """Модель выполнения задания пользователем"""
    __tablename__ = "task_completions"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    task_id = Column(Integer, ForeignKey("daily_tasks.id"), nullable=False)
    completed_at = Column(DateTime, server_default=func.now())
    points_earned = Column(Integer, nullable=False)
    
    # Связи
    user = relationship("User", back_populates="task_completions")
    task = relationship("DailyTask", back_populates="completions")


class UserDailyTaskAssignment(Base):
    """Модель назначения ежедневных заданий пользователю"""
    __tablename__ = "user_daily_task_assignments"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    task_id = Column(Integer, ForeignKey("daily_tasks.id"), nullable=False)
    assigned_date = Column(DateTime, server_default=func.now())
    is_completed = Column(Boolean, default=False)
    completed_at = Column(DateTime, nullable=True)

    # Связи
    user = relationship("User")
    task = relationship("DailyTask")


class UserLevel(Base):
    """Модель уровня пользователя"""
    __tablename__ = "user_levels"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False, unique=True)
    total_points = Column(Integer, default=0)
    current_level = Column(Integer, default=1)
    points_to_next_level = Column(Integer, default=100)
    
    # Связи
    user = relationship("User", back_populates="level") 