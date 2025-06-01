from sqlalchemy import Column, Integer, String, Float, Boolean, DateTime, ForeignKey, Enum
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from app.db.base import Base
import enum


class LessonStatus(str, enum.Enum):
    NOT_STARTED = "not_started"
    IN_PROGRESS = "in_progress"
    COMPLETED = "completed"


class UserProgress(Base):
    __tablename__ = "user_progress"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"))
    course_id = Column(Integer, ForeignKey("courses.id"))

    # Прогресс по курсу
    completed_lessons = Column(Integer, default=0)
    total_lessons = Column(Integer, default=0)
    progress_percentage = Column(Float, default=0.0)
    last_accessed = Column(DateTime(timezone=True))

    # Статистика
    total_time_spent = Column(Integer, default=0)  # в минутах
    average_score = Column(Float, default=0.0)

    # Связи
    user = relationship("User", back_populates="progress")
    course = relationship("Course", back_populates="students_progress")
    lesson_progress = relationship("LessonProgress", back_populates="user_progress")

    created_at = Column(DateTime(timezone=True), server_default=func.now())
    updated_at = Column(DateTime(timezone=True), onupdate=func.now())


class LessonProgress(Base):
    __tablename__ = "lesson_progress"

    id = Column(Integer, primary_key=True, index=True)
    user_progress_id = Column(Integer, ForeignKey("user_progress.id"))
    lesson_id = Column(Integer, ForeignKey("lessons.id"))

    # Статус и результаты
    status = Column(Enum(LessonStatus), default=LessonStatus.NOT_STARTED)
    score = Column(Float, nullable=True)
    time_spent = Column(Integer, default=0)  # в минутах
    completed_at = Column(DateTime(timezone=True), nullable=True)

    # Дополнительные данные
    notes = Column(String, nullable=True)
    last_position = Column(Integer, default=0)  # для видео-уроков

    # Связи
    user_progress = relationship("UserProgress", back_populates="lesson_progress")
    lesson = relationship("Lesson", back_populates="progress")

    created_at = Column(DateTime(timezone=True), server_default=func.now())
    updated_at = Column(DateTime(timezone=True), onupdate=func.now())


class Achievement(Base):
    __tablename__ = "achievements"

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String, nullable=False)
    description = Column(String)
    badge_image = Column(String)

    # Условия получения
    required_courses = Column(Integer, default=0)
    required_lessons = Column(Integer, default=0)
    required_score = Column(Float, default=0.0)

    created_at = Column(DateTime(timezone=True), server_default=func.now())


class UserAchievement(Base):
    __tablename__ = "user_achievements"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"))
    achievement_id = Column(Integer, ForeignKey("achievements.id"))

    achieved_at = Column(DateTime(timezone=True), server_default=func.now())

    # Связи
    user = relationship("User", back_populates="achievements")
    achievement = relationship("Achievement")