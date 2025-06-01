from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.core.config import settings
from app.db.base import Base, engine, get_db
from app.api import auth, skills, tasks  # courses временно отключен
from app.api import courses_v2  # новый API курсов
from app.api import test_api  # тестовый API
from app.api.v1 import admin
from app.api.v1 import materials
from app.data.seed_skills import seed_skills_data
from app.data.seed_tasks import seed_daily_tasks
from sqlalchemy import inspect

# Создаем таблицы только если их нет
Base.metadata.create_all(bind=engine)

# Заполняем базу данных тестовыми данными только если они еще не созданы
try:
    db = next(get_db())
    inspector = inspect(engine)
    
    # Проверяем, есть ли уже данные о навыках
    if inspector.has_table("soft_skills"):
        from app.models.skills import SoftSkill
        existing_skills = db.query(SoftSkill).first()
        if not existing_skills:
            seed_skills_data(db)
            print("✅ База данных заполнена тестовыми вопросами для навыков")
        else:
            print("ℹ️ Навыки уже существуют в базе данных")
    else:
        seed_skills_data(db)
        print("✅ База данных заполнена тестовыми вопросами для навыков")
    
    # Заполняем задания
    if inspector.has_table("daily_tasks"):
        from app.models.tasks import DailyTask
        existing_tasks = db.query(DailyTask).first()
        if not existing_tasks:
            seed_daily_tasks(db)
            print("✅ База данных заполнена ежедневными заданиями")
        else:
            print("ℹ️ Ежедневные задания уже существуют в базе данных")
    else:
        seed_daily_tasks(db)
        print("✅ База данных заполнена ежедневными заданиями")
        
except Exception as e:
    print(f"❌ Ошибка при заполнении базы данных: {e}")

app = FastAPI(
    title=settings.PROJECT_NAME,
    openapi_url=f"{settings.API_V1_STR}/openapi.json"
)

# Настройка CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.BACKEND_CORS_ORIGINS,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Подключаем роутеры
app.include_router(auth.router, prefix=f"{settings.API_V1_STR}/auth", tags=["auth"])
app.include_router(courses_v2.router, prefix=f"{settings.API_V1_STR}/courses", tags=["courses"])
app.include_router(test_api.router, prefix=f"{settings.API_V1_STR}/test", tags=["test"])
app.include_router(skills.router, prefix=f"{settings.API_V1_STR}/skills", tags=["skills"])
app.include_router(tasks.router, prefix=f"{settings.API_V1_STR}/tasks", tags=["tasks"])
app.include_router(admin.router, prefix=f"{settings.API_V1_STR}/admin", tags=["admin"])
app.include_router(materials.router, prefix=f"{settings.API_V1_STR}", tags=["materials"])

@app.get("/")
async def root():
    return {"message": "Welcome to Learning Platform API"}