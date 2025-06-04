#!/usr/bin/env python3

"""
Скрипт для конвертации базы данных SQLite в PostgreSQL
Экспортирует данные из app.db в SQL формат совместимый с PostgreSQL
"""

import sqlite3
import sys
from datetime import datetime

def export_sqlite_to_sql(sqlite_db_path, output_file):
    """Экспортирует данные из SQLite в SQL файл для PostgreSQL"""
    
    print(f"🔄 Экспорт данных из {sqlite_db_path}...")
    
    # Подключение к SQLite
    conn = sqlite3.connect(sqlite_db_path)
    cursor = conn.cursor()
    
    # Получаем список всех таблиц
    cursor.execute("SELECT name FROM sqlite_master WHERE type='table';")
    tables = cursor.fetchall()
    
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write("-- MaroAI Database Export from SQLite to PostgreSQL\n")
        f.write(f"-- Generated on {datetime.now()}\n\n")
        
        # Отключаем проверки внешних ключей на время импорта
        f.write("SET session_replication_role = replica;\n\n")
        
        for table_name in tables:
            table_name = table_name[0]
            print(f"📋 Экспорт таблицы: {table_name}")
            
            # Получаем структуру таблицы
            cursor.execute(f"PRAGMA table_info({table_name})")
            columns_info = cursor.fetchall()
            
            if not columns_info:
                continue
                
            columns = [col[1] for col in columns_info]
            
            # Получаем данные
            cursor.execute(f"SELECT * FROM {table_name}")
            rows = cursor.fetchall()
            
            if rows:
                f.write(f"-- Данные для таблицы {table_name}\n")
                f.write(f"DELETE FROM {table_name};\n")
                
                for row in rows:
                    # Конвертируем значения для PostgreSQL
                    values = []
                    for val in row:
                        if val is None:
                            values.append('NULL')
                        elif isinstance(val, str):
                            # Экранируем кавычки в строках
                            escaped_val = val.replace("'", "''")
                            values.append(f"'{escaped_val}'")
                        elif isinstance(val, (int, float)):
                            values.append(str(val))
                        else:
                            values.append(f"'{val}'")
                    
                    columns_str = ', '.join(columns)
                    values_str = ', '.join(values)
                    f.write(f"INSERT INTO {table_name} ({columns_str}) VALUES ({values_str});\n")
                
                f.write(f"\n")
        
        # Включаем обратно проверки внешних ключей
        f.write("SET session_replication_role = DEFAULT;\n")
        
        # Обновляем последовательности для автоинкремента
        f.write("\n-- Обновление последовательностей\n")
        for table_name in [t[0] for t in tables]:
            f.write(f"SELECT setval(pg_get_serial_sequence('{table_name}', 'id'), COALESCE(max(id), 1)) FROM {table_name};\n")
    
    conn.close()
    print(f"✅ Экспорт завершен: {output_file}")

def main():
    if len(sys.argv) < 2:
        print("Использование:")
        print("  python sqlite_to_postgres.py <path_to_sqlite.db>")
        print("Пример:")
        print("  python sqlite_to_postgres.py app.db")
        sys.exit(1)
    
    sqlite_db_path = sys.argv[1]
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    output_file = f"maroai_postgres_dump_{timestamp}.sql"
    
    try:
        export_sqlite_to_sql(sqlite_db_path, output_file)
        print(f"\n📤 Теперь загрузите файл {output_file} на сервер:")
        print(f"scp {output_file} ubuntu@85.202.192.20:~/")
    except Exception as e:
        print(f"❌ Ошибка: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main() 