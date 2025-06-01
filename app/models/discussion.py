from sqlalchemy import Column, Integer, String, Text, ForeignKey, DateTime, Boolean, Float, Enum
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from app.db.base import Base
import enum


class ContentType(str, enum.Enum):
    COURSE = "course"
    LESSON = "lesson"
    DISCUSSION = "discussion"
    QUIZ = "quiz"


class Discussion(Base):
    __tablename__ = "discussions"

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String, nullable=False)
    content = Column(Text, nullable=False)

    # Связи с контентом
    content_type = Column(Enum(ContentType))
    content_id = Column(Integer)

    # Автор
    author_id = Column(Integer, ForeignKey("users.id"))
    author = relationship("User", back_populates="discussions")

    # Флаги
    is_pinned = Column(Boolean, default=False)
    is_answered = Column(Boolean, default=False)

    # Статистика
    view_count = Column(Integer, default=0)
    vote_count = Column(Integer, default=0)

    # Связи
    replies = relationship("DiscussionReply", back_populates="discussion", cascade="all, delete-orphan")
    votes = relationship("DiscussionVote", back_populates="discussion", cascade="all, delete-orphan")

    created_at = Column(DateTime(timezone=True), server_default=func.now())
    updated_at = Column(DateTime(timezone=True), onupdate=func.now())


class DiscussionReply(Base):
    __tablename__ = "discussion_replies"

    id = Column(Integer, primary_key=True, index=True)
    content = Column(Text, nullable=False)

    # Связи
    discussion_id = Column(Integer, ForeignKey("discussions.id"))
    discussion = relationship("Discussion", back_populates="replies")

    author_id = Column(Integer, ForeignKey("users.id"))
    author = relationship("User", back_populates="discussion_replies")

    parent_id = Column(Integer, ForeignKey("discussion_replies.id"), nullable=True)
    replies = relationship("DiscussionReply",
                           backref=relationship("DiscussionReply", remote_side=[id]),
                           cascade="all, delete-orphan")

    # Флаги
    is_solution = Column(Boolean, default=False)

    # Статистика
    vote_count = Column(Integer, default=0)

    votes = relationship("ReplyVote", back_populates="reply", cascade="all, delete-orphan")

    created_at = Column(DateTime(timezone=True), server_default=func.now())
    updated_at = Column(DateTime(timezone=True), onupdate=func.now())


class DiscussionVote(Base):
    __tablename__ = "discussion_votes"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"))
    discussion_id = Column(Integer, ForeignKey("discussions.id"))
    value = Column(Integer)  # 1 или -1

    user = relationship("User", back_populates="discussion_votes")
    discussion = relationship("Discussion", back_populates="votes")

    created_at = Column(DateTime(timezone=True), server_default=func.now())


class ReplyVote(Base):
    __tablename__ = "reply_votes"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"))
    reply_id = Column(Integer, ForeignKey("discussion_replies.id"))
    value = Column(Integer)  # 1 или -1

    user = relationship("User", back_populates="reply_votes")
    reply = relationship("DiscussionReply", back_populates="votes")

    created_at = Column(DateTime(timezone=True), server_default=func.now())


class Review(Base):
    __tablename__ = "reviews"

    id = Column(Integer, primary_key=True, index=True)
    course_id = Column(Integer, ForeignKey("courses.id"))
    author_id = Column(Integer, ForeignKey("users.id"))

    rating = Column(Float, nullable=False)
    content = Column(Text)

    # Полезность отзыва
    helpful_count = Column(Integer, default=0)

    course = relationship("Course", back_populates="reviews")
    author = relationship("User", back_populates="reviews")
    helpful_marks = relationship("ReviewHelpful", back_populates="review", cascade="all, delete-orphan")

    created_at = Column(DateTime(timezone=True), server_default=func.now())
    updated_at = Column(DateTime(timezone=True), onupdate=func.now())


class ReviewHelpful(Base):
    __tablename__ = "review_helpful"

    id = Column(Integer, primary_key=True, index=True)
    review_id = Column(Integer, ForeignKey("reviews.id"))
    user_id = Column(Integer, ForeignKey("users.id"))

    review = relationship("Review", back_populates="helpful_marks")
    user = relationship("User", back_populates="helpful_marks")

    created_at = Column(DateTime(timezone=True), server_default=func.now())