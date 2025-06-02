# 🎮 Система геймификации MaroAI

## 📋 Обзор

Система геймификации MaroAI предназначена для мотивации пользователей к изучению гибких навыков через игровые механики: опыт (XP), уровни, достижения и прогресс навыков.

## 🎯 Основные компоненты

### 1. Система опыта (XP) и уровней

**Начисление XP:**
- 📝 Завершение урока: **+10 XP**
- 📚 Завершение курса: **+100 XP**
- ⭐ Отличная оценка (90%+): **+15 XP бонус**
- 🎯 Первый курс: **+50 XP бонус**
- 🔥 Стрик активности: **+5 XP бонус**

**Система уровней:**
1. **Новичок** (0 XP)
2. **Начинающий** (150 XP)
3. **Практик** (350 XP)
4. **Опытный** (600 XP)
5. **Эксперт** (900 XP)
6. **Мастер** (1250 XP)
7. **Гуру** (1650 XP)
8. **Легенда** (2100 XP)
9. **Чемпион** (2600 XP)
10. **Великий мастер** (3150 XP)

### 2. Прогресс навыков

При завершении курса автоматически обновляется соответствующий навык:

**Улучшение навыка зависит от текущего уровня:**
- Любой уровень: **+20 баллов за курс** (единое значение для всех курсов)

**Уровни навыков:**
- **BEGINNER** (0-49%)
- **INTERMEDIATE** (50-69%)
- **ADVANCED** (70-84%)
- **EXPERT** (85%+)

### 3. Достижения

Система автоматически проверяет и выдает достижения:

- 🎯 **Первые шаги** - Завершите свой первый курс
- 📚 **Студент** - Завершите 3 курса
- 🏆 **Эксперт** - Завершите 5 курсов
- ⭐ **Отличник** - Получите 10 отличных оценок
- 🏃‍♂️ **Марафонец** - Завершите 20 уроков
- 🚀 **Первооткрыватель** - Начните первый урок
- 💬 **Мастер коммуникации** - Завершите 2 курса по коммуникации
- 👑 **Лидер** - Завершите курс лидерства

## 🔧 API Endpoints

### Завершение курса
```http
POST /api/v1/gamification/complete-course/{course_id}
Authorization: Bearer {token}
```

**Ответ:**
```json
{
  "course_id": 1,
  "course_title": "Основы коммуникации",
  "xp_result": {
    "xp_gained": 75,
    "total_xp": 85,
    "old_level": 1,
    "new_level": 1,
    "level_up": false,
    "reason": "course_complete"
  },
  "skill_result": {
    "skill_name": "Коммуникация",
    "old_score": 60,
    "new_score": 72,
    "old_level": "INTERMEDIATE",
    "new_level": "ADVANCED",
    "level_up": true,
    "courses_completed": 1
  },
  "achievements": ["Первые шаги"],
  "completion_message": "🎉 Поздравляем! Вы успешно завершили курс \"Основы коммуникации\"!"
}
```

### Завершение урока
```http
POST /api/v1/gamification/complete-lesson/{lesson_id}?score=95
Authorization: Bearer {token}
```

### Получение прогресса
```http
GET /api/v1/gamification/progress
Authorization: Bearer {token}
```

**Ответ:**
```json
{
  "level": 2,
  "current_xp": 85,
  "xp_to_next_level": 265,
  "overall_progress": 2,
  "courses_completed": 1,
  "lessons_completed": 5,
  "perfect_scores": 2,
  "current_streak": 3,
  "longest_streak": 5
}
```

### Дашборд прогресса
```http
GET /api/v1/gamification/dashboard
Authorization: Bearer {token}
```

**Ответ:**
```json
{
  "level": 2,
  "level_name": "Начинающий",
  "current_xp": 85,
  "next_level_xp": 350,
  "progress_percentage": 24,
  "total_courses": 7,
  "completed_courses": 1,
  "skills_summary": [
    {
      "name": "Коммуникация",
      "score": 72,
      "level": "продвинутый"
    }
  ],
  "recent_achievements": []
}
```

### Игровой профиль
```http
GET /api/v1/gamification/profile
Authorization: Bearer {token}
```

## 🗄️ Структура базы данных

### Таблица `user_game_profiles`
```sql
CREATE TABLE user_game_profiles (
    id INTEGER PRIMARY KEY,
    user_id INTEGER,
    level INTEGER DEFAULT 1,
    experience_points INTEGER DEFAULT 0,
    courses_completed INTEGER DEFAULT 0,
    lessons_completed INTEGER DEFAULT 0,
    perfect_scores INTEGER DEFAULT 0,
    login_streak INTEGER DEFAULT 0,
    longest_streak INTEGER DEFAULT 0,
    badges JSON,
    titles JSON,
    last_login DATETIME,
    last_action DATETIME,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME
);
```

### Таблица `course_completions`
```sql
CREATE TABLE course_completions (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    course_id INTEGER NOT NULL,
    completed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    final_score INTEGER,
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(course_id) REFERENCES courses(id)
);
```

### Таблица `achievements`
```sql
CREATE TABLE achievements (
    id INTEGER PRIMARY KEY,
    title VARCHAR NOT NULL,
    description VARCHAR,
    badge_image VARCHAR,
    required_courses INTEGER,
    required_lessons INTEGER,
    required_score FLOAT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
```

### Таблица `user_achievements`
```sql
CREATE TABLE user_achievements (
    id INTEGER PRIMARY KEY,
    user_id INTEGER,
    achievement_id INTEGER,
    achieved_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(achievement_id) REFERENCES achievements(id)
);
```

## 🚀 Тестирование

### 1. Запуск сервера
```bash
uvicorn main:app --host 0.0.0.0 --port 8002 --reload
```

### 2. Тестирование через HTML
Откройте файл `test_gamification_api.html` в браузере для интерактивного тестирования.

### 3. Тестирование через curl
```bash
# Получение токена
curl -X POST "http://localhost:8002/api/v1/auth/login" \
     -H "Content-Type: application/x-www-form-urlencoded" \
     -d "username=admin@example.com&password=admin123"

# Завершение курса
curl -X POST "http://localhost:8002/api/v1/gamification/complete-course/1" \
     -H "Authorization: Bearer YOUR_TOKEN"

# Получение прогресса
curl "http://localhost:8002/api/v1/gamification/progress" \
     -H "Authorization: Bearer YOUR_TOKEN"
```

### 4. Проверка системы
```bash
python test_gamification_system.py
```

## 📈 Логика работы

1. **При завершении курса:**
   - Начисляется базовый XP (50) + бонусы
   - Обновляется счетчик завершенных курсов
   - Проверяется повышение уровня
   - Обновляется соответствующий навык
   - Проверяются и выдаются достижения

2. **При завершении урока:**
   - Начисляется базовый XP (10) + бонусы за оценку
   - Обновляется счетчик завершенных уроков
   - Проверяется повышение уровня
   - Проверяются достижения

3. **Обновление навыков:**
   - Находится последняя оценка навыков пользователя
   - Определяется соответствующий навык по типу курса
   - Рассчитывается улучшение на основе текущего уровня
   - Обновляется балл и уровень навыка
   - Генерируются новые рекомендации

## 🔄 Миграция

Для обновления структуры базы данных:
```bash
python migrate_gamification_table.py
```

## 🎨 Интеграция с фронтендом

Система предоставляет все необходимые данные для отображения:
- Текущий уровень и прогресс
- Баллы опыта и до следующего уровня
- Статистика по курсам и урокам
- Прогресс по навыкам
- Полученные достижения

Данные можно использовать для создания:
- Прогресс-баров
- Карточек достижений
- Дашборда с аналитикой
- Системы уведомлений о повышении уровня 