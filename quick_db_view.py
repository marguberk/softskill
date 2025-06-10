#!/usr/bin/env python3
"""
Быстрый просмотр ключевых таблиц базы данных MaroAI
"""

import sqlite3

def main():
    """Главная функция"""
    print("🎯 КРАТКИЙ ОБЗОР БАЗЫ ДАННЫХ MaroAI")
    print("=" * 60)
    
    try:
        conn = sqlite3.connect('app.db')
        cursor = conn.cursor()
        
        # Статистика по основным таблицам
        print("\n📊 СТАТИСТИКА:")
        tables = ['users', 'courses', 'lessons', 'modules', 'achievements', 'user_achievements']
        for table in tables:
            try:
                cursor.execute(f"SELECT COUNT(*) FROM {table}")
                count = cursor.fetchone()[0]
                print(f"  {table:<20}: {count:>3} записей")
            except:
                print(f"  {table:<20}: --- (таблица не найдена)")
        
        # Пользователи
        print("\n👥 ПОЛЬЗОВАТЕЛИ:")
        cursor.execute("SELECT id, email, full_name, role FROM users ORDER BY id")
        for row in cursor.fetchall():
            print(f"  {row[0]:2}. {row[1]:<25} | {row[2]:<20} | {row[3]}")
        
        # Курсы
        print("\n📚 КУРСЫ:")
        cursor.execute("SELECT id, title, skill_type, difficulty_level FROM courses ORDER BY id")
        for row in cursor.fetchall():
            print(f"  {row[0]}. {row[1]:<40} | {row[2]:<15} | {row[3]}")
        
        # Примеры уроков
        print("\n📖 ПРИМЕРЫ УРОКОВ (первые 10):")
        cursor.execute("""
            SELECT l.id, l.title, c.title 
            FROM lessons l
            JOIN modules m ON l.module_id = m.id
            JOIN courses c ON m.course_id = c.id
            ORDER BY l.id LIMIT 10
        """)
        for row in cursor.fetchall():
            print(f"  {row[0]:2}. {row[1]:<35} | Курс: {row[2]}")
        
        # Достижения
        print("\n🏆 ДОСТИЖЕНИЯ:")
        try:
            cursor.execute("SELECT id, title, points FROM achievements LIMIT 5")
            achievements = cursor.fetchall()
            if achievements:
                for row in achievements:
                    print(f"  {row[0]}. {row[1]:<30} | {row[2]} очков")
            else:
                print("  Достижения пока не созданы")
        except:
            print("  Таблица достижений не найдена")
        
        conn.close()
        print("\n✅ Готово!")
        
    except Exception as e:
        print(f"❌ Ошибка: {e}")

if __name__ == "__main__":
    main() 