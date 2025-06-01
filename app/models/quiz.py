from sqlalchemy import Column, Integer, String, Text, ForeignKey, Float, JSON, DateTime, Boolean
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from app.db.base import Base


class Quiz(Base):
    __tablename__ = "quizzes"

    id = Column(Integer, primary_key=True, index=True)
    lesson_id = Column(Integer, ForeignKey("lessons.id"))
    title = Column(String, nullable=False)
    description = Column(Text)
    time_limit = Column(Integer)  # в минутах
    passing_score = Column(Float, default=70.0)  # процент для прохождения
    attempts_allowed = Column(Integer, default=3)
    is_randomized = Column(Boolean, default=False)

    # Связи
    lesson = relationship("Lesson", back_populates="quizzes")
    questions = relationship("Question", back_populates="quiz", cascade="all, delete-orphan")
    attempts = relationship("QuizAttempt", back_populates="quiz")

    created_at = Column(DateTime(timezone=True), server_default=func.now())
    updated_at = Column(DateTime(timezone=True), onupdate=func.now())


class Question(Base):
    __tablename__ = "questions"

    id = Column(Integer, primary_key=True, index=True)
    quiz_id = Column(Integer, ForeignKey("quizzes.id"))
    type = Column(String)  # multiple_choice, single_choice, text, code
    text = Column(Text, nullable=False)
    options = Column(JSON)  # для вопросов с вариантами ответов
    correct_answer = Column(JSON)  # может быть строкой или массивом правильных ответов
    points = Column(Float, default=1.0)
    explanation = Column(Text)  # объяснение правильного ответа

    # Для code-вопросов
    code_template = Column(Text)  # начальный код
    test_cases = Column(JSON)  # тесты для проверки кода

    quiz = relationship("Quiz", back_populates="questions")
    responses = relationship("QuestionResponse", back_populates="question")

    created_at = Column(DateTime(timezone=True), server_default=func.now())


class QuizAttempt(Base):
    __tablename__ = "quiz_attempts"

    id = Column(Integer, primary_key=True, index=True)
    quiz_id = Column(Integer, ForeignKey("quizzes.id"))
    user_id = Column(Integer, ForeignKey("users.id"))

    started_at = Column(DateTime(timezone=True), server_default=func.now())
    completed_at = Column(DateTime(timezone=True))
    score = Column(Float)
    max_score = Column(Float)
    passed = Column(Boolean, default=False)

    # Связи
    quiz = relationship("Quiz", back_populates="attempts")
    user = relationship("User", back_populates="quiz_attempts")
    responses = relationship("QuestionResponse", back_populates="attempt")


class QuestionResponse(Base):
    __tablename__ = "question_responses"

    id = Column(Integer, primary_key=True, index=True)
    attempt_id = Column(Integer, ForeignKey("quiz_attempts.id"))
    question_id = Column(Integer, ForeignKey("questions.id"))

    answer = Column(JSON)  # ответ пользователя
    is_correct = Column(Boolean)
    points_earned = Column(Float)
    feedback = Column(Text)  # автоматический или ручной фидбек

    # Связи
    attempt = relationship("QuizAttempt", back_populates="responses")
    question = relationship("Question", back_populates="responses")

    created_at = Column(DateTime(timezone=True), server_default=func.now())