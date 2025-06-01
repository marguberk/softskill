from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from sqlalchemy import text
from app.db.base import get_db
from app.models.user import User

router = APIRouter()

@router.get("/hello")
async def hello():
    """Простой тестовый эндпоинт"""
    return {"message": "Hello from test API"}

@router.get("/db-test")
async def test_db(db: Session = Depends(get_db)):
    """Тестирование подключения к базе данных"""
    try:
        # Простой запрос к базе
        result = db.execute(text("SELECT 1 as test")).fetchone()
        return {"status": "ok", "db_test": result[0]}
    except Exception as e:
        return {"status": "error", "message": str(e)}

@router.get("/user-test")
async def test_user(db: Session = Depends(get_db)):
    """Тестирование User модели"""
    try:
        # Попробуем получить пользователя
        user = db.query(User).first()
        if user:
            return {"status": "ok", "user_email": user.email, "user_name": user.full_name}
        else:
            return {"status": "ok", "message": "No users found"}
    except Exception as e:
        return {"status": "error", "message": str(e)} 