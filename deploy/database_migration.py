#!/usr/bin/env python3

"""
Скрипт для переноса данных из локальной базы данных MaroAI на сервер
Запускать на локальной машине для создания дампа и на сервере для восстановления
"""

import subprocess
import sys
import os
from datetime import datetime

def create_database_dump():
    """Создает дамп локальной базы данных"""
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    dump_file = f"maroai_dump_{timestamp}.sql"
    
    print("🗄️ Создание дампа базы данных...")
    
    # Команда для создания дампа PostgreSQL
    dump_command = [
        "pg_dump",
        "-h", "localhost",
        "-U", "postgres",  # или ваш пользователь
        "-d", "MaroAI",    # имя вашей локальной БД
        "-f", dump_file,
        "--no-owner",
        "--no-privileges",
        "--clean"
    ]
    
    try:
        subprocess.run(dump_command, check=True)
        print(f"✅ Дамп создан: {dump_file}")
        print(f"📤 Загрузите файл {dump_file} на сервер")
        return dump_file
    except subprocess.CalledProcessError as e:
        print(f"❌ Ошибка при создании дампа: {e}")
        return None

def restore_database_dump(dump_file):
    """Восстанавливает базу данных из дампа на сервере"""
    print(f"🗄️ Восстановление базы данных из {dump_file}...")
    
    # Команда для восстановления БД
    restore_command = [
        "psql",
        "-h", "localhost",
        "-U", "maroai",
        "-d", "maroai_db",
        "-f", dump_file
    ]
    
    try:
        subprocess.run(restore_command, check=True)
        print("✅ База данных успешно восстановлена!")
    except subprocess.CalledProcessError as e:
        print(f"❌ Ошибка при восстановлении: {e}")

def initialize_fresh_database():
    """Инициализирует новую базу данных с базовой структурой"""
    print("🗄️ Инициализация новой базы данных...")
    
    # Здесь должен быть код инициализации БД
    # Например, запуск Alembic миграций или SQL скриптов
    
    init_commands = [
        "python3", "-c", """
import sys
sys.path.append('.')
from database import init_db
init_db()
"""
    ]
    
    try:
        subprocess.run(init_commands, check=True, cwd="/var/www/maroai")
        print("✅ База данных инициализирована!")
    except subprocess.CalledProcessError as e:
        print(f"❌ Ошибка при инициализации: {e}")

def main():
    if len(sys.argv) < 2:
        print("Использование:")
        print("  python database_migration.py dump          # Создать дамп (локально)")
        print("  python database_migration.py restore <file> # Восстановить дамп (на сервере)")
        print("  python database_migration.py init          # Инициализировать новую БД")
        sys.exit(1)
    
    action = sys.argv[1]
    
    if action == "dump":
        create_database_dump()
    elif action == "restore":
        if len(sys.argv) < 3:
            print("❌ Укажите файл дампа для восстановления")
            sys.exit(1)
        dump_file = sys.argv[2]
        if not os.path.exists(dump_file):
            print(f"❌ Файл {dump_file} не найден")
            sys.exit(1)
        restore_database_dump(dump_file)
    elif action == "init":
        initialize_fresh_database()
    else:
        print(f"❌ Неизвестное действие: {action}")
        sys.exit(1)

if __name__ == "__main__":
    main() 