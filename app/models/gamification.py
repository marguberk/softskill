from sqlalchemy import Column, Integer, String, Float, DateTime, ForeignKey, JSON, Enum
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from app.db.base import Base
import enum


class ActionType(str, enum.Enum):
    LESSON_COMPLETE = "lesson_complete"
    COURSE_COMPLETE = "course_complete"
    QUIZ_COMPLETE = "quiz_complete"
    PERFECT_SCORE = "perfect_score"
    DAILY_LOGIN = "daily_login"
    STREAK_MILESTONE = "streak_milestone"
    HELP_OTHERS = "help_others"
    FIRST_COURSE = "first_course"


class UserGameProfile(Base):
    __tablename__ = "user_game_profiles"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"))

    # Основные показатели
    level = Column(Integer, default=1)
    experience = Column(Integer, default=0)
    experience_points = Column(Integer, default=0)
    total_points = Column(Integer, default=0)

    # Статистика
    courses_completed = Column(Integer, default=0)
    lessons_completed = Column(Integer, default=0)
    perfect_scores = Column(Integer, default=0)
    login_streak = Column(Integer, default=0)
    longest_streak = Column(Integer, default=0)

    # Достижения и награды
    badges = Column(JSON, default=list)
    titles = Column(JSON, default=list)

    # Последняя активность
    last_login = Column(DateTime(timezone=True))
    last_action = Column(DateTime(timezone=True))

    # Связи
    user = relationship("User", back_populates="game_profile")
    activity_log = relationship("UserActivity", back_populates="game_profile")
    rewards = relationship("UserReward", back_populates="game_profile")

    created_at = Column(DateTime(timezone=True), server_default=func.now())
    updated_at = Column(DateTime(timezone=True), onupdate=func.now())


class UserActivity(Base):
    __tablename__ = "user_activities"

    id = Column(Integer, primary_key=True, index=True)
    profile_id = Column(Integer, ForeignKey("user_game_profiles.id"))

    action_type = Column(Enum(ActionType))
    points_earned = Column(Integer, default=0)
    exp_earned = Column(Integer, default=0)
    action_details = Column(JSON)  # Переименовали metadata в action_details

    game_profile = relationship("UserGameProfile", back_populates="activity_log")
    created_at = Column(DateTime(timezone=True), server_default=func.now())


class Reward(Base):
    __tablename__ = "rewards"

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String, nullable=False)
    description = Column(String)
    reward_type = Column(String)  # Переименовали type в reward_type
    image_url = Column(String)
    required_level = Column(Integer, default=0)
    required_points = Column(Integer, default=0)

    created_at = Column(DateTime(timezone=True), server_default=func.now())


class UserReward(Base):
    __tablename__ = "user_rewards"

    id = Column(Integer, primary_key=True, index=True)
    profile_id = Column(Integer, ForeignKey("user_game_profiles.id"))
    reward_id = Column(Integer, ForeignKey("rewards.id"))

    acquired_at = Column(DateTime(timezone=True), server_default=func.now())
    is_equipped = Column(Integer, default=False)

    game_profile = relationship("UserGameProfile", back_populates="rewards")
    reward = relationship("Reward")


class Leaderboard(Base):
    __tablename__ = "leaderboards"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"))
    period = Column(String)  # daily, weekly, monthly, all-time
    score = Column(Integer, default=0)
    rank = Column(Integer)

    updated_at = Column(DateTime(timezone=True), onupdate=func.now())
    created_at = Column(DateTime(timezone=True), server_default=func.now())