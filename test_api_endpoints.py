#!/usr/bin/env python3
"""
Скрипт для тестирования API endpoints MaroAI
"""
import requests
import json

BASE_URL = "http://localhost:8002"

def test_endpoints():
    print("🚀 Тестирование API endpoints MaroAI")
    print("=" * 50)
    
    # 1. Главная страница
    try:
        response = requests.get(f"{BASE_URL}/")
        if response.status_code == 200:
            print("✅ Главная страница: OK")
        else:
            print(f"❌ Главная страница: {response.status_code}")
    except Exception as e:
        print(f"❌ Главная страница: Ошибка подключения - {e}")
    
    # 2. Список курсов
    try:
        response = requests.get(f"{BASE_URL}/api/v1/courses/")
        if response.status_code == 200:
            courses = response.json()
            print(f"✅ Список курсов: OK ({len(courses)} курсов)")
            for course in courses:
                print(f"   - {course['title']}")
        else:
            print(f"❌ Список курсов: {response.status_code}")
    except Exception as e:
        print(f"❌ Список курсов: {e}")
    
    # 3. Конкретный курс
    try:
        response = requests.get(f"{BASE_URL}/api/v1/courses/1")
        if response.status_code == 200:
            course = response.json()
            print(f"✅ Курс #1: OK - {course['title']}")
        else:
            print(f"❌ Курс #1: {response.status_code}")
    except Exception as e:
        print(f"❌ Курс #1: {e}")
    
    # 4. Уроки курса
    try:
        response = requests.get(f"{BASE_URL}/api/v1/courses/1/lessons")
        if response.status_code == 200:
            lessons_data = response.json()
            lessons = lessons_data['lessons']
            print(f"✅ Уроки курса #1: OK ({len(lessons)} уроков)")
            for lesson in lessons:
                print(f"   - Урок {lesson['order_position']}: {lesson['material']['title']}")
        else:
            print(f"❌ Уроки курса #1: {response.status_code}")
    except Exception as e:
        print(f"❌ Уроки курса #1: {e}")
    
    # 5. Конкретный урок
    try:
        response = requests.get(f"{BASE_URL}/api/v1/courses/1/lessons/1")
        if response.status_code == 200:
            lesson = response.json()
            print(f"✅ Урок #1: OK - {lesson['material']['title']}")
            print(f"   - Заданий: {len(lesson['tasks'])}")
            print(f"   - Видео: {lesson['material']['video_url'] is not None}")
        else:
            print(f"❌ Урок #1: {response.status_code}")
    except Exception as e:
        print(f"❌ Урок #1: {e}")
    
    print("\n🎯 Проверка завершена!")

if __name__ == "__main__":
    test_endpoints() 