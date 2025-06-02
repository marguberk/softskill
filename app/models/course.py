from sqlalchemy import Column, Integer, String, Text, ForeignKey, Float, Enum, DateTime, Boolean
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from app.db.base import Base
import enum

class SkillType(str, enum.Enum):
    COMMUNICATION = "communication"
    LEADERSHIP = "leadership"
    PROBLEM_SOLVING = "problem_solving"
    TIME_MANAGEMENT = "time_management"
    EMOTIONAL_INTELLIGENCE = "emotional_intelligence"
    TEAMWORK = "teamwork"

class DifficultyLevel(str, enum.Enum):
    BEGINNER = "beginner"
    INTERMEDIATE = "intermediate"
    ADVANCED = "advanced"

class Course(Base):
    __tablename__ = "courses"

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String, index=True, nullable=False)
    description = Column(Text)
    skill_type = Column(Enum(SkillType), nullable=False)
    difficulty_level = Column(Enum(DifficultyLevel), nullable=False)
    duration_hours = Column(Integer)  # Общая продолжительность курса в часах
    price = Column(Float, default=0.0)  # Цена курса (пока бесплатно)
    is_published = Column(Boolean, default=False)
    author_id = Column(Integer, ForeignKey("users.id"))
    created_at = Column(DateTime(timezone=True), server_default=func.now())
    updated_at = Column(DateTime(timezone=True), onupdate=func.now())

    # Связи
    author = relationship("User", back_populates="courses")
    course_lessons = relationship("CourseLesson", back_populates="course", cascade="all, delete-orphan")
    enrollments = relationship("CourseEnrollment", back_populates="course", cascade="all, delete-orphan")
    exams = relationship("CourseExam", back_populates="course", cascade="all, delete-orphan")
    completions = relationship("CourseCompletion", back_populates="course", cascade="all, delete-orphan")
    modules = relationship("Module", back_populates="course", cascade="all, delete-orphan")

class CourseLesson(Base):
    __tablename__ = "course_lessons"

    id = Column(Integer, primary_key=True, index=True)
    course_id = Column(Integer, ForeignKey("courses.id"), nullable=False)
    material_id = Column(Integer, ForeignKey("learning_materials.id"), nullable=False)
    order_position = Column(Integer, default=0)
    is_required = Column(Boolean, default=True)
    created_at = Column(DateTime(timezone=True), server_default=func.now())

    # Связи
    course = relationship("Course", back_populates="course_lessons")
    material = relationship("LearningMaterial")

class CourseEnrollment(Base):
    __tablename__ = "course_enrollments"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    course_id = Column(Integer, ForeignKey("courses.id"), nullable=False)
    enrolled_at = Column(DateTime(timezone=True), server_default=func.now())
    is_active = Column(Boolean, default=True)

    # Связи
    user = relationship("User")
    course = relationship("Course", back_populates="enrollments")

class CourseExam(Base):
    __tablename__ = "course_exams"

    id = Column(Integer, primary_key=True, index=True)
    course_id = Column(Integer, ForeignKey("courses.id"), nullable=False)
    title = Column(String, nullable=False)
    description = Column(Text)
    passing_score = Column(Integer, default=70)  # Минимальный балл для прохождения
    time_limit_minutes = Column(Integer, default=30)
    questions = Column(Text)  # JSON с вопросами и вариантами ответов
    created_at = Column(DateTime(timezone=True), server_default=func.now())
    updated_at = Column(DateTime(timezone=True), onupdate=func.now())

    # Связи
    course = relationship("Course", back_populates="exams")
    attempts = relationship("ExamAttempt", back_populates="exam", cascade="all, delete-orphan")

class ExamAttempt(Base):
    __tablename__ = "exam_attempts"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    exam_id = Column(Integer, ForeignKey("course_exams.id"), nullable=False)
    answers = Column(Text)  # JSON с ответами
    score = Column(Integer)
    passed = Column(Boolean, default=False)
    started_at = Column(DateTime(timezone=True), server_default=func.now())
    completed_at = Column(DateTime(timezone=True))

    # Связи
    user = relationship("User")
    exam = relationship("CourseExam", back_populates="attempts")

class CourseCompletion(Base):
    __tablename__ = "course_completions"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    course_id = Column(Integer, ForeignKey("courses.id"), nullable=False)
    completed_at = Column(DateTime(timezone=True), server_default=func.now())
    final_score = Column(Integer)  # Итоговый балл за курс

    # Связи
    user = relationship("User")
    course = relationship("Course", back_populates="completions")
    certificate = relationship("Certificate", back_populates="completion", uselist=False)

class Certificate(Base):
    __tablename__ = "certificates"

    id = Column(Integer, primary_key=True, index=True)
    completion_id = Column(Integer, ForeignKey("course_completions.id"), nullable=False)
    certificate_number = Column(String, unique=True, nullable=False)
    issued_at = Column(DateTime(timezone=True), server_default=func.now())
    template_data = Column(Text)  # JSON с данными для генерации сертификата

    # Связи
    completion = relationship("CourseCompletion", back_populates="certificate")

class Module(Base):
    __tablename__ = "modules"

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String, nullable=False)
    description = Column(Text)
    order = Column(Integer, default=0)
    course_id = Column(Integer, ForeignKey("courses.id"), nullable=False)
    created_at = Column(DateTime(timezone=True), server_default=func.now())
    updated_at = Column(DateTime(timezone=True), onupdate=func.now())

    # Связи
    course = relationship("Course", back_populates="modules")
    lessons = relationship("Lesson", back_populates="module", cascade="all, delete-orphan")

class Lesson(Base):
    __tablename__ = "lessons"

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String, nullable=False)
    content = Column(Text)
    order = Column(Integer, default=0)
    module_id = Column(Integer, ForeignKey("modules.id"), nullable=False)
    created_at = Column(DateTime(timezone=True), server_default=func.now())
    updated_at = Column(DateTime(timezone=True), onupdate=func.now())

    # Связи
    module = relationship("Module", back_populates="lessons")