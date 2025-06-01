#!/usr/bin/env python3

import sys
import os
from sqlalchemy import create_engine, Column, Integer, String, Boolean, DateTime
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from sqlalchemy.sql import func
from passlib.context import CryptContext

# Настройки
DATABASE_URL = "sqlite:///./app.db"

# Создаем базовые компоненты
engine = create_engine(DATABASE_URL, connect_args={"check_same_thread": False})
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()

# Простая модель пользователя без зависимостей
class SimpleUser(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    email = Column(String, unique=True, index=True, nullable=False)
    hashed_password = Column(String, nullable=False)
    full_name = Column(String)
    role = Column(String, nullable=False, default="student")
    is_active = Column(Boolean, default=True)
    created_at = Column(DateTime(timezone=True), server_default=func.now())
    updated_at = Column(DateTime(timezone=True), onupdate=func.now())

# Хеширование паролей
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

def hash_password(password: str) -> str:
    return pwd_context.hash(password)

def create_admin():
    """Создать администратора"""
    try:
        # Создаем таблицы
        print('🔄 Создание таблиц...')
        Base.metadata.create_all(bind=engine)
        print('✅ Таблицы созданы')
        
        db = SessionLocal()
        
        # Удаляем старого админа если существует
        existing_admin = db.query(SimpleUser).filter(SimpleUser.email == 'admin@maroai.com').first()
        if existing_admin:
            print('🗑️ Удаляю старого админа...')
            db.delete(existing_admin)
            db.commit()
        
        # Создаем нового админа
        admin_user = SimpleUser(
            email='admin@maroai.com',
            full_name='Администратор',
            hashed_password=hash_password('admin123'),
            role='admin',
            is_active=True
        )
        
        db.add(admin_user)
        db.commit()
        
        print('✅ Админ создан успешно!')
        print('📧 Email: admin@maroai.com')
        print('🔑 Пароль: admin123')
        print('🌐 Админ-панель: http://localhost:5173/admin')
        
    except Exception as e:
        print(f'❌ Ошибка создания админа: {e}')
        import traceback
        traceback.print_exc()
    finally:
        if 'db' in locals():
            db.close()

if __name__ == '__main__':
    create_admin() 