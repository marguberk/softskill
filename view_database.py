#!/usr/bin/env python3
"""
Утилита для просмотра базы данных MaroAI
Использование: python view_database.py
"""

import sqlite3
import pandas as pd
from tabulate import tabulate

def connect_db():
    """Подключение к базе данных"""
    try:
        conn = sqlite3.connect('app.db')
        return conn
    except sqlite3.Error as e:
        print(f"Ошибка подключения к БД: {e}")
        return None

def show_tables(conn):
    """Показать все таблицы"""
    cursor = conn.cursor()
    cursor.execute("SELECT name FROM sqlite_master WHERE type='table';")
    tables = cursor.fetchall()
    
    print("🗄️ ТАБЛИЦЫ В БАЗЕ ДАННЫХ:")
    print("=" * 50)
    for i, (table,) in enumerate(tables, 1):
        cursor.execute(f"SELECT COUNT(*) FROM {table}")
        count = cursor.fetchone()[0]
        print(f"{i:2}. {table:<25} ({count} записей)")
    print()

def show_users(conn):
    """Показать пользователей"""
    query = "SELECT id, email, full_name, role, created_at FROM users ORDER BY id"
    df = pd.read_sql_query(query, conn)
    
    print("👥 ПОЛЬЗОВАТЕЛИ:")
    print("=" * 80)
    print(tabulate(df, headers=df.columns, tablefmt='grid', showindex=False))
    print()

def show_courses(conn):
    """Показать курсы"""
    query = """
    SELECT id, title, skill_type, difficulty_level, 
           duration_hours, is_published 
    FROM courses ORDER BY id
    """
    df = pd.read_sql_query(query, conn)
    
    print("📚 КУРСЫ:")
    print("=" * 120)
    print(tabulate(df, headers=df.columns, tablefmt='grid', showindex=False))
    print()

def show_course_structure(conn):
    """Показать структуру курсов"""
    query = """
    SELECT c.title as 'Курс', 
           m.title as 'Модуль',
           COUNT(l.id) as 'Количество уроков'
    FROM courses c 
    LEFT JOIN modules m ON c.id = m.course_id 
    LEFT JOIN lessons l ON m.id = l.module_id 
    GROUP BY c.id, m.id 
    ORDER BY c.id, m."order"
    """
    df = pd.read_sql_query(query, conn)
    
    print("🏗️ СТРУКТУРА КУРСОВ:")
    print("=" * 100)
    print(tabulate(df, headers=df.columns, tablefmt='grid', showindex=False))
    print()

def show_sample_lessons(conn):
    """Показать примеры уроков"""
    query = """
    SELECT l.id, l.title as 'Урок', 
           m.title as 'Модуль', 
           c.title as 'Курс'
    FROM lessons l
    JOIN modules m ON l.module_id = m.id
    JOIN courses c ON m.course_id = c.id
    ORDER BY c.id, m."order", l."order"
    LIMIT 15
    """
    df = pd.read_sql_query(query, conn)
    
    print("📖 ПРИМЕРЫ УРОКОВ:")
    print("=" * 120)
    print(tabulate(df, headers=df.columns, tablefmt='grid', showindex=False))
    print()

def show_achievements(conn):
    """Показать достижения"""
    query = "SELECT id, title, description, points FROM achievements LIMIT 10"
    try:
        df = pd.read_sql_query(query, conn)
        if not df.empty:
            print("🏆 ДОСТИЖЕНИЯ:")
            print("=" * 100)
            print(tabulate(df, headers=df.columns, tablefmt='grid', showindex=False))
            print()
        else:
            print("🏆 ДОСТИЖЕНИЯ: Пока не созданы\n")
    except:
        print("🏆 ДОСТИЖЕНИЯ: Таблица не найдена\n")

def interactive_query(conn):
    """Интерактивные запросы"""
    print("💻 ИНТЕРАКТИВНЫЙ РЕЖИМ:")
    print("Введите SQL запрос (или 'exit' для выхода):")
    
    while True:
        try:
            query = input("SQL> ").strip()
            if query.lower() == 'exit':
                break
            if not query:
                continue
                
            df = pd.read_sql_query(query, conn)
            print(tabulate(df, headers=df.columns, tablefmt='grid', showindex=False))
            print()
        except Exception as e:
            print(f"Ошибка: {e}\n")

def main():
    """Главная функция"""
    print("🎯 ПРОСМОТР БАЗЫ ДАННЫХ MaroAI")
    print("=" * 50)
    
    conn = connect_db()
    if not conn:
        return
    
    try:
        # Установка pandas опций для лучшего отображения
        pd.set_option('display.max_columns', None)
        pd.set_option('display.width', None)
        pd.set_option('display.max_colwidth', 50)
        
        show_tables(conn)
        show_users(conn)
        show_courses(conn)
        show_course_structure(conn)
        show_sample_lessons(conn)
        show_achievements(conn)
        
        # Интерактивный режим
        choice = input("Хотите выполнить собственные SQL запросы? (y/n): ")
        if choice.lower() == 'y':
            interactive_query(conn)
            
    except Exception as e:
        print(f"Ошибка: {e}")
    finally:
        conn.close()
        print("✅ Подключение к БД закрыто")

if __name__ == "__main__":
    main() 