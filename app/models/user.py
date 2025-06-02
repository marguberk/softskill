from sqlalchemy import Boolean, Column, Integer, String, DateTime
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from app.db.base import Base

class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    email = Column(String, unique=True, index=True, nullable=False)
    hashed_password = Column(String, nullable=False)
    full_name = Column(String)
    role = Column(String, nullable=False, default="student")
    is_active = Column(Boolean, default=True)
    created_at = Column(DateTime(timezone=True), server_default=func.now())
    updated_at = Column(DateTime(timezone=True), onupdate=func.now())

    # Связи
    courses = relationship("Course", back_populates="author")  # Курсы, созданные пользователем
    course_enrollments = relationship("CourseEnrollment", back_populates="user")  # Записи на курсы
    course_completions = relationship("CourseCompletion", back_populates="user")  # Завершенные курсы
    exam_attempts = relationship("ExamAttempt", back_populates="user")  # Попытки экзаменов
    task_completions = relationship("TaskCompletion", back_populates="user")
    user_progress = relationship("UserProgress", back_populates="user")  # Прогресс по курсам
    achievements = relationship("UserAchievement", back_populates="user")  # Достижения
    game_profile = relationship("UserGameProfile", back_populates="user")  # Игровой профиль
    
    # Временная заглушка для совместимости
    @property
    def level(self):
        return None