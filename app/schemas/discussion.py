from pydantic import BaseModel, Field
from typing import Optional, List
from datetime import datetime
from enum import Enum

class ContentType(str, Enum):
    COURSE = "course"
    LESSON = "lesson"
    DISCUSSION = "discussion"
    QUIZ = "quiz"

class DiscussionBase(BaseModel):
    title: str
    content: str
    content_type: ContentType
    content_id: int

class DiscussionCreate(DiscussionBase):
    pass

class Discussion(DiscussionBase):
    id: int
    author_id: int
    is_pinned: bool = False
    is_answered: bool = False
    view_count: int = 0
    vote_count: int = 0
    created_at: datetime
    updated_at: Optional[datetime] = None

    class Config:
        from_attributes = True

class ReplyBase(BaseModel):
    content: str
    parent_id: Optional[int] = None

class ReplyCreate(ReplyBase):
    pass

class Reply(ReplyBase):
    id: int
    discussion_id: int
    author_id: int
    is_solution: bool = False
    vote_count: int = 0
    created_at: datetime
    updated_at: Optional[datetime] = None

    class Config:
        from_attributes = True

class ReviewBase(BaseModel):
    rating: float = Field(ge=1, le=5)
    content: Optional[str] = None

class ReviewCreate(ReviewBase):
    pass

class Review(ReviewBase):
    id: int
    course_id: int
    author_id: int
    helpful_count: int = 0
    created_at: datetime
    updated_at: Optional[datetime] = None

    class Config:
        from_attributes = True

class VoteCreate(BaseModel):
    value: int = Field(ge=-1, le=1)

class DiscussionDetails(Discussion):
    author_name: str
    replies: List[Reply]
    user_vote: Optional[int] = None

class ReviewDetails(Review):
    author_name: str
    user_marked_helpful: bool = False