# 🗄️ Структура Базы Данных MaroAI

## 📊 Общая информация
- **Тип БД:** SQLite
- **Файл:** `app.db` (909 КБ)
- **Количество таблиц:** 48
- **Резервная копия:** `maroai_backup.db`

## 📈 Статистика данных
- **Пользователи:** 11 записей
- **Курсы:** 7 записей
- **Уроки:** 24 записи
- **Модули:** Множественные для каждого курса

## 🏗️ Архитектура базы данных

### 🔑 Основные таблицы

#### 1. **users** - Пользователи системы
```sql
CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    email VARCHAR NOT NULL UNIQUE,
    hashed_password VARCHAR NOT NULL,
    full_name VARCHAR,
    role VARCHAR NOT NULL,
    is_active BOOLEAN,
    created_at DATETIME DEFAULT (CURRENT_TIMESTAMP),
    updated_at DATETIME
);
```

**Примеры данных:**
| id | email | full_name | role |
|----|-------|-----------|------|
| 2 | test@test.com | Test User | student |
| 4 | soma@gmail.com | Самат Беков | student |
| 7 | admin@test.ru | Администратор | student |

#### 2. **courses** - Курсы обучения
```sql
CREATE TABLE courses (
    id INTEGER PRIMARY KEY,
    title VARCHAR NOT NULL,
    description TEXT,
    skill_type VARCHAR(22) NOT NULL,
    difficulty_level VARCHAR(12) NOT NULL,
    duration_hours INTEGER,
    price FLOAT,
    is_published BOOLEAN,
    author_id INTEGER,
    created_at DATETIME DEFAULT (CURRENT_TIMESTAMP),
    updated_at DATETIME,
    FOREIGN KEY(author_id) REFERENCES users (id)
);
```

**Все курсы в системе:**
| id | title | skill_type | difficulty_level | duration_hours |
|----|-------|------------|------------------|----------------|
| 1 | Основы коммуникации | COMMUNICATION | BEGINNER | 10 |
| 2 | Лидерство в команде | LEADERSHIP | INTERMEDIATE | 15 |
| 3 | Управление временем | TIME_MANAGEMENT | BEGINNER | 8 |
| 4 | Эмоциональный интеллект в профессиональной среде | EMOTIONAL_INTELLIGENCE | INTERMEDIATE | 11 |
| 5 | Решение проблем и критическое мышление | PROBLEM_SOLVING | INTERMEDIATE | 9 |
| 6 | Командная работа и сотрудничество | TEAMWORK | BEGINNER | 8 |
| 7 | Продвинутая деловая коммуникация | COMMUNICATION | ADVANCED | 9 |

#### 3. **lessons** - Уроки курсов
```sql
CREATE TABLE lessons (
    id INTEGER PRIMARY KEY,
    title VARCHAR NOT NULL,
    content TEXT,
    "order" INTEGER,
    module_id INTEGER,
    created_at DATETIME DEFAULT (CURRENT_TIMESTAMP),
    updated_at DATETIME,
    FOREIGN KEY(module_id) REFERENCES modules (id)
);
```

#### 4. **modules** - Модули курсов
```sql
CREATE TABLE modules (
    id INTEGER PRIMARY KEY,
    title VARCHAR NOT NULL,
    description TEXT,
    course_id INTEGER,
    "order" INTEGER,
    created_at DATETIME DEFAULT (CURRENT_TIMESTAMP),
    updated_at DATETIME,
    FOREIGN KEY(course_id) REFERENCES courses (id)
);
```

### 🎯 Прогресс и достижения

#### 5. **user_progress** - Прогресс пользователей
```sql
CREATE TABLE user_progress (
    id INTEGER PRIMARY KEY,
    user_id INTEGER,
    course_id INTEGER,
    lesson_id INTEGER,
    completed BOOLEAN,
    completion_date DATETIME,
    FOREIGN KEY(user_id) REFERENCES users (id),
    FOREIGN KEY(course_id) REFERENCES courses (id),
    FOREIGN KEY(lesson_id) REFERENCES lessons (id)
);
```

#### 6. **achievements** - Достижения
```sql
CREATE TABLE achievements (
    id INTEGER PRIMARY KEY,
    title VARCHAR NOT NULL,
    description TEXT,
    badge_icon VARCHAR,
    points INTEGER,
    created_at DATETIME DEFAULT (CURRENT_TIMESTAMP)
);
```

#### 7. **user_achievements** - Достижения пользователей
```sql
CREATE TABLE user_achievements (
    id INTEGER PRIMARY KEY,
    user_id INTEGER,
    achievement_id INTEGER,
    earned_at DATETIME DEFAULT (CURRENT_TIMESTAMP),
    FOREIGN KEY(user_id) REFERENCES users (id),
    FOREIGN KEY(achievement_id) REFERENCES achievements (id)
);
```

### 🧠 Тестирование и оценка

#### 8. **skill_assessments** - Оценка навыков
```sql
CREATE TABLE skill_assessments (
    id INTEGER PRIMARY KEY,
    user_id INTEGER,
    skill_type VARCHAR,
    score FLOAT,
    completed_at DATETIME,
    FOREIGN KEY(user_id) REFERENCES users (id)
);
```

#### 9. **questions** - Вопросы тестов
```sql
CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    skill_type VARCHAR,
    question_text TEXT NOT NULL,
    question_type VARCHAR,
    difficulty INTEGER,
    created_at DATETIME DEFAULT (CURRENT_TIMESTAMP)
);
```

#### 10. **question_options** - Варианты ответов
```sql
CREATE TABLE question_options (
    id INTEGER PRIMARY KEY,
    question_id INTEGER,
    option_text TEXT NOT NULL,
    is_correct BOOLEAN,
    points INTEGER,
    FOREIGN KEY(question_id) REFERENCES questions (id)
);
```

### 💬 Социальные функции

#### 11. **discussions** - Обсуждения
```sql
CREATE TABLE discussions (
    id INTEGER PRIMARY KEY,
    course_id INTEGER,
    user_id INTEGER,
    title VARCHAR NOT NULL,
    content TEXT,
    created_at DATETIME DEFAULT (CURRENT_TIMESTAMP),
    FOREIGN KEY(course_id) REFERENCES courses (id),
    FOREIGN KEY(user_id) REFERENCES users (id)
);
```

#### 12. **discussion_replies** - Ответы в обсуждениях
```sql
CREATE TABLE discussion_replies (
    id INTEGER PRIMARY KEY,
    discussion_id INTEGER,
    user_id INTEGER,
    content TEXT NOT NULL,
    created_at DATETIME DEFAULT (CURRENT_TIMESTAMP),
    FOREIGN KEY(discussion_id) REFERENCES discussions (id),
    FOREIGN KEY(user_id) REFERENCES users (id)
);
```

### 🎮 Геймификация

#### 13. **user_game_profiles** - Игровые профили
```sql
CREATE TABLE user_game_profiles (
    id INTEGER PRIMARY KEY,
    user_id INTEGER,
    level INTEGER DEFAULT 1,
    experience_points INTEGER DEFAULT 0,
    total_points INTEGER DEFAULT 0,
    streak_days INTEGER DEFAULT 0,
    last_activity_date DATE,
    FOREIGN KEY(user_id) REFERENCES users (id)
);
```

#### 14. **leaderboards** - Рейтинги
```sql
CREATE TABLE leaderboards (
    id INTEGER PRIMARY KEY,
    user_id INTEGER,
    points INTEGER,
    rank_position INTEGER,
    period_type VARCHAR,
    period_date DATE,
    FOREIGN KEY(user_id) REFERENCES users (id)
);
```

### 📝 Задания и активности

#### 15. **daily_tasks** - Ежедневные задания
```sql
CREATE TABLE daily_tasks (
    id INTEGER PRIMARY KEY,
    title VARCHAR NOT NULL,
    description TEXT,
    points INTEGER,
    task_type VARCHAR,
    is_active BOOLEAN DEFAULT TRUE
);
```

#### 16. **user_daily_task_assignments** - Назначенные задания
```sql
CREATE TABLE user_daily_task_assignments (
    id INTEGER PRIMARY KEY,
    user_id INTEGER,
    task_id INTEGER,
    assigned_date DATE,
    completed_date DATE,
    is_completed BOOLEAN DEFAULT FALSE,
    FOREIGN KEY(user_id) REFERENCES users (id),
    FOREIGN KEY(task_id) REFERENCES daily_tasks (id)
);
```

## 🔗 Связи между таблицами

### Основные связи:
1. **users** ← **courses** (author_id)
2. **courses** ← **modules** (course_id)
3. **modules** ← **lessons** (module_id)
4. **users** ← **user_progress** (user_id)
5. **courses** ← **user_progress** (course_id)
6. **users** ← **skill_assessments** (user_id)
7. **users** ← **user_achievements** (user_id)
8. **achievements** ← **user_achievements** (achievement_id)

## 📊 Диаграмма архитектуры

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│    users    │◄───┤   courses   │◄───┤   modules   │
│     (11)    │    │     (7)     │    │             │
└─────────────┘    └─────────────┘    └─────────────┘
       │                  │                    │
       │                  │                    ▼
       │                  │            ┌─────────────┐
       │                  │            │   lessons   │
       │                  │            │    (24)     │
       │                  │            └─────────────┘
       │                  │
       ▼                  ▼
┌─────────────┐    ┌─────────────┐
│user_progress│    │course_enrollments│
│             │    │             │
└─────────────┘    └─────────────┘
       │
       ▼
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│achievements │◄───┤user_achievements│   │skill_assessments│
│             │    │             │    │             │
└─────────────┘    └─────────────┘    └─────────────┘
```

## 🛡️ Безопасность данных

1. **Хеширование паролей** - пароли хранятся в виде хешей
2. **Уникальные индексы** - email пользователей уникальны
3. **Внешние ключи** - обеспечивают целостность данных
4. **Временные метки** - отслеживание создания и обновления

## 🔍 Индексы для производительности

- `ix_users_email` - быстрый поиск по email
- `ix_users_id` - быстрый поиск по ID
- `ix_courses_title` - поиск курсов по названию
- `ix_lessons_id` - быстрый доступ к урокам

## 📈 Возможности расширения

1. **Масштабирование** - легко добавить новые таблицы
2. **Аналитика** - богатые данные для анализа прогресса
3. **Персонализация** - детальные профили пользователей
4. **Интеграции** - готовая структура для API

---

**Создано для защиты проекта MaroAI**  
**Дата:** 5 июня 2025 