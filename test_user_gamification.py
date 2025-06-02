#!/usr/bin/env python3
"""
Тестирование системы геймификации для пользователя marguberk@gmail.com
"""

import requests
import json
import sqlite3

BASE_URL = "http://localhost:8002/api/v1"

def get_auth_token(email: str, password: str):
    """Получение токена авторизации"""
    response = requests.post(
        f"{BASE_URL}/auth/login",
        headers={"Content-Type": "application/x-www-form-urlencoded"},
        data={"username": email, "password": password}
    )
    if response.status_code == 200:
        return response.json()["access_token"]
    else:
        print(f"Ошибка авторизации: {response.text}")
        return None

def complete_course(token: str, course_id: int):
    """Завершение курса"""
    headers = {"Authorization": f"Bearer {token}"}
    response = requests.post(f"{BASE_URL}/gamification/complete-course/{course_id}", headers=headers)
    
    if response.status_code == 200:
        result = response.json()
        print(f"\n🎉 Курс {course_id} завершен!")
        print(f"📚 Название: {result['course_title']}")
        print(f"💰 Получено XP: {result['xp_result']['xp_gained']}")
        print(f"📊 Общий XP: {result['xp_result']['total_xp']}")
        print(f"⬆️ Уровень: {result['xp_result']['old_level']} → {result['xp_result']['new_level']}")
        if result['xp_result']['level_up']:
            print("🎊 ПОВЫШЕНИЕ УРОВНЯ!")
        
        print(f"🎯 Навык: {result['skill_result']['skill_name']}")
        print(f"📈 Прогресс навыка: {result['skill_result']['old_score']}% → {result['skill_result']['new_score']}%")
        print(f"🏅 Уровень навыка: {result['skill_result']['old_level']} → {result['skill_result']['new_level']}")
        
        if result['achievements']:
            print(f"🏆 Новые достижения: {', '.join(result['achievements'])}")
        
        return result
    else:
        print(f"Ошибка завершения курса {course_id}: {response.text}")
        return None

def get_progress(token: str):
    """Получение прогресса пользователя"""
    headers = {"Authorization": f"Bearer {token}"}
    response = requests.get(f"{BASE_URL}/gamification/progress", headers=headers)
    
    if response.status_code == 200:
        progress = response.json()
        print(f"\n📊 ТЕКУЩИЙ ПРОГРЕСС:")
        print(f"🎖️ Уровень: {progress['level']}")
        print(f"💰 XP: {progress['current_xp']}")
        print(f"⏭️ До следующего уровня: {progress['xp_to_next_level']} XP")
        print(f"📚 Завершено курсов: {progress['courses_completed']}")
        print(f"📝 Завершено уроков: {progress['lessons_completed']}")
        print(f"⭐ Отличных оценок: {progress['perfect_scores']}")
        return progress
    else:
        print(f"Ошибка получения прогресса: {response.text}")
        return None

def get_dashboard(token: str):
    """Получение дашборда"""
    headers = {"Authorization": f"Bearer {token}"}
    response = requests.get(f"{BASE_URL}/gamification/dashboard", headers=headers)
    
    if response.status_code == 200:
        dashboard = response.json()
        print(f"\n🎮 ДАШБОРД ГЕЙМИФИКАЦИИ:")
        print(f"🎖️ Уровень: {dashboard['level']} ({dashboard['level_name']})")
        print(f"💰 XP: {dashboard['current_xp']}/{dashboard['next_level_xp']}")
        print(f"📊 Прогресс: {dashboard['progress_percentage']}%")
        print(f"📚 Курсы: {dashboard['completed_courses']}/{dashboard['total_courses']}")
        return dashboard
    else:
        print(f"Ошибка получения дашборда: {response.text}")
        return None

def reset_user_progress(email: str):
    """Сброс прогресса пользователя для демонстрации"""
    conn = sqlite3.connect('app.db')
    cursor = conn.cursor()
    
    # Получаем ID пользователя
    cursor.execute("SELECT id FROM users WHERE email = ?", (email,))
    user_result = cursor.fetchone()
    if not user_result:
        print(f"Пользователь {email} не найден")
        return
    
    user_id = user_result[0]
    
    # Удаляем записи о завершении курсов
    cursor.execute("DELETE FROM course_completions WHERE user_id = ?", (user_id,))
    
    # Сбрасываем игровой профиль
    cursor.execute("""
        UPDATE user_game_profiles 
        SET level = 1, experience_points = 0, courses_completed = 0, 
            lessons_completed = 0, perfect_scores = 0
        WHERE user_id = ?
    """, (user_id,))
    
    conn.commit()
    conn.close()
    print(f"✅ Прогресс пользователя {email} сброшен")

def main():
    print("🎮 ТЕСТИРОВАНИЕ СИСТЕМЫ ГЕЙМИФИКАЦИИ MaroAI")
    print("=" * 50)
    
    # Данные пользователя
    email = "admin@maroai.com"
    password = "admin123"
    
    # Сброс прогресса для демонстрации
    print("🔄 Сброс прогресса для демонстрации...")
    reset_user_progress(email)
    
    # Авторизация
    print(f"\n🔐 Авторизация пользователя {email}...")
    token = get_auth_token(email, password)
    if not token:
        return
    
    print("✅ Авторизация успешна!")
    
    # Начальный прогресс
    get_progress(token)
    get_dashboard(token)
    
    # Тестируем завершение курсов
    courses_to_test = [1, 2, 3]  # Коммуникация, Лидерство, Решение проблем
    
    for course_id in courses_to_test:
        print(f"\n{'='*50}")
        print(f"📚 ЗАВЕРШЕНИЕ КУРСА {course_id}")
        print(f"{'='*50}")
        
        complete_course(token, course_id)
        get_progress(token)
    
    # Финальный дашборд
    print(f"\n{'='*50}")
    print("🏁 ФИНАЛЬНЫЕ РЕЗУЛЬТАТЫ")
    print(f"{'='*50}")
    get_dashboard(token)
    
    print(f"\n🎉 Демонстрация завершена!")
    print("💡 Теперь вы можете использовать фронтенд для прохождения курсов")
    print("🔗 Откройте http://localhost:3000 и войдите под своим аккаунтом")

if __name__ == "__main__":
    main() 