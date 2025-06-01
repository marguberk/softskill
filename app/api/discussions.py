from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from sqlalchemy import func
from typing import List, Optional

from app.db.base import get_db
from app.models.user import User
from app.models.discussion import (
    Discussion, DiscussionReply, DiscussionVote,
    ReplyVote, Review, ReviewHelpful
)
from app.schemas.discussion import (
    DiscussionCreate, Discussion as DiscussionSchema,
    ReplyCreate, Reply as ReplySchema,
    ReviewCreate, Review as ReviewSchema,
    DiscussionDetails, ReviewDetails,
    VoteCreate
)
from app.api.deps import get_current_user

router = APIRouter()


@router.post("/discussions/", response_model=DiscussionSchema)
async def create_discussion(
        discussion: DiscussionCreate,
        db: Session = Depends(get_db),
        current_user: User = Depends(get_current_user)
):
    """Создание нового обсуждения"""
    db_discussion = Discussion(
        **discussion.dict(),
        author_id=current_user.id
    )
    db.add(db_discussion)
    db.commit()
    db.refresh(db_discussion)
    return db_discussion


@router.get("/discussions/{discussion_id}", response_model=DiscussionDetails)
async def get_discussion(
        discussion_id: int,
        db: Session = Depends(get_db),
        current_user: Optional[User] = Depends(get_current_user)
):
    """Получение деталей обсуждения"""
    discussion = db.query(Discussion).filter(Discussion.id == discussion_id).first()
    if not discussion:
        raise HTTPException(status_code=404, detail="Discussion not found")

    # Увеличиваем счетчик просмотров
    discussion.view_count += 1
    db.commit()

    # Получаем голос пользователя если он есть
    user_vote = None
    if current_user:
        vote = db.query(DiscussionVote).filter(
            DiscussionVote.discussion_id == discussion_id,
            DiscussionVote.user_id == current_user.id
        ).first()
        if vote:
            user_vote = vote.value

    return {
        **discussion.__dict__,
        "author_name": discussion.author.full_name,
        "replies": discussion.replies,
        "user_vote": user_vote
    }


@router.post("/discussions/{discussion_id}/replies", response_model=ReplySchema)
async def create_reply(
        discussion_id: int,
        reply: ReplyCreate,
        db: Session = Depends(get_db),
        current_user: User = Depends(get_current_user)
):
    """Создание ответа в обсуждении"""
    discussion = db.query(Discussion).filter(Discussion.id == discussion_id).first()
    if not discussion:
        raise HTTPException(status_code=404, detail="Discussion not found")

    db_reply = DiscussionReply(
        **reply.dict(),
        discussion_id=discussion_id,
        author_id=current_user.id
    )
    db.add(db_reply)
    db.commit()
    db.refresh(db_reply)
    return db_reply


@router.post("/discussions/{discussion_id}/vote")
async def vote_discussion(
        discussion_id: int,
        vote: VoteCreate,
        db: Session = Depends(get_db),
        current_user: User = Depends(get_current_user)
):
    """Голосование за обсуждение"""
    discussion = db.query(Discussion).filter(Discussion.id == discussion_id).first()
    if not discussion:
        raise HTTPException(status_code=404, detail="Discussion not found")

    existing_vote = db.query(DiscussionVote).filter(
        DiscussionVote.discussion_id == discussion_id,
        DiscussionVote.user_id == current_user.id
    ).first()

    if existing_vote:
        if existing_vote.value == vote.value:
            # Отмена голоса
            discussion.vote_count -= existing_vote.value
            db.delete(existing_vote)
        else:
            # Изменение голоса
            discussion.vote_count = discussion.vote_count - existing_vote.value + vote.value
            existing_vote.value = vote.value
    else:
        # Новый голос
        db_vote = DiscussionVote(
            discussion_id=discussion_id,
            user_id=current_user.id,
            value=vote.value
        )
        discussion.vote_count += vote.value
        db.add(db_vote)

    db.commit()
    return {"success": True}


@router.post("/courses/{course_id}/reviews", response_model=ReviewSchema)
async def create_review(
        course_id: int,
        review: ReviewCreate,
        db: Session = Depends(get_db),
        current_user: User = Depends(get_current_user)
):
    """Создание отзыва о курсе"""
    existing_review = db.query(Review).filter(
        Review.course_id == course_id,
        Review.author_id == current_user.id
    ).first()

    if existing_review:
        raise HTTPException(status_code=400, detail="You have already reviewed this course")

    db_review = Review(
        **review.dict(),
        course_id=course_id,
        author_id=current_user.id
    )
    db.add(db_review)
    db.commit()
    db.refresh(db_review)
    return db_review


@router.get("/courses/{course_id}/reviews", response_model=List[ReviewDetails])
async def get_course_reviews(
        course_id: int,
        db: Session = Depends(get_db),
        current_user: Optional[User] = Depends(get_current_user)
):
    """Получение отзывов о курсе"""
    reviews = db.query(Review).filter(Review.course_id == course_id).all()

    result = []
    for review in reviews:
        user_marked_helpful = False
        if current_user:
            helpful_mark = db.query(ReviewHelpful).filter(
                ReviewHelpful.review_id == review.id,
                ReviewHelpful.user_id == current_user.id
            ).first()
            user_marked_helpful = helpful_mark is not None

        result.append({
            **review.__dict__,
            "author_name": review.author.full_name,
            "user_marked_helpful": user_marked_helpful
        })

    return result


@router.post("/reviews/{review_id}/helpful")
async def mark_review_helpful(
        review_id: int,
        db: Session = Depends(get_db),
        current_user: User = Depends(get_current_user)
):
    """Отметить отзыв как полезный"""
    review = db.query(Review).filter(Review.id == review_id).first()
    if not review:
        raise HTTPException(status_code=404, detail="Review not found")

    existing_mark = db.query(ReviewHelpful).filter(
        ReviewHelpful.review_id == review_id,
        ReviewHelpful.user_id == current_user.id
    ).first()

    if existing_mark:
        # Отменяем отметку
        review.helpful_count -= 1
        db.delete(existing_mark)
    else:
        # Добавляем отметку
        mark = ReviewHelpful(
            review_id=review_id,
            user_id=current_user.id
        )
        review.helpful_count += 1
        db.add(mark)

    db.commit()
    return {"success": True}


@router.post("/replies/{reply_id}/solution")
async def mark_reply_as_solution(
        reply_id: int,
        db: Session = Depends(get_db),
        current_user: User = Depends(get_current_user)
):
    """Отметить ответ как решение"""
    reply = db.query(DiscussionReply).filter(DiscussionReply.id == reply_id).first()
    if not reply:
        raise HTTPException(status_code=404, detail="Reply not found")

    # Проверяем, что текущий пользователь является автором обсуждения
    discussion = reply.discussion
    if discussion.author_id != current_user.id:
        raise HTTPException(status_code=403, detail="Only discussion author can mark solution")

    # Снимаем отметку решения с других ответов
    for other_reply in discussion.replies:
        if other_reply.id != reply_id:
            other_reply.is_solution = False

    # Отмечаем текущий ответ как решение
    reply.is_solution = True
    discussion.is_answered = True

    db.commit()
    return {"success": True}


@router.get("/discussions/", response_model=List[DiscussionSchema])
async def get_discussions(
        content_type: Optional[str] = None,
        content_id: Optional[int] = None,
        skip: int = 0,
        limit: int = 10,
        db: Session = Depends(get_db)
):
    """Получение списка обсуждений с фильтрацией"""
    query = db.query(Discussion)

    if content_type:
        query = query.filter(Discussion.content_type == content_type)
    if content_id:
        query = query.filter(Discussion.content_id == content_id)

    # Сортировка: сначала закрепленные, потом по дате создания
    query = query.order_by(Discussion.is_pinned.desc(), Discussion.created_at.desc())

    discussions = query.offset(skip).limit(limit).all()
    return discussions


@router.post("/replies/{reply_id}/vote")
async def vote_reply(
        reply_id: int,
        vote: VoteCreate,
        db: Session = Depends(get_db),
        current_user: User = Depends(get_current_user)
):
    """Голосование за ответ"""
    reply = db.query(DiscussionReply).filter(DiscussionReply.id == reply_id).first()
    if not reply:
        raise HTTPException(status_code=404, detail="Reply not found")

    existing_vote = db.query(ReplyVote).filter(
        ReplyVote.reply_id == reply_id,
        ReplyVote.user_id == current_user.id
    ).first()

    if existing_vote:
        if existing_vote.value == vote.value:
            # Отмена голоса
            reply.vote_count -= existing_vote.value
            db.delete(existing_vote)
        else:
            # Изменение голоса
            reply.vote_count = reply.vote_count - existing_vote.value + vote.value
            existing_vote.value = vote.value
    else:
        # Новый голос
        db_vote = ReplyVote(
            reply_id=reply_id,
            user_id=current_user.id,
            value=vote.value
        )
        reply.vote_count += vote.value
        db.add(db_vote)

    db.commit()
    return {"success": True}


@router.put("/discussions/{discussion_id}", response_model=DiscussionSchema)
async def update_discussion(
        discussion_id: int,
        discussion_update: DiscussionCreate,
        db: Session = Depends(get_db),
        current_user: User = Depends(get_current_user)
):
    """Обновление обсуждения"""
    discussion = db.query(Discussion).filter(Discussion.id == discussion_id).first()
    if not discussion:
        raise HTTPException(status_code=404, detail="Discussion not found")

    if discussion.author_id != current_user.id and current_user.role != "admin":
        raise HTTPException(status_code=403, detail="Not enough permissions")

    for field, value in discussion_update.dict().items():
        setattr(discussion, field, value)

    db.commit()
    db.refresh(discussion)
    return discussion


@router.delete("/discussions/{discussion_id}")
async def delete_discussion(
        discussion_id: int,
        db: Session = Depends(get_db),
        current_user: User = Depends(get_current_user)
):
    """Удаление обсуждения"""
    discussion = db.query(Discussion).filter(Discussion.id == discussion_id).first()
    if not discussion:
        raise HTTPException(status_code=404, detail="Discussion not found")

    if discussion.author_id != current_user.id and current_user.role != "admin":
        raise HTTPException(status_code=403, detail="Not enough permissions")

    db.delete(discussion)
    db.commit()
    return {"message": "Discussion deleted successfully"}