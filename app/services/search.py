from typing import List, Optional, Dict, Any
from sqlalchemy.orm import Session
from sqlalchemy import or_, and_, func
from app.models.course import Course, Module, Lesson
from app.models.discussion import Discussion
from app.models.user import User


class SearchService:
    def __init__(self, db: Session):
        self.db = db

    async def search_courses(
            self,
            query: str,
            filters: Dict[str, Any] = None,
            sort_by: str = "relevance",
            page: int = 1,
            per_page: int = 20
    ) -> Dict[str, Any]:
        """
        Поиск по курсам с фильтрацией и сортировкой
        """
        base_query = self.db.query(Course)

        # Применяем поисковый запрос
        if query:
            search_filter = or_(
                Course.title.ilike(f"%{query}%"),
                Course.description.ilike(f"%{query}%")
            )
            base_query = base_query.filter(search_filter)

        # Применяем фильтры
        if filters:
            if filters.get("status"):
                base_query = base_query.filter(Course.status == filters["status"])
            if filters.get("min_price") is not None:
                base_query = base_query.filter(Course.price >= filters["min_price"])
            if filters.get("max_price") is not None:
                base_query = base_query.filter(Course.price <= filters["max_price"])

        # Применяем сортировку
        if sort_by == "price_asc":
            base_query = base_query.order_by(Course.price.asc())
        elif sort_by == "price_desc":
            base_query = base_query.order_by(Course.price.desc())
        elif sort_by == "newest":
            base_query = base_query.order_by(Course.created_at.desc())
        elif sort_by == "popularity":
            base_query = base_query.order_by(Course.students_count.desc())

        # Пагинация
        total = base_query.count()
        courses = base_query.offset((page - 1) * per_page).limit(per_page).all()

        return {
            "items": courses,
            "total": total,
            "page": page,
            "pages": (total + per_page - 1) // per_page
        }

    async def search_lessons(
            self,
            query: str,
            course_id: Optional[int] = None,
            page: int = 1,
            per_page: int = 20
    ) -> Dict[str, Any]:
        """
        Поиск по урокам
        """
        base_query = self.db.query(Lesson)

        if query:
            search_filter = or_(
                Lesson.title.ilike(f"%{query}%"),
                Lesson.content.ilike(f"%{query}%")
            )
            base_query = base_query.filter(search_filter)

        if course_id:
            base_query = base_query.join(Module).filter(Module.course_id == course_id)

        total = base_query.count()
        lessons = base_query.offset((page - 1) * per_page).limit(per_page).all()

        return {
            "items": lessons,
            "total": total,
            "page": page,
            "pages": (total + per_page - 1) // per_page
        }

    async def search_discussions(
            self,
            query: str,
            filters: Dict[str, Any] = None,
            page: int = 1,
            per_page: int = 20
    ) -> Dict[str, Any]:
        """
        Поиск по обсуждениям
        """
        base_query = self.db.query(Discussion)

        if query:
            search_filter = or_(
                Discussion.title.ilike(f"%{query}%"),
                Discussion.content.ilike(f"%{query}%")
            )
            base_query = base_query.filter(search_filter)

        if filters:
            if filters.get("content_type"):
                base_query = base_query.filter(Discussion.content_type == filters["content_type"])
            if filters.get("is_answered") is not None:
                base_query = base_query.filter(Discussion.is_answered == filters["is_answered"])

        # Сортируем по релевантности и активности
        base_query = base_query.order_by(
            Discussion.is_pinned.desc(),
            Discussion.updated_at.desc()
        )

        total = base_query.count()
        discussions = base_query.offset((page - 1) * per_page).limit(per_page).all()

        return {
            "items": discussions,
            "total": total,
            "page": page,
            "pages": (total + per_page - 1) // per_page
        }

    async def get_popular_searches(self) -> List[str]:
        """
        Получение популярных поисковых запросов
        """
        # В будущем здесь можно добавить логику отслеживания популярных запросов
        return [
            "Python программирование",
            "Machine Learning",
            "Web Development",
            "Data Science",
            "JavaScript"
        ]

    async def get_suggestions(self, query: str) -> List[str]:
        """
        Получение поисковых подсказок
        """
        suggestions = []

        # Поиск по курсам
        course_suggestions = self.db.query(Course.title).filter(
            Course.title.ilike(f"%{query}%")
        ).limit(5).all()
        suggestions.extend([c.title for c in course_suggestions])

        # Поиск по темам
        topic_suggestions = set()
        courses = self.db.query(Course).filter(
            or_(
                Course.title.ilike(f"%{query}%"),
                Course.description.ilike(f"%{query}%")
            )
        ).all()

        for course in courses:
            # Здесь можно добавить логику извлечения тем из описания курса
            topics = [tag.strip() for tag in course.description.split(',')
                      if query.lower() in tag.lower()]
            topic_suggestions.update(topics)

        suggestions.extend(list(topic_suggestions)[:5])

        return suggestions[:10]  # Возвращаем максимум 10 подсказок