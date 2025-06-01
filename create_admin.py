#!/usr/bin/env python3

import asyncio
import sys
import os

# Добавляем путь к проекту
sys.path.append(os.path.dirname(os.path.abspath(__file__)))

from app.db.base import SessionLocal, Base, engine
from app.models.user import User
from app.models.learning_material import LearningMaterial, LearningTask
from app.core.security import get_password_hash

def create_admin():
    """Создать администратора и таблицы"""
    try:
        # Создаем таблицы
        print('🔄 Создание таблиц...')
        Base.metadata.create_all(bind=engine)
        print('✅ Таблицы созданы')
        
        db = SessionLocal()
        
        # Проверяем, есть ли уже админ
        existing_admin = db.query(User).filter(User.email == 'admin@maroai.com').first()
        if existing_admin:
            print('⚠️ Админ уже существует!')
            return
        
        # Создаем админа
        admin_user = User(
            email='admin@maroai.com',
            full_name='Администратор',
            hashed_password=get_password_hash('admin123'),
            role='admin',
            is_active=True
        )
        
        db.add(admin_user)
        db.commit()
        
        print('✅ Админ создан успешно!')
        print('📧 Email: admin@maroai.com')
        print('🔑 Пароль: admin123')
        print('🌐 Админ-панель: http://localhost:5180/admin')
        
    except Exception as e:
        print(f'❌ Ошибка создания админа: {e}')
        import traceback
        traceback.print_exc()
    finally:
        if 'db' in locals():
            db.close()

if __name__ == '__main__':
    create_admin() 