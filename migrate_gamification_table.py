import sqlite3
from datetime import datetime

def migrate_gamification_table():
    """Обновляет структуру таблицы user_game_profiles для геймификации"""
    
    print("🔄 Миграция таблицы геймификации...")
    
    # Подключаемся к базе данных
    conn = sqlite3.connect('app.db')
    cursor = conn.cursor()
    
    try:
        # Проверяем, есть ли столбец experience_points
        cursor.execute("PRAGMA table_info(user_game_profiles)")
        columns = [row[1] for row in cursor.fetchall()]
        
        # Добавляем недостающие столбцы
        if 'experience_points' not in columns:
            cursor.execute('ALTER TABLE user_game_profiles ADD COLUMN experience_points INTEGER DEFAULT 0')
            print("   ✅ Добавлен столбец experience_points")
        
        # Переименовываем experience в experience_points если нужно
        if 'experience' in columns and 'experience_points' not in columns:
            # SQLite не поддерживает RENAME COLUMN до версии 3.25.0
            # Поэтому добавляем новый столбец и копируем данные
            cursor.execute('ALTER TABLE user_game_profiles ADD COLUMN experience_points INTEGER DEFAULT 0')
            cursor.execute('UPDATE user_game_profiles SET experience_points = experience WHERE experience IS NOT NULL')
            print("   ✅ Скопированы данные из experience в experience_points")
        
        # Убеждаемся, что все нужные столбцы существуют
        required_columns = {
            'level': 'INTEGER DEFAULT 1',
            'experience_points': 'INTEGER DEFAULT 0',
            'total_points': 'INTEGER DEFAULT 0',
            'courses_completed': 'INTEGER DEFAULT 0',
            'lessons_completed': 'INTEGER DEFAULT 0',
            'perfect_scores': 'INTEGER DEFAULT 0',
            'login_streak': 'INTEGER DEFAULT 0',
            'longest_streak': 'INTEGER DEFAULT 0',
            'badges': 'JSON',
            'titles': 'JSON',
            'last_login': 'DATETIME',
            'last_action': 'DATETIME'
        }
        
        # Проверяем столбцы снова после изменений
        cursor.execute("PRAGMA table_info(user_game_profiles)")
        current_columns = [row[1] for row in cursor.fetchall()]
        
        for column, column_type in required_columns.items():
            if column not in current_columns:
                cursor.execute(f'ALTER TABLE user_game_profiles ADD COLUMN {column} {column_type}')
                print(f"   ✅ Добавлен столбец {column}")
        
        # Создаем тестовые достижения если их нет
        cursor.execute("SELECT COUNT(*) FROM achievements")
        achievement_count = cursor.fetchone()[0]
        
        if achievement_count == 0:
            print("\n🏆 Создание тестовых достижений...")
            
            achievements = [
                ("Первые шаги", "Завершите свой первый курс", "🎯", 1, 0, 0),
                ("Студент", "Завершите 3 курса", "📚", 3, 0, 0),
                ("Эксперт", "Завершите 5 курсов", "🏆", 5, 0, 0),
                ("Отличник", "Получите 10 отличных оценок", "⭐", 0, 0, 0),
                ("Марафонец", "Завершите 20 уроков", "🏃‍♂️", 0, 20, 0),
                ("Первооткрыватель", "Начните первый урок", "🚀", 0, 1, 0),
                ("Мастер коммуникации", "Завершите 2 курса по коммуникации", "💬", 2, 0, 0),
                ("Лидер", "Завершите курс лидерства", "👑", 1, 0, 0),
            ]
            
            for title, description, badge, req_courses, req_lessons, req_score in achievements:
                cursor.execute("""
                    INSERT INTO achievements (title, description, badge_image, required_courses, required_lessons, required_score)
                    VALUES (?, ?, ?, ?, ?, ?)
                """, (title, description, badge, req_courses, req_lessons, req_score))
            
            print(f"   ✅ Создано {len(achievements)} достижений")
        
        # Создаем игровой профиль для тестового пользователя если его нет
        cursor.execute("SELECT COUNT(*) FROM user_game_profiles WHERE user_id = 1")
        profile_count = cursor.fetchone()[0]
        
        if profile_count == 0:
            cursor.execute("""
                INSERT INTO user_game_profiles 
                (user_id, level, experience_points, courses_completed, lessons_completed, perfect_scores, login_streak, longest_streak, badges, titles)
                VALUES (1, 2, 10, 0, 0, 0, 0, 0, '[]', '[]')
            """)
            print("   ✅ Создан игровой профиль для тестового пользователя")
        
        conn.commit()
        print("\n✅ Миграция завершена успешно!")
        
        # Показываем итоговую структуру
        print("\n📋 Итоговая структура таблицы:")
        cursor.execute("PRAGMA table_info(user_game_profiles)")
        for row in cursor.fetchall():
            print(f"   {row[1]}: {row[2]}")
        
    except Exception as e:
        print(f"❌ Ошибка миграции: {e}")
        conn.rollback()
    finally:
        conn.close()

if __name__ == "__main__":
    migrate_gamification_table() 