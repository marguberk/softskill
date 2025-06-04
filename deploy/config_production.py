#!/usr/bin/env python3

"""
Скрипт для адаптации конфигурации проекта под PostgreSQL в продакшене
"""

import os
import re

def update_database_config():
    """Обновляет database.py для использования PostgreSQL"""
    
    database_file = "database.py"
    
    if not os.path.exists(database_file):
        print(f"❌ Файл {database_file} не найден")
        return
    
    print(f"🔧 Обновление {database_file} для PostgreSQL...")
    
    with open(database_file, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Заменяем SQLite на PostgreSQL
    new_content = content.replace(
        'from sqlalchemy import create_engine, MetaData',
        'from sqlalchemy import create_engine, MetaData\nfrom sqlalchemy.pool import QueuePool'
    )
    
    # Обновляем строку подключения к БД
    new_content = re.sub(
        r'SQLALCHEMY_DATABASE_URL = .*',
        'SQLALCHEMY_DATABASE_URL = os.getenv("DATABASE_URL", "postgresql://maroai:password@localhost/maroai_db")',
        new_content
    )
    
    # Добавляем импорт os если его нет
    if 'import os' not in new_content:
        new_content = 'import os\n' + new_content
    
    # Обновляем настройки движка
    new_content = re.sub(
        r'engine = create_engine\([^)]+\)',
        '''engine = create_engine(
    SQLALCHEMY_DATABASE_URL,
    poolclass=QueuePool,
    pool_size=20,
    max_overflow=0,
    pool_pre_ping=True,
    pool_recycle=300
)''',
        new_content
    )
    
    with open(database_file, 'w', encoding='utf-8') as f:
        f.write(new_content)
    
    print(f"✅ {database_file} обновлен для PostgreSQL")

def update_requirements():
    """Добавляет PostgreSQL драйвер в requirements.txt"""
    
    requirements_file = "requirements.txt"
    
    if not os.path.exists(requirements_file):
        print(f"❌ Файл {requirements_file} не найден")
        return
    
    print(f"🔧 Обновление {requirements_file}...")
    
    with open(requirements_file, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Добавляем psycopg2-binary если его нет
    if 'psycopg2' not in content:
        content += '\npsycopg2-binary==2.9.9\n'
    
    with open(requirements_file, 'w', encoding='utf-8') as f:
        f.write(content)
    
    print(f"✅ {requirements_file} обновлен")

def create_init_db_script():
    """Создает скрипт для инициализации БД"""
    
    script_content = '''#!/usr/bin/env python3

"""
Скрипт для инициализации базы данных PostgreSQL
"""

import os
import sys
sys.path.append('.')

from database import Base, engine
from sqlalchemy import text

def init_database():
    """Инициализирует базу данных"""
    print("🗄️ Инициализация базы данных...")
    
    try:
        # Создаем все таблицы
        Base.metadata.create_all(bind=engine)
        print("✅ Таблицы созданы успешно")
        
        # Проверяем подключение
        with engine.connect() as conn:
            result = conn.execute(text("SELECT version()"))
            version = result.fetchone()[0]
            print(f"📊 PostgreSQL версия: {version}")
        
        print("✅ База данных готова к использованию")
        
    except Exception as e:
        print(f"❌ Ошибка инициализации БД: {e}")
        sys.exit(1)

if __name__ == "__main__":
    init_database()
'''
    
    with open("init_db.py", 'w', encoding='utf-8') as f:
        f.write(script_content)
    
    print("✅ Создан скрипт init_db.py")

def main():
    print("🚀 Адаптация конфигурации для продакшена...")
    
    update_database_config()
    update_requirements()
    create_init_db_script()
    
    print("\n✅ Конфигурация обновлена!")
    print("📝 Следующие шаги:")
    print("1. Проверьте DATABASE_URL в .env файле")
    print("2. Установите зависимости: pip install -r requirements.txt")
    print("3. Инициализируйте БД: python init_db.py")

if __name__ == "__main__":
    main() 