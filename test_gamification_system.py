import sqlite3
import json
from datetime import datetime

def test_gamification_system():
    """Тестирует систему геймификации"""
    
    print("🎮 Тестирование системы геймификации MaroAI")
    print("=" * 50)
    
    # Подключаемся к базе данных
    conn = sqlite3.connect('app.db')
    cursor = conn.cursor()
    
    # 1. Проверяем текущий статус пользователя
    print("\n1️⃣ Текущий статус пользователя:")
    
    user_id = 1  # Тестовый пользователь
    
    # Проверяем игровой профиль
    cursor.execute("""
        SELECT level, experience_points, courses_completed, lessons_completed, perfect_scores
        FROM user_game_profiles 
        WHERE user_id = ?
    """, (user_id,))
    
    game_profile = cursor.fetchone()
    
    if game_profile:
        level, xp, courses, lessons, perfect = game_profile
        print(f"   📊 Уровень: {level}")
        print(f"   ⭐ Опыт: {xp} XP")
        print(f"   📚 Курсы завершены: {courses}")
        print(f"   📝 Уроки завершены: {lessons}")
        print(f"   🏆 Отличные оценки: {perfect}")
    else:
        print("   ❌ Игровой профиль не найден")
    
    # 2. Проверяем навыки пользователя
    print("\n2️⃣ Текущие навыки пользователя:")
    
    cursor.execute("""
        SELECT s.name, usa.score, usa.level, usa.recommendations
        FROM user_skill_assessments usa
        JOIN skill_assessments sa ON usa.assessment_id = sa.id
        JOIN soft_skills s ON usa.skill_id = s.id
        WHERE sa.user_id = ? AND sa.is_completed = 1
        ORDER BY sa.completed_at DESC
        LIMIT 6
    """, (user_id,))
    
    skills = cursor.fetchall()
    
    for skill_name, score, level, recommendations in skills:
        level_text = {
            'BEGINNER': 'Начальный',
            'INTERMEDIATE': 'Средний', 
            'ADVANCED': 'Продвинутый',
            'EXPERT': 'Экспертный'
        }.get(level, level)
        
        print(f"   🎯 {skill_name}: {score}% ({level_text})")
    
    # 3. Проверяем доступные курсы
    print("\n3️⃣ Доступные курсы:")
    
    cursor.execute("""
        SELECT id, title, skill_type, difficulty_level
        FROM courses 
        WHERE is_published = 1
        ORDER BY id
    """, )
    
    courses = cursor.fetchall()
    
    for course_id, title, skill_type, difficulty in courses:
        # Проверяем, завершен ли курс
        cursor.execute("""
            SELECT id FROM course_completions 
            WHERE user_id = ? AND course_id = ?
        """, (user_id, course_id))
        
        completed = cursor.fetchone() is not None
        status = "✅ Завершен" if completed else "📖 Доступен"
        
        print(f"   {status} Курс {course_id}: {title} ({skill_type})")
    
    # 4. Показываем возможности тестирования
    print("\n4️⃣ Команды для тестирования:")
    print("   curl -X POST 'http://localhost:8002/api/v1/gamification/complete-course/1' \\")
    print("        -H 'Authorization: Bearer YOUR_TOKEN'")
    print()
    print("   curl 'http://localhost:8002/api/v1/gamification/progress' \\")
    print("        -H 'Authorization: Bearer YOUR_TOKEN'")
    print()
    print("   curl 'http://localhost:8002/api/v1/gamification/dashboard' \\")
    print("        -H 'Authorization: Bearer YOUR_TOKEN'")
    
    # 5. Создаем тестовые данные для достижений, если их нет
    cursor.execute("SELECT COUNT(*) FROM achievements")
    achievement_count = cursor.fetchone()[0]
    
    if achievement_count == 0:
        print("\n5️⃣ Создание тестовых достижений...")
        
        achievements = [
            ("Первые шаги", "Завершите свой первый курс", "🎯", 1, 0, 0),
            ("Студент", "Завершите 3 курса", "📚", 3, 0, 0),
            ("Эксперт", "Завершите 5 курсов", "🏆", 5, 0, 0),
            ("Отличник", "Получите 10 отличных оценок", "⭐", 0, 0, 0),
            ("Марафонец", "Завершите 20 уроков", "🏃‍♂️", 0, 20, 0),
        ]
        
        for title, description, badge, req_courses, req_lessons, req_score in achievements:
            cursor.execute("""
                INSERT INTO achievements (title, description, badge_image, required_courses, required_lessons, required_score)
                VALUES (?, ?, ?, ?, ?, ?)
            """, (title, description, badge, req_courses, req_lessons, req_score))
        
        conn.commit()
        print("   ✅ Тестовые достижения созданы")
    
    # 6. Показываем уровни XP
    print("\n6️⃣ Система уровней:")
    
    level_thresholds = [0, 150, 350, 600, 900, 1250, 1650, 2100, 2600, 3150]
    level_names = ["Новичок", "Начинающий", "Практик", "Опытный", "Эксперт", 
                   "Мастер", "Гуру", "Легенда", "Чемпион", "Великий мастер"]
    
    for i, (threshold, name) in enumerate(zip(level_thresholds, level_names), 1):
        print(f"   Уровень {i}: {name} ({threshold} XP)")
    
    # 7. Награды за действия
    print("\n7️⃣ Система наград:")
    print("   📝 Завершение урока: +10 XP")
    print("   📚 Завершение курса: +50 XP")
    print("   ⭐ Отличная оценка (90%+): +15 XP бонус")
    print("   🎯 Первый курс: +25 XP бонус")
    print("   🔥 Стрик активности: +5 XP бонус")
    
    print("\n✅ Система геймификации готова к тестированию!")
    print("🚀 Запустите сервер и используйте команды curl выше для тестирования")
    
    conn.close()

if __name__ == "__main__":
    test_gamification_system() 