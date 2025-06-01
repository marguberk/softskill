from fastapi import APIRouter, Depends, Query
from sqlalchemy.orm import Session
from typing import Optional, List, Dict
import time

from app.db.base import get_db
from app.services.search import SearchService
from app.schemas.search import SearchFilters, SearchResults, SearchMetadata
from app.models.user import User
from app.api.deps import get_current_user

router = APIRouter()


@router.get("/courses", response_model=SearchResults)
async def search_courses(
        query: str = Query(None),
        status: Optional[str] = None,
        min_price: Optional[float] = None,
        max_price: Optional[float] = None,
        sort_by: str = "relevance",
        page: int = 1,
        per_page: int = 20,
        db: Session = Depends(get_db),
        current_user: Optional[User] = Depends(get_current_user)
):
    """
    Поиск по курсам с фильтрацией и сортировкой
    """
    search_service = SearchService(db)
    filters = SearchFilters(
        status=status,
        min_price=min_price,
        max_price=max_price
    )

    start_time = time.time()
    results = await search_service.search_courses(
        query=query,
        filters=filters.dict(exclude_none=True),
        sort_by=sort_by,
        page=page,
        per_page=per_page
    )

    return results


@router.get("/lessons", response_model=SearchResults)
async def search_lessons(
        query: str = Query(None),
        course_id: Optional[int] = None,
        page: int = 1,
        per_page: int = 20,
        db: Session = Depends(get_db),
        current_user: Optional[User] = Depends(get_current_user)
):
    """
    Поиск по урокам
    """
    search_service = SearchService(db)
    results = await search_service.search_lessons(
        query=query,
        course_id=course_id,
        page=page,
        per_page=per_page
    )

    return results


@router.get("/discussions", response_model=SearchResults)
async def search_discussions(
        query: str = Query(None),
        content_type: Optional[str] = None,
        is_answered: Optional[bool] = None,
        page: int = 1,
        per_page: int = 20,
        db: Session = Depends(get_db),
        current_user: Optional[User] = Depends(get_current_user)
):
    """
    Поиск по обсуждениям
    """
    search_service = SearchService(db)
    filters = SearchFilters(
        content_type=content_type,
        is_answered=is_answered
    )

    results = await search_service.search_discussions(
        query=query,
        filters=filters.dict(exclude_none=True),
        page=page,
        per_page=per_page
    )

    return results


@router.get("/suggestions")
async def get_search_suggestions(
        query: str = Query(..., min_length=2),
        db: Session = Depends(get_db)
):
    """
    Получение поисковых подсказок
    """
    search_service = SearchService(db)
    suggestions = await search_service.get_suggestions(query)
    return {"suggestions": suggestions}


@router.get("/popular")
async def get_popular_searches(
        db: Session = Depends(get_db)
):
    """
    Получение популярных поисковых запросов
    """
    search_service = SearchService(db)
    popular_searches = await search_service.get_popular_searches()
    return {"popular_searches": popular_searches}