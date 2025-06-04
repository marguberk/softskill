-- MaroAI Database Export from SQLite to PostgreSQL
-- Generated on 2025-06-05 04:18:02.634892

SET session_replication_role = replica;

-- Данные для таблицы users
DELETE FROM users;
INSERT INTO users (id, email, hashed_password, full_name, role, is_active, created_at, updated_at) VALUES (2, 'test@test.com', '$2b$12$QyXeBvgQqrj1Ek8jERGO0OWkGYnX.V.34bg2s68vvfsOqI/5UGTaC', 'Test User', 'student', 1, '2025-06-01 14:42:10', NULL);
INSERT INTO users (id, email, hashed_password, full_name, role, is_active, created_at, updated_at) VALUES (4, 'soma@gmail.com', '$2b$12$tCvv7qlD2uCtXBotpUtLFuKAOJSFQN84crA.y47jSsWaC196Cyp9m', 'Самат Беков', 'student', 1, '2025-06-01 19:47:18', NULL);
INSERT INTO users (id, email, hashed_password, full_name, role, is_active, created_at, updated_at) VALUES (5, 'test@example.com', '$2b$12$HMdkydSgNlDC.mOAS1dSnuTDkfKDhxpw1o67NVpZVJbt7XRBPaWm2', 'Тестовый Пользователь', 'student', 1, '2025-06-01 20:57:51', NULL);
INSERT INTO users (id, email, hashed_password, full_name, role, is_active, created_at, updated_at) VALUES (6, 'test@test.ru', '$2b$12$eLRtpY5RXBBZ6k4oouKl6OL63nyVAJEfjaq2vcKs.0WJBIBBq/gTC', 'Test User', 'student', 1, '2025-06-01 21:55:22', NULL);
INSERT INTO users (id, email, hashed_password, full_name, role, is_active, created_at, updated_at) VALUES (7, 'admin@test.ru', '$2b$12$u2.ICpnQkz4rTKn7fXvg8.5h8th6Xkit.mTnszs.OWNEE6k3BIrri', 'Администратор', 'student', 1, '2025-06-02 10:54:54', NULL);
INSERT INTO users (id, email, hashed_password, full_name, role, is_active, created_at, updated_at) VALUES (8, 'admin@maroai.com', '$2b$12$iAI4TVJJgOjuKi0D27sXYuEBbzZJGUn6tBm0GAtMa5UxK0l0gjli6', 'Администратор', 'admin', 1, '2025-06-02 14:28:52', NULL);
INSERT INTO users (id, email, hashed_password, full_name, role, is_active, created_at, updated_at) VALUES (9, 'marguberk@gmail.com', '$2b$12$XlGSvjE90j2rGeRfHgKQKOKFzHc2tVXAgcCMGr3TjZf.Vh05w50/e', 'Маргулан Бекмырзаев', 'student', 1, '2025-06-02 14:31:23', NULL);
INSERT INTO users (id, email, hashed_password, full_name, role, is_active, created_at, updated_at) VALUES (10, 'margusberk@gmail.com', '$2b$12$vQb1jcb7Rwj3K4uLJ0r45unipj8FuQFD.sUzkr9m03TfNZQEKfGgq', 'Маргулан Беркинбаев', 'student', 1, '2025-06-02 14:33:48', NULL);
INSERT INTO users (id, email, hashed_password, full_name, role, is_active, created_at, updated_at) VALUES (11, 'margulaneu@gmail.com', '$2b$12$pM0aDGh9LJPPsIPTi92dheOfi1/B/8rOWfbeyWR5R0fpt/83c4o1i', 'Эльмар Элизбаров', 'student', 1, '2025-06-02 22:57:58', NULL);
INSERT INTO users (id, email, hashed_password, full_name, role, is_active, created_at, updated_at) VALUES (12, 'marguzberk@gmail.com', '$2b$12$8XdLmZ2AAEaVfJmRex/Bzuz9hSov26a7ZuiGf7Jn0DglQgtPm8LKe', 'Маргулаг Беркинбаева', 'student', 1, '2025-06-02 23:30:53', NULL);
INSERT INTO users (id, email, hashed_password, full_name, role, is_active, created_at, updated_at) VALUES (13, 'somik@gmail.com', '$2b$12$p6P/uR6EM7LVw7xwSNVI2eEQxJ5nDOJbCsb/oxEn1riXBWCXVUk4a', 'Эльмар Элизбаров', 'student', 1, '2025-06-03 00:26:22', '2025-06-03 00:32:24');

-- Данные для таблицы soft_skills
DELETE FROM soft_skills;
INSERT INTO soft_skills (id, name, category, description, created_at) VALUES (1, 'Коммуникация', 'COMMUNICATION', 'Способность эффективно общаться с другими людьми', '2025-06-01 13:04:25');
INSERT INTO soft_skills (id, name, category, description, created_at) VALUES (2, 'Лидерство', 'LEADERSHIP', 'Умение вести за собой и мотивировать команду', '2025-06-01 13:04:25');
INSERT INTO soft_skills (id, name, category, description, created_at) VALUES (3, 'Командная работа', 'TEAMWORK', 'Способность работать в команде и сотрудничать', '2025-06-01 13:04:25');
INSERT INTO soft_skills (id, name, category, description, created_at) VALUES (4, 'Решение проблем', 'PROBLEM_SOLVING', 'Умение находить решения сложных задач', '2025-06-01 13:04:25');
INSERT INTO soft_skills (id, name, category, description, created_at) VALUES (5, 'Управление временем', 'TIME_MANAGEMENT', 'Способность эффективно планировать и распределять время', '2025-06-01 13:04:25');
INSERT INTO soft_skills (id, name, category, description, created_at) VALUES (6, 'Эмоциональный интеллект', 'EMOTIONAL_INTELLIGENCE', 'Понимание и управление эмоциями', '2025-06-01 13:04:25');

-- Данные для таблицы skill_questions
DELETE FROM skill_questions;
INSERT INTO skill_questions (id, skill_id, question_text, question_type, is_active, order_index, created_at) VALUES (1, 1, 'Как часто вы активно слушаете собеседника в разговоре?', 'multiple_choice', 1, 1, '2025-06-01 13:04:25');
INSERT INTO skill_questions (id, skill_id, question_text, question_type, is_active, order_index, created_at) VALUES (2, 1, 'Насколько легко вам объяснить сложную идею простыми словами?', 'multiple_choice', 1, 2, '2025-06-01 13:04:25');
INSERT INTO skill_questions (id, skill_id, question_text, question_type, is_active, order_index, created_at) VALUES (3, 1, 'Как вы обычно реагируете на критику?', 'multiple_choice', 1, 3, '2025-06-01 13:04:25');
INSERT INTO skill_questions (id, skill_id, question_text, question_type, is_active, order_index, created_at) VALUES (4, 2, 'Как часто другие обращаются к вам за советом или руководством?', 'multiple_choice', 1, 4, '2025-06-01 13:04:25');
INSERT INTO skill_questions (id, skill_id, question_text, question_type, is_active, order_index, created_at) VALUES (5, 2, 'Насколько легко вам мотивировать других людей?', 'multiple_choice', 1, 5, '2025-06-01 13:04:25');
INSERT INTO skill_questions (id, skill_id, question_text, question_type, is_active, order_index, created_at) VALUES (6, 3, 'Как вы относитесь к работе в команде?', 'multiple_choice', 1, 6, '2025-06-01 13:04:25');
INSERT INTO skill_questions (id, skill_id, question_text, question_type, is_active, order_index, created_at) VALUES (7, 3, 'Как часто вы помогаете коллегам с их задачами?', 'multiple_choice', 1, 7, '2025-06-01 13:04:25');
INSERT INTO skill_questions (id, skill_id, question_text, question_type, is_active, order_index, created_at) VALUES (8, 4, 'Как вы подходите к решению сложных проблем?', 'multiple_choice', 1, 8, '2025-06-01 13:04:25');
INSERT INTO skill_questions (id, skill_id, question_text, question_type, is_active, order_index, created_at) VALUES (9, 4, 'Насколько творчески вы подходите к решению задач?', 'multiple_choice', 1, 9, '2025-06-01 13:04:25');
INSERT INTO skill_questions (id, skill_id, question_text, question_type, is_active, order_index, created_at) VALUES (10, 5, 'Как часто вы сдаете работу в срок?', 'multiple_choice', 1, 10, '2025-06-01 13:04:25');
INSERT INTO skill_questions (id, skill_id, question_text, question_type, is_active, order_index, created_at) VALUES (11, 5, 'Насколько хорошо вы планируете свой день?', 'multiple_choice', 1, 11, '2025-06-01 13:04:25');
INSERT INTO skill_questions (id, skill_id, question_text, question_type, is_active, order_index, created_at) VALUES (12, 6, 'Насколько хорошо вы понимаете эмоции других людей?', 'multiple_choice', 1, 12, '2025-06-01 13:04:25');
INSERT INTO skill_questions (id, skill_id, question_text, question_type, is_active, order_index, created_at) VALUES (13, 6, 'Как вы управляете своими эмоциями в стрессовых ситуациях?', 'multiple_choice', 1, 13, '2025-06-01 13:04:25');

-- Данные для таблицы skill_assessments
DELETE FROM skill_assessments;
INSERT INTO skill_assessments (id, user_id, is_completed, started_at, completed_at, total_score) VALUES (1, 1, 1, '2025-06-01 13:05:59', '2025-06-01 13:06:11.585738', 60);
INSERT INTO skill_assessments (id, user_id, is_completed, started_at, completed_at, total_score) VALUES (2, 4, 1, '2025-06-01 19:47:27', '2025-06-01 19:50:00.334685', 79);
INSERT INTO skill_assessments (id, user_id, is_completed, started_at, completed_at, total_score) VALUES (3, 1, 1, '2025-06-02 10:57:14', '2025-06-02 11:12:32.618033', 60);
INSERT INTO skill_assessments (id, user_id, is_completed, started_at, completed_at, total_score) VALUES (4, 10, 1, '2025-06-02 14:35:39', '2025-06-02 14:35:51.645309', 59);
INSERT INTO skill_assessments (id, user_id, is_completed, started_at, completed_at, total_score) VALUES (5, 10, 1, '2025-06-02 16:27:02', '2025-06-03 04:18:47.082201', 56);
INSERT INTO skill_assessments (id, user_id, is_completed, started_at, completed_at, total_score) VALUES (6, 13, 1, '2025-06-03 00:26:31', '2025-06-03 00:26:49.342945', 40);

-- Данные для таблицы modules
DELETE FROM modules;
INSERT INTO modules (id, title, description, order, course_id, created_at, updated_at) VALUES (1, 'Основы эффективной коммуникации', 'Фундаментальные навыки общения в профессиональной среде', 1, 1, '2025-06-02 09:58:13', NULL);
INSERT INTO modules (id, title, description, order, course_id, created_at, updated_at) VALUES (2, 'Основы эффективной коммуникации', 'Фундаментальные навыки общения в профессиональной среде', 1, 1, '2025-06-02 09:58:39', NULL);

-- Данные для таблицы question_options
DELETE FROM question_options;
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (1, 1, 'Всегда внимательно слушаю', 5, 1);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (2, 1, 'Часто слушаю', 4, 2);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (3, 1, 'Иногда отвлекаюсь', 3, 3);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (4, 1, 'Редко слушаю внимательно', 2, 4);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (5, 1, 'Почти никогда', 1, 5);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (6, 2, 'Очень легко', 5, 1);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (7, 2, 'Довольно легко', 4, 2);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (8, 2, 'Средне', 3, 3);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (9, 2, 'Довольно сложно', 2, 4);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (10, 2, 'Очень сложно', 1, 5);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (11, 3, 'Принимаю конструктивно и использую для улучшения', 5, 1);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (12, 3, 'Выслушиваю и анализирую', 4, 2);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (13, 3, 'Иногда защищаюсь', 3, 3);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (14, 3, 'Часто воспринимаю негативно', 2, 4);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (15, 3, 'Всегда защищаюсь', 1, 5);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (16, 4, 'Очень часто', 5, 1);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (17, 4, 'Часто', 4, 2);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (18, 4, 'Иногда', 3, 3);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (19, 4, 'Редко', 2, 4);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (20, 4, 'Никогда', 1, 5);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (21, 5, 'Очень легко', 5, 1);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (22, 5, 'Довольно легко', 4, 2);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (23, 5, 'Средне', 3, 3);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (24, 5, 'Довольно сложно', 2, 4);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (25, 5, 'Очень сложно', 1, 5);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (26, 6, 'Очень нравится, работаю эффективно', 5, 1);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (27, 6, 'Нравится, хорошо сотрудничаю', 4, 2);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (28, 6, 'Нормально, могу работать', 3, 3);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (29, 6, 'Не очень нравится', 2, 4);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (30, 6, 'Предпочитаю работать один', 1, 5);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (31, 7, 'Всегда готов помочь', 5, 1);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (32, 7, 'Часто помогаю', 4, 2);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (33, 7, 'Иногда помогаю', 3, 3);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (34, 7, 'Редко помогаю', 2, 4);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (35, 7, 'Сосредоточен только на своих задачах', 1, 5);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (36, 8, 'Анализирую систематически и рассматриваю все варианты', 5, 1);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (37, 8, 'Обдумываю несколько подходов', 4, 2);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (38, 8, 'Пробую разные способы', 3, 3);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (39, 8, 'Использую первый пришедший в голову способ', 2, 4);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (40, 8, 'Откладываю или избегаю', 1, 5);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (41, 9, 'Всегда ищу нестандартные решения', 5, 1);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (42, 9, 'Часто проявляю креативность', 4, 2);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (43, 9, 'Иногда думаю творчески', 3, 3);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (44, 9, 'Редко использую креативный подход', 2, 4);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (45, 9, 'Всегда использую стандартные методы', 1, 5);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (46, 10, 'Всегда', 5, 1);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (47, 10, 'Почти всегда', 4, 2);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (48, 10, 'Обычно', 3, 3);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (49, 10, 'Иногда опаздываю', 2, 4);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (50, 10, 'Часто опаздываю', 1, 5);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (51, 11, 'Всегда составляю детальный план', 5, 1);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (52, 11, 'Обычно планирую основные задачи', 4, 2);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (53, 11, 'Иногда планирую', 3, 3);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (54, 11, 'Редко планирую заранее', 2, 4);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (55, 11, 'Никогда не планирую', 1, 5);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (56, 12, 'Очень хорошо чувствую настроение окружающих', 5, 1);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (57, 12, 'Довольно хорошо понимаю', 4, 2);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (58, 12, 'Иногда улавливаю', 3, 3);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (59, 12, 'Редко замечаю', 2, 4);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (60, 12, 'Почти не обращаю внимания', 1, 5);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (61, 13, 'Всегда сохраняю спокойствие', 5, 1);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (62, 13, 'Обычно контролирую эмоции', 4, 2);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (63, 13, 'Иногда теряю контроль', 3, 3);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (64, 13, 'Часто эмоционально реагирую', 2, 4);
INSERT INTO question_options (id, question_id, option_text, score_weight, order_index) VALUES (65, 13, 'Почти всегда теряю контроль', 1, 5);

-- Данные для таблицы user_skill_assessments
DELETE FROM user_skill_assessments;
INSERT INTO user_skill_assessments (id, assessment_id, skill_id, score, level, recommendations, created_at) VALUES (1, 1, 1, 87, 'EXPERT', 'Экспертный уровень коммуникация! Рассмотрите возможность наставничества.', '2025-06-01 13:06:11');
INSERT INTO user_skill_assessments (id, assessment_id, skill_id, score, level, recommendations, created_at) VALUES (2, 1, 2, 80, 'ADVANCED', 'Отличный уровень лидерство! Можете помогать другим и углублять знания.', '2025-06-01 13:06:11');
INSERT INTO user_skill_assessments (id, assessment_id, skill_id, score, level, recommendations, created_at) VALUES (3, 1, 3, 40, 'BEGINNER', 'Рекомендуем изучить основы командная работа. Начните с базовых курсов.', '2025-06-01 13:06:11');
INSERT INTO user_skill_assessments (id, assessment_id, skill_id, score, level, recommendations, created_at) VALUES (4, 1, 4, 50, 'INTERMEDIATE', 'У вас средний уровень решение проблем. Изучите продвинутые техники.', '2025-06-01 13:06:11');
INSERT INTO user_skill_assessments (id, assessment_id, skill_id, score, level, recommendations, created_at) VALUES (5, 1, 5, 60, 'INTERMEDIATE', 'У вас средний уровень управление временем. Изучите продвинутые техники.', '2025-06-01 13:06:11');
INSERT INTO user_skill_assessments (id, assessment_id, skill_id, score, level, recommendations, created_at) VALUES (6, 1, 6, 40, 'BEGINNER', 'Рекомендуем изучить основы эмоциональный интеллект. Начните с базовых курсов.', '2025-06-01 13:06:11');
INSERT INTO user_skill_assessments (id, assessment_id, skill_id, score, level, recommendations, created_at) VALUES (7, 2, 1, 73, 'ADVANCED', 'Отличный уровень коммуникация! Можете помогать другим и углублять знания.', '2025-06-01 19:50:00');
INSERT INTO user_skill_assessments (id, assessment_id, skill_id, score, level, recommendations, created_at) VALUES (8, 2, 2, 70, 'ADVANCED', 'Отличный уровень лидерство! Можете помогать другим и углублять знания.', '2025-06-01 19:50:00');
INSERT INTO user_skill_assessments (id, assessment_id, skill_id, score, level, recommendations, created_at) VALUES (9, 2, 3, 60, 'INTERMEDIATE', 'У вас средний уровень командная работа. Изучите продвинутые техники.', '2025-06-01 19:50:00');
INSERT INTO user_skill_assessments (id, assessment_id, skill_id, score, level, recommendations, created_at) VALUES (10, 2, 4, 80, 'ADVANCED', 'Отличный уровень решение проблем! Можете помогать другим и углублять знания.', '2025-06-01 19:50:00');
INSERT INTO user_skill_assessments (id, assessment_id, skill_id, score, level, recommendations, created_at) VALUES (11, 2, 5, 90, 'EXPERT', 'Экспертный уровень управление временем! Рассмотрите возможность наставничества.', '2025-06-01 19:50:00');
INSERT INTO user_skill_assessments (id, assessment_id, skill_id, score, level, recommendations, created_at) VALUES (12, 2, 6, 100, 'EXPERT', 'Экспертный уровень эмоциональный интеллект! Рассмотрите возможность наставничества.', '2025-06-01 19:50:00');
INSERT INTO user_skill_assessments (id, assessment_id, skill_id, score, level, recommendations, created_at) VALUES (13, 3, 1, 60, 'INTERMEDIATE', 'У вас средний уровень коммуникация. Изучите продвинутые техники.', '2025-06-02 11:12:32');
INSERT INTO user_skill_assessments (id, assessment_id, skill_id, score, level, recommendations, created_at) VALUES (14, 3, 2, 70, 'ADVANCED', 'Отличный уровень лидерство! Можете помогать другим и углублять знания.', '2025-06-02 11:12:32');
INSERT INTO user_skill_assessments (id, assessment_id, skill_id, score, level, recommendations, created_at) VALUES (15, 3, 3, 70, 'ADVANCED', 'Отличный уровень командная работа! Можете помогать другим и углублять знания.', '2025-06-02 11:12:32');
INSERT INTO user_skill_assessments (id, assessment_id, skill_id, score, level, recommendations, created_at) VALUES (16, 3, 4, 50, 'INTERMEDIATE', 'У вас средний уровень решение проблем. Изучите продвинутые техники.', '2025-06-02 11:12:32');
INSERT INTO user_skill_assessments (id, assessment_id, skill_id, score, level, recommendations, created_at) VALUES (17, 3, 5, 70, 'ADVANCED', 'Отличный уровень управление временем! Можете помогать другим и углублять знания.', '2025-06-02 11:12:32');
INSERT INTO user_skill_assessments (id, assessment_id, skill_id, score, level, recommendations, created_at) VALUES (18, 3, 6, 40, 'BEGINNER', 'Рекомендуем изучить основы эмоциональный интеллект. Начните с базовых курсов.', '2025-06-02 11:12:32');
INSERT INTO user_skill_assessments (id, assessment_id, skill_id, score, level, recommendations, created_at) VALUES (19, 4, 1, 53, 'INTERMEDIATE', 'У вас средний уровень коммуникация. Изучите продвинутые техники.', '2025-06-02 14:35:51');
INSERT INTO user_skill_assessments (id, assessment_id, skill_id, score, level, recommendations, created_at) VALUES (20, 4, 2, 70, 'ADVANCED', 'Отличный уровень лидерство! Можете помогать другим и углублять знания.', '2025-06-02 14:35:51');
INSERT INTO user_skill_assessments (id, assessment_id, skill_id, score, level, recommendations, created_at) VALUES (21, 4, 3, 70, 'ADVANCED', 'Отличный уровень командная работа! Можете помогать другим и углублять знания.', '2025-06-02 14:35:51');
INSERT INTO user_skill_assessments (id, assessment_id, skill_id, score, level, recommendations, created_at) VALUES (22, 4, 4, 60, 'INTERMEDIATE', 'У вас средний уровень решение проблем. Изучите продвинутые техники.', '2025-06-02 14:35:51');
INSERT INTO user_skill_assessments (id, assessment_id, skill_id, score, level, recommendations, created_at) VALUES (23, 4, 5, 80, 'ADVANCED', 'Отличный уровень управление временем! Можете помогать другим и углублять знания.', '2025-06-02 14:35:51');
INSERT INTO user_skill_assessments (id, assessment_id, skill_id, score, level, recommendations, created_at) VALUES (24, 4, 6, 60, 'INTERMEDIATE', 'У вас средний уровень эмоциональный интеллект. Изучите продвинутые техники.', '2025-06-02 14:35:51');
INSERT INTO user_skill_assessments (id, assessment_id, skill_id, score, level, recommendations, created_at) VALUES (25, 6, 1, 67, 'INTERMEDIATE', 'У вас средний уровень коммуникация. Изучите продвинутые техники.', '2025-06-03 00:26:49');
INSERT INTO user_skill_assessments (id, assessment_id, skill_id, score, level, recommendations, created_at) VALUES (26, 6, 2, 40, 'BEGINNER', 'Рекомендуем изучить основы лидерство. Начните с базовых курсов.', '2025-06-03 00:26:49');
INSERT INTO user_skill_assessments (id, assessment_id, skill_id, score, level, recommendations, created_at) VALUES (27, 6, 3, 30, 'BEGINNER', 'Рекомендуем изучить основы командная работа. Начните с базовых курсов.', '2025-06-03 00:26:49');
INSERT INTO user_skill_assessments (id, assessment_id, skill_id, score, level, recommendations, created_at) VALUES (28, 6, 4, 40, 'BEGINNER', 'Рекомендуем изучить основы решение проблем. Начните с базовых курсов.', '2025-06-03 00:26:49');
INSERT INTO user_skill_assessments (id, assessment_id, skill_id, score, level, recommendations, created_at) VALUES (29, 6, 5, 40, 'BEGINNER', 'Рекомендуем изучить основы управление временем. Начните с базовых курсов.', '2025-06-03 00:26:49');
INSERT INTO user_skill_assessments (id, assessment_id, skill_id, score, level, recommendations, created_at) VALUES (30, 6, 6, 40, 'BEGINNER', 'Рекомендуем изучить основы эмоциональный интеллект. Начните с базовых курсов.', '2025-06-03 00:26:49');
INSERT INTO user_skill_assessments (id, assessment_id, skill_id, score, level, recommendations, created_at) VALUES (31, 5, 1, 87, 'EXPERT', 'Экспертный уровень коммуникация! Рассмотрите возможность наставничества.', '2025-06-03 04:18:47');
INSERT INTO user_skill_assessments (id, assessment_id, skill_id, score, level, recommendations, created_at) VALUES (32, 5, 2, 50, 'INTERMEDIATE', 'У вас средний уровень лидерство. Изучите продвинутые техники.', '2025-06-03 04:18:47');
INSERT INTO user_skill_assessments (id, assessment_id, skill_id, score, level, recommendations, created_at) VALUES (33, 5, 3, 40, 'BEGINNER', 'Рекомендуем изучить основы командная работа. Начните с базовых курсов.', '2025-06-03 04:18:47');
INSERT INTO user_skill_assessments (id, assessment_id, skill_id, score, level, recommendations, created_at) VALUES (34, 5, 4, 70, 'ADVANCED', 'Отличный уровень решение проблем! Можете помогать другим и углублять знания.', '2025-06-03 04:18:47');
INSERT INTO user_skill_assessments (id, assessment_id, skill_id, score, level, recommendations, created_at) VALUES (35, 5, 5, 70, 'ADVANCED', 'Отличный уровень управление временем! Можете помогать другим и углублять знания.', '2025-06-03 04:18:47');
INSERT INTO user_skill_assessments (id, assessment_id, skill_id, score, level, recommendations, created_at) VALUES (36, 5, 6, 20, 'BEGINNER', 'Рекомендуем изучить основы эмоциональный интеллект. Начните с базовых курсов.', '2025-06-03 04:18:47');

-- Данные для таблицы lessons
DELETE FROM lessons;
INSERT INTO lessons (id, title, content, order, module_id, created_at, updated_at) VALUES (1, 'Введение в эффективную коммуникацию', '# Введение в эффективную коммуникацию


# Введение в эффективную коммуникацию

## Что такое коммуникация?

Коммуникация — это процесс передачи информации между людьми с помощью слов, жестов, мимики и других способов.

### Основные элементы коммуникации:
- **Отправитель** — тот, кто передает сообщение
- **Сообщение** — информация, которую передают
- **Получатель** — тот, кто принимает сообщение
- **Канал связи** — способ передачи (устная речь, письмо, жесты)
- **Обратная связь** — реакция получателя на сообщение

## Типы коммуникации

### 1. Вербальная коммуникация
Общение с помощью слов (устно или письменно)

### 2. Невербальная коммуникация
- Мимика и жесты
- Интонация голоса
- Поза тела
- Зрительный контакт

### 3. Письменная коммуникация
Электронная почта, отчеты, презентации
        

## 📹 Видео к уроку

**Вводное видео о культуре речи и деловом общении. Основы профессиональной коммуникации на русском языке.**

🔗 **Ссылка на видео:** https://www.youtube.com/watch?v=U0PC37rubQ0

### Что вы узнаете из видео:
- Практические техники и методы
- Реальные примеры применения
- Экспертные советы и рекомендации
- Дополнительные инсайты по теме урока

*Рекомендуется просмотреть видео после изучения теоретического материала для закрепления знаний.*


## 📹 Видео урок

**Ссылка:** https://www.youtube.com/watch?v=U0PC37rubQ0
**ID видео:** U0PC37rubQ0
**Тип контента:** VIDEO', 1, 1, '2025-06-02 09:58:13', NULL);
INSERT INTO lessons (id, title, content, order, module_id, created_at, updated_at) VALUES (2, 'Активное слушание и эмпатия', '# Активное слушание и эмпатия


# Активное слушание и эмпатия

## Что такое активное слушание?

Активное слушание — это техника общения, при которой слушатель полностью сосредоточен на собеседнике.

### Принципы активного слушания:
1. **Полное внимание** — убираем отвлекающие факторы
2. **Не перебиваем** — даем возможность высказаться
3. **Задаем уточняющие вопросы**
4. **Перефразируем** сказанное для проверки понимания
5. **Показываем заинтересованность** кивками и короткими репликами

## Техники активного слушания

### 1. Перефразирование
"Если я правильно понял, вы имеете в виду..."

### 2. Резюмирование
"Итак, основные моменты..."

### 3. Эмоциональная поддержка
"Я понимаю, что это сложная ситуация"

## Развитие эмпатии

Эмпатия — способность понимать и разделять чувства другого человека.

### Как развить эмпатию:
- Ставьте себя на место собеседника
- Обращайте внимание на эмоции
- Не судите поспешно
- Задавайте открытые вопросы
        

## 📹 Видео к уроку

**Краткий, но содержательный урок о техниках активного слушания за 6 минут. Практические советы для улучшения навыков общения.**

🔗 **Ссылка на видео:** https://www.youtube.com/watch?v=SB5MMQcJ1YA

### Что вы узнаете из видео:
- Практические техники и методы
- Реальные примеры применения
- Экспертные советы и рекомендации
- Дополнительные инсайты по теме урока

*Рекомендуется просмотреть видео после изучения теоретического материала для закрепления знаний.*


## 📹 Видео урок

**Ссылка:** https://www.youtube.com/watch?v=SB5MMQcJ1YA
**ID видео:** SB5MMQcJ1YA
**Тип контента:** VIDEO', 2, 1, '2025-06-02 09:58:13', NULL);
INSERT INTO lessons (id, title, content, order, module_id, created_at, updated_at) VALUES (3, 'Невербальная коммуникация и язык тела', '# Невербальная коммуникация и язык тела


# Невербальная коммуникация и язык тела

## Важность невербального общения

По исследованиям, 55% информации передается через язык тела, 38% через интонацию и только 7% через слова.

### Основные элементы невербальной коммуникации:

#### 1. Мимика лица
- Улыбка создает доверие
- Нахмуренные брови — признак недовольства
- Поднятые брови — удивление или интерес

#### 2. Жесты рук
- Открытые ладони — честность
- Скрещенные руки — защитная позиция
- Указательный жест может восприниматься агрессивно

#### 3. Поза тела
- Прямая осанка — уверенность
- Наклон вперед — заинтересованность
- Отклонение назад — дистанцирование

#### 4. Зрительный контакт
- Поддержание контакта — внимание и уважение
- Избегание взгляда — неуверенность или обман
- Слишком пристальный взгляд — агрессия

## Культурные различия

Важно помнить, что жесты могут иметь разное значение в разных культурах.
        

## 📹 Видео к уроку

**Обучающее видео о невербальном общении и языке тела. Изучите секреты успешной коммуникации без слов.**

🔗 **Ссылка на видео:** https://www.youtube.com/watch?v=rYLfcUFZ8kQ

### Что вы узнаете из видео:
- Практические техники и методы
- Реальные примеры применения
- Экспертные советы и рекомендации
- Дополнительные инсайты по теме урока

*Рекомендуется просмотреть видео после изучения теоретического материала для закрепления знаний.*


## 📹 Видео урок

**Ссылка:** https://www.youtube.com/watch?v=rYLfcUFZ8kQ
**ID видео:** rYLfcUFZ8kQ
**Тип контента:** VIDEO', 3, 1, '2025-06-02 09:58:13', NULL);
INSERT INTO lessons (id, title, content, order, module_id, created_at, updated_at) VALUES (4, 'Управление конфликтами в общении', '# Управление конфликтами в общении


# Управление конфликтами в общении

## Типы конфликтов

### 1. Конфликт интересов
Когда стороны хотят разного результата

### 2. Конфликт ценностей
Разные взгляды на то, что правильно

### 3. Конфликт восприятия
Разная интерпретация одних и тех же фактов

## Стратегии разрешения конфликтов

### 1. Сотрудничество
Поиск решения, выгодного для всех сторон

### 2. Компромисс
Взаимные уступки

### 3. Приспособление
Уступка более важной стороне

### 4. Избегание
Временное откладывание решения

### 5. Соперничество
Настаивание на своем (крайняя мера)

## Техники деэскалации

1. **Слушайте активно** — дайте выговориться
2. **Признавайте эмоции** — "Я вижу, вы расстроены"
3. **Ищите общие интересы** — что объединяет
4. **Фокусируйтесь на проблеме**, а не на личности
5. **Предлагайте варианты** решения

## Модель WIN-WIN

Стремитесь к решениям, где выигрывают все стороны.
        

## 📹 Видео к уроку

**Практический урок по управлению конфликтами. Научитесь эффективно разрешать споры и выходить из сложных ситуаций.**

🔗 **Ссылка на видео:** https://www.youtube.com/watch?v=Qug4IStz4_Y

### Что вы узнаете из видео:
- Практические техники и методы
- Реальные примеры применения
- Экспертные советы и рекомендации
- Дополнительные инсайты по теме урока

*Рекомендуется просмотреть видео после изучения теоретического материала для закрепления знаний.*


## 📹 Видео урок

**Ссылка:** https://www.youtube.com/watch?v=Qug4IStz4_Y
**ID видео:** Qug4IStz4_Y
**Тип контента:** VIDEO', 4, 1, '2025-06-02 09:58:13', NULL);
INSERT INTO lessons (id, title, content, order, module_id, created_at, updated_at) VALUES (5, 'Эффективная обратная связь', '# Эффективная обратная связь


# Эффективная обратная связь

## Что такое обратная связь?

Обратная связь — это информация о том, как ваши действия влияют на других и на результат работы.

## Принципы конструктивной обратной связи

### При ДАЧИ обратной связи:

#### 1. Модель SBI (Situation-Behavior-Impact)
- **Ситуация**: Опишите контекст
- **Поведение**: Что конкретно наблюдали
- **Влияние**: Как это повлияло на результат

#### 2. Будьте конкретными
❌ "Ты плохо работаешь"
✅ "В презентации не хватало данных о продажах"

#### 3. Фокус на поведении, не на личности
❌ "Ты безответственный"
✅ "Отчет был сдан с опозданием"

#### 4. Предлагайте решения
"В следующий раз можно добавить график с результатами"

### При ПОЛУЧЕНИИ обратной связи:

1. **Слушайте открыто** — не защищайтесь сразу
2. **Задавайте уточняющие вопросы**
3. **Благодарите** за информацию
4. **Планируйте улучшения**

## Модель GROW для развивающей обратной связи

- **Goal** — Какой цели хотим достичь?
- **Reality** — Что происходит сейчас?
- **Options** — Какие есть варианты?
- **Will** — Что будем делать?
        

## 📹 Видео к уроку

**Урок об эмоциональном интеллекте в коммуникации. Изучите основы управления эмоциями в процессе общения.**

🔗 **Ссылка на видео:** https://www.youtube.com/watch?v=fdUR9qYl7iU

### Что вы узнаете из видео:
- Практические техники и методы
- Реальные примеры применения
- Экспертные советы и рекомендации
- Дополнительные инсайты по теме урока

*Рекомендуется просмотреть видео после изучения теоретического материала для закрепления знаний.*


## 📹 Видео урок

**Ссылка:** https://www.youtube.com/watch?v=fdUR9qYl7iU
**ID видео:** fdUR9qYl7iU
**Тип контента:** VIDEO', 5, 1, '2025-06-02 09:58:13', NULL);
INSERT INTO lessons (id, title, content, order, module_id, created_at, updated_at) VALUES (6, 'Презентационные навыки', '# Презентационные навыки


# Презентационные навыки

## Структура эффективной презентации

### 1. Вступление (10-15%)
- Привлечение внимания
- Представление темы
- Анонс структуры

### 2. Основная часть (70-80%)
- 3-5 ключевых пунктов
- Аргументы и примеры
- Визуальная поддержка

### 3. Заключение (10-15%)
- Резюме ключевых моментов
- Призыв к действию
- Ответы на вопросы

## Правило 10/20/30

- **10 слайдов** максимум
- **20 минут** презентация
- **30 пунктов** шрифт минимум

## Работа с аудиторией

### До презентации:
- Изучите аудиторию
- Подготовьте ответы на возможные вопросы
- Проверьте технику

### Во время презентации:
- Поддерживайте зрительный контакт
- Используйте паузы
- Вовлекайте аудиторию вопросами
- Следите за реакцией

### Управление волнением:
1. Глубокое дыхание
2. Позитивная визуализация
3. Подготовка и репетиции
4. Фокус на сообщении, а не на себе

## Визуальные материалы

- Один слайд — одна идея
- Больше изображений, меньше текста
- Контрастные цвета
- Читаемые шрифты
        

## 📹 Видео к уроку

**Обучающее видео о навыках публичных выступлений. Научитесь уверенно выступать перед аудиторией.**

🔗 **Ссылка на видео:** https://www.youtube.com/watch?v=2HT59cO72xg

### Что вы узнаете из видео:
- Практические техники и методы
- Реальные примеры применения
- Экспертные советы и рекомендации
- Дополнительные инсайты по теме урока

*Рекомендуется просмотреть видео после изучения теоретического материала для закрепления знаний.*


## 📹 Видео урок

**Ссылка:** https://www.youtube.com/watch?v=2HT59cO72xg
**ID видео:** 2HT59cO72xg
**Тип контента:** VIDEO', 6, 1, '2025-06-02 09:58:13', NULL);
INSERT INTO lessons (id, title, content, order, module_id, created_at, updated_at) VALUES (7, 'Цифровая коммуникация и этикет', '# Цифровая коммуникация и этикет


# Цифровая коммуникация и этикет

## Email-этикет

### Структура эффективного письма:

#### 1. Тема письма
- Конкретная и информативная
- ✅ "Вопрос по проекту X — нужно решение до пятницы"
- ❌ "Важно!" или "Вопрос"

#### 2. Приветствие
- Формальное: "Уважаемый/ая [Имя]"
- Полуформальное: "Здравствуйте, [Имя]"
- Неформальное: "Привет, [Имя]"

#### 3. Основная часть
- Сначала контекст, потом детали
- Короткие абзацы
- Маркированные списки для перечислений

#### 4. Призыв к действию
- Четко указывайте, что нужно сделать
- Дедлайны и приоритеты

#### 5. Подпись
- Имя, должность, контакты

## Мессенджеры на работе

### Принципы:
- Уважайте рабочее время
- Используйте статусы доступности
- Групповые чаты — для общих вопросов
- Личные сообщения — для приватных тем

### Emoji и стикеры:
- Умеренно в рабочем контексте
- Помогают передать эмоции
- Не заменяют слова полностью

## Видеоконференции

### Технические аспекты:
- Проверьте связь заранее
- Хорошее освещение лица
- Нейтральный фон
- Качественный звук

### Этикет:
- Приходите вовремя
- Выключайте микрофон, когда не говорите
- Смотрите в камеру, а не на экран
- Одевайтесь профессионально
        

## 📹 Видео к уроку

**Урок о цифровом этикете и правилах вежливого общения онлайн. Изучите современные нормы сетевого этикета.**

🔗 **Ссылка на видео:** https://www.youtube.com/watch?v=bs6IALQmxYs

### Что вы узнаете из видео:
- Практические техники и методы
- Реальные примеры применения
- Экспертные советы и рекомендации
- Дополнительные инсайты по теме урока

*Рекомендуется просмотреть видео после изучения теоретического материала для закрепления знаний.*


## 📹 Видео урок

**Ссылка:** https://www.youtube.com/watch?v=bs6IALQmxYs
**ID видео:** bs6IALQmxYs
**Тип контента:** VIDEO', 7, 1, '2025-06-02 09:58:13', NULL);
INSERT INTO lessons (id, title, content, order, module_id, created_at, updated_at) VALUES (8, 'Межкультурная коммуникация', '# Межкультурная коммуникация


# Межкультурная коммуникация

## Культурные измерения Хофстеде

### 1. Дистанция власти
- **Высокая**: четкая иерархия (Россия, Корея)
- **Низкая**: равенство в общении (Дания, Австралия)

### 2. Индивидуализм vs Коллективизм
- **Индивидуалистские**: США, Германия
- **Коллективистские**: Япония, Китай

### 3. Избегание неопределенности
- **Высокое**: четкие правила (Германия)
- **Низкое**: гибкость (США, Индия)

## Стили коммуникации

### Прямой vs Косвенный
- **Прямой**: говорят что думают (Германия, Нидерланды)
- **Косвенный**: намеки и контекст (Япония, Корея)

### Высококонтекстный vs Низкоконтекстный
- **Высокий контекст**: важна ситуация (Япония, Арабские страны)
- **Низкий контекст**: важны слова (Германия, США)

## Практические советы

### При работе с разными культурами:

1. **Изучите основы** культуры коллег
2. **Будьте терпеливы** к различиям
3. **Не обобщайте** — каждый человек уникален
4. **Уточняйте понимание** чаще
5. **Адаптируйте стиль** общения

### Невербальные различия:
- Зрительный контакт
- Личное пространство
- Жесты и их значения
- Отношение к времени

## Построение инклюзивной среды

- Избегайте культурных стереотипов
- Создавайте возможности для всех высказаться
- Учитывайте временные зоны при планировании
- Используйте простой и понятный язык
        

## 📹 Видео к уроку

**Образовательная программа о русском языке в культуре речи и деловом общении с представителями разных культур.**

🔗 **Ссылка на видео:** https://www.youtube.com/watch?v=YOkgQbJnB5A

### Что вы узнаете из видео:
- Практические техники и методы
- Реальные примеры применения
- Экспертные советы и рекомендации
- Дополнительные инсайты по теме урока

*Рекомендуется просмотреть видео после изучения теоретического материала для закрепления знаний.*


## 📹 Видео урок

**Ссылка:** https://www.youtube.com/watch?v=YOkgQbJnB5A
**ID видео:** YOkgQbJnB5A
**Тип контента:** VIDEO', 8, 1, '2025-06-02 09:58:13', NULL);
INSERT INTO lessons (id, title, content, order, module_id, created_at, updated_at) VALUES (9, 'Эмоциональный интеллект в коммуникации', '# Эмоциональный интеллект в коммуникации


# Эмоциональный интеллект в коммуникации

## Что такое эмоциональный интеллект?

EQ (Emotional Quotient) — способность понимать и управлять своими и чужими эмоциями.

## Четыре компонента EQ

### 1. Самосознание
- Понимание своих эмоций
- Знание своих сильных и слабых сторон
- Реалистичная самооценка

### 2. Саморегуляция
- Управление импульсами
- Адаптивность к изменениям
- Инициативность

### 3. Социальное понимание
- Эмпатия к другим
- Понимание организационной динамики
- Ориентация на сервис

### 4. Управление отношениями
- Влияние на других
- Лидерство
- Управление конфликтами
- Командная работа

## Эмоции в рабочей среде

### Позитивные эмоции:
- Энтузиазм — мотивирует команду
- Благодарность — укрепляет отношения
- Оптимизм — помогает в трудностях

### Сложные эмоции:
- Стресс — может снижать эффективность
- Фрустрация — требует конструктивного выхода
- Тревога — нужны техники успокоения

## Техники управления эмоциями

### 1. Техника STOP
- **S**top — остановитесь
- **T**ake a breath — сделайте вдох
- **O**bserve — понаблюдайте за эмоциями
- **P**roceed — действуйте осознанно

### 2. Переформулирование
Измените внутренний диалог:
❌ "Это катастрофа!"
✅ "Это вызов, который можно решить"

### 3. Техника 5-4-3-2-1
При стрессе назовите:
- 5 вещей, которые видите
- 4 вещи, которые слышите  
- 3 вещи, которые можете потрогать
- 2 запаха
- 1 вкус
        

## 📹 Видео к уроку

**Профессиональная лекция об основах эмоционального интеллекта. Развитие навыков управления эмоциями в общении.**

🔗 **Ссылка на видео:** https://www.youtube.com/watch?v=JJ6Pa83oW7w

### Что вы узнаете из видео:
- Практические техники и методы
- Реальные примеры применения
- Экспертные советы и рекомендации
- Дополнительные инсайты по теме урока

*Рекомендуется просмотреть видео после изучения теоретического материала для закрепления знаний.*


## 📹 Видео урок

**Ссылка:** https://www.youtube.com/watch?v=JJ6Pa83oW7w
**ID видео:** JJ6Pa83oW7w
**Тип контента:** VIDEO', 9, 1, '2025-06-02 09:58:13', NULL);
INSERT INTO lessons (id, title, content, order, module_id, created_at, updated_at) VALUES (10, 'Практикум: Интеграция коммуникативных навыков', '# Практикум: Интеграция коммуникативных навыков


# Практикум: Интеграция коммуникативных навыков

## Цель практикума

Объединить все изученные навыки коммуникации и применить их в комплексных сценариях.

## Ключевые навыки для интеграции

### 1. Активное слушание
- Техники SBI (Situation-Behavior-Impact)
- Эмпатическое понимание
- Парафразирование и резюмирование

### 2. Невербальная коммуникация
- Язык тела и жесты
- Зрительный контакт
- Управление пространством

### 3. Управление эмоциями
- Техника STOP
- Эмоциональная регуляция
- Конструктивное выражение чувств

### 4. Конфликт-менеджмент
- Деэскалация напряжения
- Поиск win-win решений
- Медиация между сторонами

## Практические сценарии

### Сценарий 1: Сложная презентация
**Ситуация**: Презентация проекта перед скептически настроенной аудиторией

**Применяемые навыки**:
- Структурирование информации
- Работа с возражениями
- Невербальная уверенность
- Адаптация к аудитории

### Сценарий 2: Командный конфликт
**Ситуация**: Конфликт между двумя коллегами влияет на работу команды

**Применяемые навыки**:
- Активное слушание всех сторон
- Эмоциональная регуляция
- Медиация и поиск компромиссов
- Обратная связь

### Сценарий 3: Межкультурная коммуникация
**Ситуация**: Работа с международной командой с разными культурными особенностями

**Применяемые навыки**:
- Культурная чувствительность
- Адаптация стиля общения
- Цифровая коммуникация
- Инклюзивность

## Модель GROW в действии

Для каждого сценария используйте модель GROW:

- **Goal** — Какой результат хотим достичь?
- **Reality** — Что происходит сейчас?
- **Options** — Какие у нас есть варианты?
- **Will** — Что конкретно будем делать?

## Самооценка и планирование развития

### Чек-лист коммуникативных навыков:

1. **Слушание** (1-10): ___
2. **Говорение** (1-10): ___
3. **Невербальное общение** (1-10): ___
4. **Управление конфликтами** (1-10): ___
5. **Обратная связь** (1-10): ___
6. **Презентации** (1-10): ___
7. **Цифровая коммуникация** (1-10): ___
8. **Межкультурное общение** (1-10): ___
9. **Эмоциональный интеллект** (1-10): ___

### План развития на 3 месяца:

**Цель 1**: (выберите 2-3 навыка для фокуса)
**Действия**: (конкретные шаги)
**Метрики**: (как измерить прогресс)

## Заключение

Эффективная коммуникация — это навык, который развивается постоянно. Продолжайте практиковаться и получать обратную связь!
    

## 📹 Видео к уроку

**Урок о различных видах публичных выступлений. Практическое применение всех изученных коммуникативных техник.**

🔗 **Ссылка на видео:** https://www.youtube.com/watch?v=hcAm5lyQVyk

### Что вы узнаете из видео:
- Практические техники и методы
- Реальные примеры применения
- Экспертные советы и рекомендации
- Дополнительные инсайты по теме урока

*Рекомендуется просмотреть видео после изучения теоретического материала для закрепления знаний.*


## 📹 Видео урок

**Ссылка:** https://www.youtube.com/watch?v=hcAm5lyQVyk
**ID видео:** hcAm5lyQVyk
**Тип контента:** VIDEO', 10, 1, '2025-06-02 09:58:13', NULL);
INSERT INTO lessons (id, title, content, order, module_id, created_at, updated_at) VALUES (11, 'Эффективная коммуникация', '# Эффективная коммуникация

## Введение

Эффективная коммуникация является основой успешной работы в команде.

### Ключевые принципы

1. **Активное слушание** - внимательно слушайте собеседника
2. **Ясность изложения** - выражайте мысли четко и понятно
3. **Эмпатия** - понимайте точку зрения других

### Практические советы

- Используйте "Я-высказывания" вместо обвинений
- Задавайте открытые вопросы
- Подтверждайте понимание перефразированием

## Заключение

Применяя эти принципы, вы значительно улучшите качество коммуникации в команде.

## 📹 Видео к уроку

**Профессиональный урок об основах деловой коммуникации. Изучите ключевые принципы эффективного общения в бизнес-среде.**

🔗 **Ссылка на видео:** https://www.youtube.com/watch?v=Nu9uvs2UeaM

### Что вы узнаете из видео:
- Практические техники и методы
- Реальные примеры применения
- Экспертные советы и рекомендации
- Дополнительные инсайты по теме урока

*Рекомендуется просмотреть видео после изучения теоретического материала для закрепления знаний.*


## 📹 Видео урок

**Ссылка:** https://www.youtube.com/watch?v=Nu9uvs2UeaM
**ID видео:** Nu9uvs2UeaM
**Тип контента:** VIDEO', 11, 1, '2025-06-02 09:58:13', NULL);
INSERT INTO lessons (id, title, content, order, module_id, created_at, updated_at) VALUES (12, 'Техники активного слушания', '# Техники активного слушания

# Техники активного слушания

## Основы активного слушания

Активное слушание — это навык полного погружения в процесс восприятия информации от собеседника с целью максимального понимания как содержания, так и эмоций.

### Уровни слушания

1. **Внутреннее слушание**
   - Фокус на собственных мыслях
   - Подготовка ответа во время речи собеседника
   - Оценочные суждения

2. **Фокусированное слушание**
   - Концентрация на словах собеседника
   - Понимание содержания
   - Минимальные внутренние отвлечения

3. **Глобальное слушание**
   - Восприятие всех сигналов
   - Внимание к эмоциям и энергии
   - Интуитивное понимание

### Техники активного слушания

**Парафраз (Перефразирование):**
- Повторение услышанного своими словами
- Проверка понимания
- Пример: "Если я правильно понял, вы говорите о..."

**Отражение чувств:**
- Озвучивание эмоционального состояния
- Демонстрация эмпатии
- Пример: "Я вижу, что вы расстроены этой ситуацией"

**Уточнение:**
- Открытые вопросы для получения деталей
- Избегание предположений
- Пример: "Можете ли вы рассказать больше о..."

**Резюмирование:**
- Обобщение ключевых моментов
- Структурирование информации
- Пример: "Итак, основные моменты..."

### Невербальные сигналы

**Поза и жесты:**
- Открытая поза тела
- Наклон к собеседнику
- Зрительный контакт
- Кивки головой

**Мимика:**
- Соответствующее выражение лица
- Отражение эмоций собеседника
- Искренность в выражениях

**Голосовые сигналы:**
- Тон голоса
- Скорость речи
- Паузы
- Интонации

### Препятствия для активного слушания

**Внутренние барьеры:**
- Предварительные суждения
- Эмоциональные реакции
- Отвлечение на собственные мысли
- Подготовка возражений

**Внешние факторы:**
- Шум и отвлекающие факторы
- Временные ограничения
- Неподходящая обстановка
- Технические помехи

### Эмпатическое слушание

**Принципы эмпатии:**
- Понимание без оценки
- Принятие чувств собеседника
- Сопереживание
- Поддержка

**Техники развития эмпатии:**
- Постановка себя на место другого
- Внимание к эмоциональным сигналам
- Отложение собственных суждений
- Создание безопасного пространства

### Активное слушание в конфликтах

**Деэскалация:**
- Спокойный тон голоса
- Признание чувств сторон
- Поиск общих интересов
- Фокус на фактах

**Медиация:**
- Нейтральная позиция
- Равное время для каждой стороны
- Структурирование диалога
- Поиск решений

### Практические упражнения

**Упражнение "Зеркало":**
- Повторение последних слов собеседника
- Отражение тона и эмоций
- Проверка понимания

**Упражнение "Три уровня":**
- Слушание фактов (что говорится)
- Слушание эмоций (как говорится)
- Слушание потребностей (зачем говорится)

### Развитие навыков

**Ежедневная практика:**
- Сосредоточенное слушание в каждом разговоре
- Отключение электронных устройств
- Задавание открытых вопросов
- Благодарность за откровенность


## 📹 Видео к уроку

**Практический урок о техниках активного слушания. Научитесь лучше понимать собеседника и выстраивать доверительные отношения.**

🔗 **Ссылка на видео:** https://www.youtube.com/watch?v=QWvijbXrCCQ

### Что вы узнаете из видео:
- Практические техники и методы
- Реальные примеры применения
- Экспертные советы и рекомендации
- Дополнительные инсайты по теме урока

*Рекомендуется просмотреть видео после изучения теоретического материала для закрепления знаний.*


## 📹 Видео урок

**Ссылка:** https://www.youtube.com/watch?v=QWvijbXrCCQ
**ID видео:** QWvijbXrCCQ
**Тип контента:** VIDEO', 12, 1, '2025-06-02 09:58:13', NULL);
INSERT INTO lessons (id, title, content, order, module_id, created_at, updated_at) VALUES (13, 'Введение в эффективную коммуникацию', '# Введение в эффективную коммуникацию


# Введение в эффективную коммуникацию

## Что такое коммуникация?

Коммуникация — это процесс передачи информации между людьми с помощью слов, жестов, мимики и других способов.

### Основные элементы коммуникации:
- **Отправитель** — тот, кто передает сообщение
- **Сообщение** — информация, которую передают
- **Получатель** — тот, кто принимает сообщение
- **Канал связи** — способ передачи (устная речь, письмо, жесты)
- **Обратная связь** — реакция получателя на сообщение

## Типы коммуникации

### 1. Вербальная коммуникация
Общение с помощью слов (устно или письменно)

### 2. Невербальная коммуникация
- Мимика и жесты
- Интонация голоса
- Поза тела
- Зрительный контакт

### 3. Письменная коммуникация
Электронная почта, отчеты, презентации
        

## 📹 Видео к уроку

**Вводное видео о культуре речи и деловом общении. Основы профессиональной коммуникации на русском языке.**

🔗 **Ссылка на видео:** https://www.youtube.com/watch?v=U0PC37rubQ0

### Что вы узнаете из видео:
- Практические техники и методы
- Реальные примеры применения
- Экспертные советы и рекомендации
- Дополнительные инсайты по теме урока

*Рекомендуется просмотреть видео после изучения теоретического материала для закрепления знаний.*


## 📹 Видео урок

**Ссылка:** https://www.youtube.com/watch?v=U0PC37rubQ0
**ID видео:** U0PC37rubQ0
**Тип контента:** VIDEO', 1, 2, '2025-06-02 09:58:39', NULL);
INSERT INTO lessons (id, title, content, order, module_id, created_at, updated_at) VALUES (14, 'Активное слушание и эмпатия', '# Активное слушание и эмпатия


# Активное слушание и эмпатия

## Что такое активное слушание?

Активное слушание — это техника общения, при которой слушатель полностью сосредоточен на собеседнике.

### Принципы активного слушания:
1. **Полное внимание** — убираем отвлекающие факторы
2. **Не перебиваем** — даем возможность высказаться
3. **Задаем уточняющие вопросы**
4. **Перефразируем** сказанное для проверки понимания
5. **Показываем заинтересованность** кивками и короткими репликами

## Техники активного слушания

### 1. Перефразирование
"Если я правильно понял, вы имеете в виду..."

### 2. Резюмирование
"Итак, основные моменты..."

### 3. Эмоциональная поддержка
"Я понимаю, что это сложная ситуация"

## Развитие эмпатии

Эмпатия — способность понимать и разделять чувства другого человека.

### Как развить эмпатию:
- Ставьте себя на место собеседника
- Обращайте внимание на эмоции
- Не судите поспешно
- Задавайте открытые вопросы
        

## 📹 Видео к уроку

**Краткий, но содержательный урок о техниках активного слушания за 6 минут. Практические советы для улучшения навыков общения.**

🔗 **Ссылка на видео:** https://www.youtube.com/watch?v=SB5MMQcJ1YA

### Что вы узнаете из видео:
- Практические техники и методы
- Реальные примеры применения
- Экспертные советы и рекомендации
- Дополнительные инсайты по теме урока

*Рекомендуется просмотреть видео после изучения теоретического материала для закрепления знаний.*


## 📹 Видео урок

**Ссылка:** https://www.youtube.com/watch?v=SB5MMQcJ1YA
**ID видео:** SB5MMQcJ1YA
**Тип контента:** VIDEO', 2, 2, '2025-06-02 09:58:39', NULL);
INSERT INTO lessons (id, title, content, order, module_id, created_at, updated_at) VALUES (15, 'Невербальная коммуникация и язык тела', '# Невербальная коммуникация и язык тела


# Невербальная коммуникация и язык тела

## Важность невербального общения

По исследованиям, 55% информации передается через язык тела, 38% через интонацию и только 7% через слова.

### Основные элементы невербальной коммуникации:

#### 1. Мимика лица
- Улыбка создает доверие
- Нахмуренные брови — признак недовольства
- Поднятые брови — удивление или интерес

#### 2. Жесты рук
- Открытые ладони — честность
- Скрещенные руки — защитная позиция
- Указательный жест может восприниматься агрессивно

#### 3. Поза тела
- Прямая осанка — уверенность
- Наклон вперед — заинтересованность
- Отклонение назад — дистанцирование

#### 4. Зрительный контакт
- Поддержание контакта — внимание и уважение
- Избегание взгляда — неуверенность или обман
- Слишком пристальный взгляд — агрессия

## Культурные различия

Важно помнить, что жесты могут иметь разное значение в разных культурах.
        

## 📹 Видео к уроку

**Обучающее видео о невербальном общении и языке тела. Изучите секреты успешной коммуникации без слов.**

🔗 **Ссылка на видео:** https://www.youtube.com/watch?v=rYLfcUFZ8kQ

### Что вы узнаете из видео:
- Практические техники и методы
- Реальные примеры применения
- Экспертные советы и рекомендации
- Дополнительные инсайты по теме урока

*Рекомендуется просмотреть видео после изучения теоретического материала для закрепления знаний.*


## 📹 Видео урок

**Ссылка:** https://www.youtube.com/watch?v=rYLfcUFZ8kQ
**ID видео:** rYLfcUFZ8kQ
**Тип контента:** VIDEO', 3, 2, '2025-06-02 09:58:39', NULL);
INSERT INTO lessons (id, title, content, order, module_id, created_at, updated_at) VALUES (16, 'Управление конфликтами в общении', '# Управление конфликтами в общении


# Управление конфликтами в общении

## Типы конфликтов

### 1. Конфликт интересов
Когда стороны хотят разного результата

### 2. Конфликт ценностей
Разные взгляды на то, что правильно

### 3. Конфликт восприятия
Разная интерпретация одних и тех же фактов

## Стратегии разрешения конфликтов

### 1. Сотрудничество
Поиск решения, выгодного для всех сторон

### 2. Компромисс
Взаимные уступки

### 3. Приспособление
Уступка более важной стороне

### 4. Избегание
Временное откладывание решения

### 5. Соперничество
Настаивание на своем (крайняя мера)

## Техники деэскалации

1. **Слушайте активно** — дайте выговориться
2. **Признавайте эмоции** — "Я вижу, вы расстроены"
3. **Ищите общие интересы** — что объединяет
4. **Фокусируйтесь на проблеме**, а не на личности
5. **Предлагайте варианты** решения

## Модель WIN-WIN

Стремитесь к решениям, где выигрывают все стороны.
        

## 📹 Видео к уроку

**Практический урок по управлению конфликтами. Научитесь эффективно разрешать споры и выходить из сложных ситуаций.**

🔗 **Ссылка на видео:** https://www.youtube.com/watch?v=Qug4IStz4_Y

### Что вы узнаете из видео:
- Практические техники и методы
- Реальные примеры применения
- Экспертные советы и рекомендации
- Дополнительные инсайты по теме урока

*Рекомендуется просмотреть видео после изучения теоретического материала для закрепления знаний.*


## 📹 Видео урок

**Ссылка:** https://www.youtube.com/watch?v=Qug4IStz4_Y
**ID видео:** Qug4IStz4_Y
**Тип контента:** VIDEO', 4, 2, '2025-06-02 09:58:39', NULL);
INSERT INTO lessons (id, title, content, order, module_id, created_at, updated_at) VALUES (17, 'Эффективная обратная связь', '# Эффективная обратная связь


# Эффективная обратная связь

## Что такое обратная связь?

Обратная связь — это информация о том, как ваши действия влияют на других и на результат работы.

## Принципы конструктивной обратной связи

### При ДАЧИ обратной связи:

#### 1. Модель SBI (Situation-Behavior-Impact)
- **Ситуация**: Опишите контекст
- **Поведение**: Что конкретно наблюдали
- **Влияние**: Как это повлияло на результат

#### 2. Будьте конкретными
❌ "Ты плохо работаешь"
✅ "В презентации не хватало данных о продажах"

#### 3. Фокус на поведении, не на личности
❌ "Ты безответственный"
✅ "Отчет был сдан с опозданием"

#### 4. Предлагайте решения
"В следующий раз можно добавить график с результатами"

### При ПОЛУЧЕНИИ обратной связи:

1. **Слушайте открыто** — не защищайтесь сразу
2. **Задавайте уточняющие вопросы**
3. **Благодарите** за информацию
4. **Планируйте улучшения**

## Модель GROW для развивающей обратной связи

- **Goal** — Какой цели хотим достичь?
- **Reality** — Что происходит сейчас?
- **Options** — Какие есть варианты?
- **Will** — Что будем делать?
        

## 📹 Видео к уроку

**Урок об эмоциональном интеллекте в коммуникации. Изучите основы управления эмоциями в процессе общения.**

🔗 **Ссылка на видео:** https://www.youtube.com/watch?v=fdUR9qYl7iU

### Что вы узнаете из видео:
- Практические техники и методы
- Реальные примеры применения
- Экспертные советы и рекомендации
- Дополнительные инсайты по теме урока

*Рекомендуется просмотреть видео после изучения теоретического материала для закрепления знаний.*


## 📹 Видео урок

**Ссылка:** https://www.youtube.com/watch?v=fdUR9qYl7iU
**ID видео:** fdUR9qYl7iU
**Тип контента:** VIDEO', 5, 2, '2025-06-02 09:58:39', NULL);
INSERT INTO lessons (id, title, content, order, module_id, created_at, updated_at) VALUES (18, 'Презентационные навыки', '# Презентационные навыки


# Презентационные навыки

## Структура эффективной презентации

### 1. Вступление (10-15%)
- Привлечение внимания
- Представление темы
- Анонс структуры

### 2. Основная часть (70-80%)
- 3-5 ключевых пунктов
- Аргументы и примеры
- Визуальная поддержка

### 3. Заключение (10-15%)
- Резюме ключевых моментов
- Призыв к действию
- Ответы на вопросы

## Правило 10/20/30

- **10 слайдов** максимум
- **20 минут** презентация
- **30 пунктов** шрифт минимум

## Работа с аудиторией

### До презентации:
- Изучите аудиторию
- Подготовьте ответы на возможные вопросы
- Проверьте технику

### Во время презентации:
- Поддерживайте зрительный контакт
- Используйте паузы
- Вовлекайте аудиторию вопросами
- Следите за реакцией

### Управление волнением:
1. Глубокое дыхание
2. Позитивная визуализация
3. Подготовка и репетиции
4. Фокус на сообщении, а не на себе

## Визуальные материалы

- Один слайд — одна идея
- Больше изображений, меньше текста
- Контрастные цвета
- Читаемые шрифты
        

## 📹 Видео к уроку

**Обучающее видео о навыках публичных выступлений. Научитесь уверенно выступать перед аудиторией.**

🔗 **Ссылка на видео:** https://www.youtube.com/watch?v=2HT59cO72xg

### Что вы узнаете из видео:
- Практические техники и методы
- Реальные примеры применения
- Экспертные советы и рекомендации
- Дополнительные инсайты по теме урока

*Рекомендуется просмотреть видео после изучения теоретического материала для закрепления знаний.*


## 📹 Видео урок

**Ссылка:** https://www.youtube.com/watch?v=2HT59cO72xg
**ID видео:** 2HT59cO72xg
**Тип контента:** VIDEO', 6, 2, '2025-06-02 09:58:39', NULL);
INSERT INTO lessons (id, title, content, order, module_id, created_at, updated_at) VALUES (19, 'Цифровая коммуникация и этикет', '# Цифровая коммуникация и этикет


# Цифровая коммуникация и этикет

## Email-этикет

### Структура эффективного письма:

#### 1. Тема письма
- Конкретная и информативная
- ✅ "Вопрос по проекту X — нужно решение до пятницы"
- ❌ "Важно!" или "Вопрос"

#### 2. Приветствие
- Формальное: "Уважаемый/ая [Имя]"
- Полуформальное: "Здравствуйте, [Имя]"
- Неформальное: "Привет, [Имя]"

#### 3. Основная часть
- Сначала контекст, потом детали
- Короткие абзацы
- Маркированные списки для перечислений

#### 4. Призыв к действию
- Четко указывайте, что нужно сделать
- Дедлайны и приоритеты

#### 5. Подпись
- Имя, должность, контакты

## Мессенджеры на работе

### Принципы:
- Уважайте рабочее время
- Используйте статусы доступности
- Групповые чаты — для общих вопросов
- Личные сообщения — для приватных тем

### Emoji и стикеры:
- Умеренно в рабочем контексте
- Помогают передать эмоции
- Не заменяют слова полностью

## Видеоконференции

### Технические аспекты:
- Проверьте связь заранее
- Хорошее освещение лица
- Нейтральный фон
- Качественный звук

### Этикет:
- Приходите вовремя
- Выключайте микрофон, когда не говорите
- Смотрите в камеру, а не на экран
- Одевайтесь профессионально
        

## 📹 Видео к уроку

**Урок о цифровом этикете и правилах вежливого общения онлайн. Изучите современные нормы сетевого этикета.**

🔗 **Ссылка на видео:** https://www.youtube.com/watch?v=bs6IALQmxYs

### Что вы узнаете из видео:
- Практические техники и методы
- Реальные примеры применения
- Экспертные советы и рекомендации
- Дополнительные инсайты по теме урока

*Рекомендуется просмотреть видео после изучения теоретического материала для закрепления знаний.*


## 📹 Видео урок

**Ссылка:** https://www.youtube.com/watch?v=bs6IALQmxYs
**ID видео:** bs6IALQmxYs
**Тип контента:** VIDEO', 7, 2, '2025-06-02 09:58:39', NULL);
INSERT INTO lessons (id, title, content, order, module_id, created_at, updated_at) VALUES (20, 'Межкультурная коммуникация', '# Межкультурная коммуникация


# Межкультурная коммуникация

## Культурные измерения Хофстеде

### 1. Дистанция власти
- **Высокая**: четкая иерархия (Россия, Корея)
- **Низкая**: равенство в общении (Дания, Австралия)

### 2. Индивидуализм vs Коллективизм
- **Индивидуалистские**: США, Германия
- **Коллективистские**: Япония, Китай

### 3. Избегание неопределенности
- **Высокое**: четкие правила (Германия)
- **Низкое**: гибкость (США, Индия)

## Стили коммуникации

### Прямой vs Косвенный
- **Прямой**: говорят что думают (Германия, Нидерланды)
- **Косвенный**: намеки и контекст (Япония, Корея)

### Высококонтекстный vs Низкоконтекстный
- **Высокий контекст**: важна ситуация (Япония, Арабские страны)
- **Низкий контекст**: важны слова (Германия, США)

## Практические советы

### При работе с разными культурами:

1. **Изучите основы** культуры коллег
2. **Будьте терпеливы** к различиям
3. **Не обобщайте** — каждый человек уникален
4. **Уточняйте понимание** чаще
5. **Адаптируйте стиль** общения

### Невербальные различия:
- Зрительный контакт
- Личное пространство
- Жесты и их значения
- Отношение к времени

## Построение инклюзивной среды

- Избегайте культурных стереотипов
- Создавайте возможности для всех высказаться
- Учитывайте временные зоны при планировании
- Используйте простой и понятный язык
        

## 📹 Видео к уроку

**Образовательная программа о русском языке в культуре речи и деловом общении с представителями разных культур.**

🔗 **Ссылка на видео:** https://www.youtube.com/watch?v=YOkgQbJnB5A

### Что вы узнаете из видео:
- Практические техники и методы
- Реальные примеры применения
- Экспертные советы и рекомендации
- Дополнительные инсайты по теме урока

*Рекомендуется просмотреть видео после изучения теоретического материала для закрепления знаний.*


## 📹 Видео урок

**Ссылка:** https://www.youtube.com/watch?v=YOkgQbJnB5A
**ID видео:** YOkgQbJnB5A
**Тип контента:** VIDEO', 8, 2, '2025-06-02 09:58:39', NULL);
INSERT INTO lessons (id, title, content, order, module_id, created_at, updated_at) VALUES (21, 'Эмоциональный интеллект в коммуникации', '# Эмоциональный интеллект в коммуникации


# Эмоциональный интеллект в коммуникации

## Что такое эмоциональный интеллект?

EQ (Emotional Quotient) — способность понимать и управлять своими и чужими эмоциями.

## Четыре компонента EQ

### 1. Самосознание
- Понимание своих эмоций
- Знание своих сильных и слабых сторон
- Реалистичная самооценка

### 2. Саморегуляция
- Управление импульсами
- Адаптивность к изменениям
- Инициативность

### 3. Социальное понимание
- Эмпатия к другим
- Понимание организационной динамики
- Ориентация на сервис

### 4. Управление отношениями
- Влияние на других
- Лидерство
- Управление конфликтами
- Командная работа

## Эмоции в рабочей среде

### Позитивные эмоции:
- Энтузиазм — мотивирует команду
- Благодарность — укрепляет отношения
- Оптимизм — помогает в трудностях

### Сложные эмоции:
- Стресс — может снижать эффективность
- Фрустрация — требует конструктивного выхода
- Тревога — нужны техники успокоения

## Техники управления эмоциями

### 1. Техника STOP
- **S**top — остановитесь
- **T**ake a breath — сделайте вдох
- **O**bserve — понаблюдайте за эмоциями
- **P**roceed — действуйте осознанно

### 2. Переформулирование
Измените внутренний диалог:
❌ "Это катастрофа!"
✅ "Это вызов, который можно решить"

### 3. Техника 5-4-3-2-1
При стрессе назовите:
- 5 вещей, которые видите
- 4 вещи, которые слышите  
- 3 вещи, которые можете потрогать
- 2 запаха
- 1 вкус
        

## 📹 Видео к уроку

**Профессиональная лекция об основах эмоционального интеллекта. Развитие навыков управления эмоциями в общении.**

🔗 **Ссылка на видео:** https://www.youtube.com/watch?v=JJ6Pa83oW7w

### Что вы узнаете из видео:
- Практические техники и методы
- Реальные примеры применения
- Экспертные советы и рекомендации
- Дополнительные инсайты по теме урока

*Рекомендуется просмотреть видео после изучения теоретического материала для закрепления знаний.*


## 📹 Видео урок

**Ссылка:** https://www.youtube.com/watch?v=JJ6Pa83oW7w
**ID видео:** JJ6Pa83oW7w
**Тип контента:** VIDEO', 9, 2, '2025-06-02 09:58:39', NULL);
INSERT INTO lessons (id, title, content, order, module_id, created_at, updated_at) VALUES (22, 'Практикум: Интеграция коммуникативных навыков', '# Практикум: Интеграция коммуникативных навыков


# Практикум: Интеграция коммуникативных навыков

## Цель практикума

Объединить все изученные навыки коммуникации и применить их в комплексных сценариях.

## Ключевые навыки для интеграции

### 1. Активное слушание
- Техники SBI (Situation-Behavior-Impact)
- Эмпатическое понимание
- Парафразирование и резюмирование

### 2. Невербальная коммуникация
- Язык тела и жесты
- Зрительный контакт
- Управление пространством

### 3. Управление эмоциями
- Техника STOP
- Эмоциональная регуляция
- Конструктивное выражение чувств

### 4. Конфликт-менеджмент
- Деэскалация напряжения
- Поиск win-win решений
- Медиация между сторонами

## Практические сценарии

### Сценарий 1: Сложная презентация
**Ситуация**: Презентация проекта перед скептически настроенной аудиторией

**Применяемые навыки**:
- Структурирование информации
- Работа с возражениями
- Невербальная уверенность
- Адаптация к аудитории

### Сценарий 2: Командный конфликт
**Ситуация**: Конфликт между двумя коллегами влияет на работу команды

**Применяемые навыки**:
- Активное слушание всех сторон
- Эмоциональная регуляция
- Медиация и поиск компромиссов
- Обратная связь

### Сценарий 3: Межкультурная коммуникация
**Ситуация**: Работа с международной командой с разными культурными особенностями

**Применяемые навыки**:
- Культурная чувствительность
- Адаптация стиля общения
- Цифровая коммуникация
- Инклюзивность

## Модель GROW в действии

Для каждого сценария используйте модель GROW:

- **Goal** — Какой результат хотим достичь?
- **Reality** — Что происходит сейчас?
- **Options** — Какие у нас есть варианты?
- **Will** — Что конкретно будем делать?

## Самооценка и планирование развития

### Чек-лист коммуникативных навыков:

1. **Слушание** (1-10): ___
2. **Говорение** (1-10): ___
3. **Невербальное общение** (1-10): ___
4. **Управление конфликтами** (1-10): ___
5. **Обратная связь** (1-10): ___
6. **Презентации** (1-10): ___
7. **Цифровая коммуникация** (1-10): ___
8. **Межкультурное общение** (1-10): ___
9. **Эмоциональный интеллект** (1-10): ___

### План развития на 3 месяца:

**Цель 1**: (выберите 2-3 навыка для фокуса)
**Действия**: (конкретные шаги)
**Метрики**: (как измерить прогресс)

## Заключение

Эффективная коммуникация — это навык, который развивается постоянно. Продолжайте практиковаться и получать обратную связь!
    

## 📹 Видео к уроку

**Урок о различных видах публичных выступлений. Практическое применение всех изученных коммуникативных техник.**

🔗 **Ссылка на видео:** https://www.youtube.com/watch?v=hcAm5lyQVyk

### Что вы узнаете из видео:
- Практические техники и методы
- Реальные примеры применения
- Экспертные советы и рекомендации
- Дополнительные инсайты по теме урока

*Рекомендуется просмотреть видео после изучения теоретического материала для закрепления знаний.*


## 📹 Видео урок

**Ссылка:** https://www.youtube.com/watch?v=hcAm5lyQVyk
**ID видео:** hcAm5lyQVyk
**Тип контента:** VIDEO', 10, 2, '2025-06-02 09:58:39', NULL);
INSERT INTO lessons (id, title, content, order, module_id, created_at, updated_at) VALUES (23, 'Эффективная коммуникация', '# Эффективная коммуникация

## Введение

Эффективная коммуникация является основой успешной работы в команде.

### Ключевые принципы

1. **Активное слушание** - внимательно слушайте собеседника
2. **Ясность изложения** - выражайте мысли четко и понятно
3. **Эмпатия** - понимайте точку зрения других

### Практические советы

- Используйте "Я-высказывания" вместо обвинений
- Задавайте открытые вопросы
- Подтверждайте понимание перефразированием

## Заключение

Применяя эти принципы, вы значительно улучшите качество коммуникации в команде.

## 📹 Видео к уроку

**Профессиональный урок об основах деловой коммуникации. Изучите ключевые принципы эффективного общения в бизнес-среде.**

🔗 **Ссылка на видео:** https://www.youtube.com/watch?v=Nu9uvs2UeaM

### Что вы узнаете из видео:
- Практические техники и методы
- Реальные примеры применения
- Экспертные советы и рекомендации
- Дополнительные инсайты по теме урока

*Рекомендуется просмотреть видео после изучения теоретического материала для закрепления знаний.*


## 📹 Видео урок

**Ссылка:** https://www.youtube.com/watch?v=Nu9uvs2UeaM
**ID видео:** Nu9uvs2UeaM
**Тип контента:** VIDEO', 11, 2, '2025-06-02 09:58:39', NULL);
INSERT INTO lessons (id, title, content, order, module_id, created_at, updated_at) VALUES (24, 'Техники активного слушания', '# Техники активного слушания

# Техники активного слушания

## Основы активного слушания

Активное слушание — это навык полного погружения в процесс восприятия информации от собеседника с целью максимального понимания как содержания, так и эмоций.

### Уровни слушания

1. **Внутреннее слушание**
   - Фокус на собственных мыслях
   - Подготовка ответа во время речи собеседника
   - Оценочные суждения

2. **Фокусированное слушание**
   - Концентрация на словах собеседника
   - Понимание содержания
   - Минимальные внутренние отвлечения

3. **Глобальное слушание**
   - Восприятие всех сигналов
   - Внимание к эмоциям и энергии
   - Интуитивное понимание

### Техники активного слушания

**Парафраз (Перефразирование):**
- Повторение услышанного своими словами
- Проверка понимания
- Пример: "Если я правильно понял, вы говорите о..."

**Отражение чувств:**
- Озвучивание эмоционального состояния
- Демонстрация эмпатии
- Пример: "Я вижу, что вы расстроены этой ситуацией"

**Уточнение:**
- Открытые вопросы для получения деталей
- Избегание предположений
- Пример: "Можете ли вы рассказать больше о..."

**Резюмирование:**
- Обобщение ключевых моментов
- Структурирование информации
- Пример: "Итак, основные моменты..."

### Невербальные сигналы

**Поза и жесты:**
- Открытая поза тела
- Наклон к собеседнику
- Зрительный контакт
- Кивки головой

**Мимика:**
- Соответствующее выражение лица
- Отражение эмоций собеседника
- Искренность в выражениях

**Голосовые сигналы:**
- Тон голоса
- Скорость речи
- Паузы
- Интонации

### Препятствия для активного слушания

**Внутренние барьеры:**
- Предварительные суждения
- Эмоциональные реакции
- Отвлечение на собственные мысли
- Подготовка возражений

**Внешние факторы:**
- Шум и отвлекающие факторы
- Временные ограничения
- Неподходящая обстановка
- Технические помехи

### Эмпатическое слушание

**Принципы эмпатии:**
- Понимание без оценки
- Принятие чувств собеседника
- Сопереживание
- Поддержка

**Техники развития эмпатии:**
- Постановка себя на место другого
- Внимание к эмоциональным сигналам
- Отложение собственных суждений
- Создание безопасного пространства

### Активное слушание в конфликтах

**Деэскалация:**
- Спокойный тон голоса
- Признание чувств сторон
- Поиск общих интересов
- Фокус на фактах

**Медиация:**
- Нейтральная позиция
- Равное время для каждой стороны
- Структурирование диалога
- Поиск решений

### Практические упражнения

**Упражнение "Зеркало":**
- Повторение последних слов собеседника
- Отражение тона и эмоций
- Проверка понимания

**Упражнение "Три уровня":**
- Слушание фактов (что говорится)
- Слушание эмоций (как говорится)
- Слушание потребностей (зачем говорится)

### Развитие навыков

**Ежедневная практика:**
- Сосредоточенное слушание в каждом разговоре
- Отключение электронных устройств
- Задавание открытых вопросов
- Благодарность за откровенность


## 📹 Видео к уроку

**Практический урок о техниках активного слушания. Научитесь лучше понимать собеседника и выстраивать доверительные отношения.**

🔗 **Ссылка на видео:** https://www.youtube.com/watch?v=QWvijbXrCCQ

### Что вы узнаете из видео:
- Практические техники и методы
- Реальные примеры применения
- Экспертные советы и рекомендации
- Дополнительные инсайты по теме урока

*Рекомендуется просмотреть видео после изучения теоретического материала для закрепления знаний.*


## 📹 Видео урок

**Ссылка:** https://www.youtube.com/watch?v=QWvijbXrCCQ
**ID видео:** QWvijbXrCCQ
**Тип контента:** VIDEO', 12, 2, '2025-06-02 09:58:39', NULL);

-- Данные для таблицы user_answers
DELETE FROM user_answers;
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (1, 1, 1, 2, NULL, NULL, '2025-06-01 13:06:11');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (2, 1, 2, 7, NULL, NULL, '2025-06-01 13:06:11');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (3, 1, 3, 11, NULL, NULL, '2025-06-01 13:06:11');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (4, 1, 4, 17, NULL, NULL, '2025-06-01 13:06:11');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (5, 1, 5, 22, NULL, NULL, '2025-06-01 13:06:11');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (6, 1, 6, 30, NULL, NULL, '2025-06-01 13:06:11');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (7, 1, 7, 33, NULL, NULL, '2025-06-01 13:06:11');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (8, 1, 8, 40, NULL, NULL, '2025-06-01 13:06:11');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (9, 1, 9, 42, NULL, NULL, '2025-06-01 13:06:11');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (10, 1, 10, 48, NULL, NULL, '2025-06-01 13:06:11');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (11, 1, 11, 53, NULL, NULL, '2025-06-01 13:06:11');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (12, 1, 12, 59, NULL, NULL, '2025-06-01 13:06:11');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (13, 2, 1, 2, NULL, NULL, '2025-06-01 19:50:00');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (14, 2, 2, 8, NULL, NULL, '2025-06-01 19:50:00');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (15, 2, 3, 12, NULL, NULL, '2025-06-01 19:50:00');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (16, 2, 4, 18, NULL, NULL, '2025-06-01 19:50:00');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (17, 2, 5, 22, NULL, NULL, '2025-06-01 19:50:00');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (18, 2, 6, 28, NULL, NULL, '2025-06-01 19:50:00');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (19, 2, 7, 33, NULL, NULL, '2025-06-01 19:50:00');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (20, 2, 8, 36, NULL, NULL, '2025-06-01 19:50:00');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (21, 2, 9, 43, NULL, NULL, '2025-06-01 19:50:00');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (22, 2, 10, 46, NULL, NULL, '2025-06-01 19:50:00');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (23, 2, 11, 52, NULL, NULL, '2025-06-01 19:50:00');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (24, 2, 12, 56, NULL, NULL, '2025-06-01 19:50:00');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (25, 3, 1, 1, NULL, NULL, '2025-06-02 11:12:32');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (26, 3, 2, 8, NULL, NULL, '2025-06-02 11:12:32');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (27, 3, 3, 15, NULL, NULL, '2025-06-02 11:12:32');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (28, 3, 4, 17, NULL, NULL, '2025-06-02 11:12:32');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (29, 3, 5, 23, NULL, NULL, '2025-06-02 11:12:32');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (30, 3, 6, 29, NULL, NULL, '2025-06-02 11:12:32');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (31, 3, 7, 31, NULL, NULL, '2025-06-02 11:12:32');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (32, 3, 8, 40, NULL, NULL, '2025-06-02 11:12:32');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (33, 3, 9, 42, NULL, NULL, '2025-06-02 11:12:32');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (34, 3, 10, 49, NULL, NULL, '2025-06-02 11:12:32');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (35, 3, 11, 51, NULL, NULL, '2025-06-02 11:12:32');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (36, 3, 12, 59, NULL, NULL, '2025-06-02 11:12:32');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (37, 4, 1, 3, NULL, NULL, '2025-06-02 14:35:51');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (38, 4, 2, 10, NULL, NULL, '2025-06-02 14:35:51');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (39, 4, 3, 12, NULL, NULL, '2025-06-02 14:35:51');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (40, 4, 4, 19, NULL, NULL, '2025-06-02 14:35:51');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (41, 4, 5, 21, NULL, NULL, '2025-06-02 14:35:51');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (42, 4, 6, 28, NULL, NULL, '2025-06-02 14:35:51');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (43, 4, 7, 34, NULL, NULL, '2025-06-02 14:35:51');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (44, 4, 8, 39, NULL, NULL, '2025-06-02 14:35:51');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (45, 4, 9, 42, NULL, NULL, '2025-06-02 14:35:51');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (46, 4, 10, 50, NULL, NULL, '2025-06-02 14:35:51');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (47, 4, 11, 51, NULL, NULL, '2025-06-02 14:35:51');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (48, 4, 12, 58, NULL, NULL, '2025-06-02 14:35:51');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (49, 6, 1, 4, NULL, NULL, '2025-06-03 00:26:49');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (50, 6, 2, 9, NULL, NULL, '2025-06-03 00:26:49');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (51, 6, 3, 13, NULL, NULL, '2025-06-03 00:26:49');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (52, 6, 4, 20, NULL, NULL, '2025-06-03 00:26:49');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (53, 6, 5, 23, NULL, NULL, '2025-06-03 00:26:49');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (54, 6, 6, 30, NULL, NULL, '2025-06-03 00:26:49');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (55, 6, 7, 34, NULL, NULL, '2025-06-03 00:26:49');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (56, 6, 8, 40, NULL, NULL, '2025-06-03 00:26:49');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (57, 6, 9, 43, NULL, NULL, '2025-06-03 00:26:49');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (58, 6, 10, 50, NULL, NULL, '2025-06-03 00:26:49');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (59, 6, 11, 53, NULL, NULL, '2025-06-03 00:26:49');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (60, 6, 12, 59, NULL, NULL, '2025-06-03 00:26:49');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (61, 5, 1, 1, NULL, NULL, '2025-06-03 04:18:47');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (62, 5, 2, 8, NULL, NULL, '2025-06-03 04:18:47');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (63, 5, 3, 11, NULL, NULL, '2025-06-03 04:18:47');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (64, 5, 4, 19, NULL, NULL, '2025-06-03 04:18:47');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (65, 5, 5, 23, NULL, NULL, '2025-06-03 04:18:47');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (66, 5, 6, 30, NULL, NULL, '2025-06-03 04:18:47');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (67, 5, 7, 33, NULL, NULL, '2025-06-03 04:18:47');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (68, 5, 8, 36, NULL, NULL, '2025-06-03 04:18:47');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (69, 5, 9, 44, NULL, NULL, '2025-06-03 04:18:47');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (70, 5, 10, 48, NULL, NULL, '2025-06-03 04:18:47');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (71, 5, 11, 52, NULL, NULL, '2025-06-03 04:18:47');
INSERT INTO user_answers (id, assessment_id, question_id, selected_option_id, text_answer, scale_value, answered_at) VALUES (72, 5, 12, 60, NULL, NULL, '2025-06-03 04:18:47');

-- Данные для таблицы daily_tasks
DELETE FROM daily_tasks;
INSERT INTO daily_tasks (id, title, description, task_type, difficulty, points, is_active, created_at) VALUES (1, 'Поговорите с незнакомым человеком', 'Начните разговор с кем-то новым сегодня. Это может быть коллега из другого отдела, сосед или человек в очереди.', 'COMMUNICATION', 'EASY', 15, 1, '2025-06-01 13:11:59');
INSERT INTO daily_tasks (id, title, description, task_type, difficulty, points, is_active, created_at) VALUES (2, 'Попросите обратную связь', 'Попросите коллегу или руководителя дать вам обратную связь по недавней работе или проекту.', 'COMMUNICATION', 'MEDIUM', 20, 1, '2025-06-01 13:11:59');
INSERT INTO daily_tasks (id, title, description, task_type, difficulty, points, is_active, created_at) VALUES (3, 'Проведите презентацию', 'Представьте свою идею или проект перед группой людей, даже если это всего лишь 5-минутная презентация.', 'COMMUNICATION', 'HARD', 30, 1, '2025-06-01 13:11:59');
INSERT INTO daily_tasks (id, title, description, task_type, difficulty, points, is_active, created_at) VALUES (4, 'Активно слушайте собеседника', 'В следующем разговоре сосредоточьтесь на активном слушании - задавайте уточняющие вопросы и перефразируйте сказанное.', 'COMMUNICATION', 'EASY', 10, 1, '2025-06-01 13:11:59');
INSERT INTO daily_tasks (id, title, description, task_type, difficulty, points, is_active, created_at) VALUES (5, 'Возьмите инициативу в команде', 'Предложите новую идею или возьмите на себя организацию небольшого проекта или встречи.', 'LEADERSHIP', 'MEDIUM', 25, 1, '2025-06-01 13:11:59');
INSERT INTO daily_tasks (id, title, description, task_type, difficulty, points, is_active, created_at) VALUES (6, 'Помогите коллеге решить проблему', 'Найдите коллегу, у которого есть сложности, и предложите свою помощь в решении проблемы.', 'LEADERSHIP', 'EASY', 15, 1, '2025-06-01 13:11:59');
INSERT INTO daily_tasks (id, title, description, task_type, difficulty, points, is_active, created_at) VALUES (7, 'Дайте конструктивную обратную связь', 'Предоставьте полезную и конструктивную обратную связь коллеге или подчиненному.', 'LEADERSHIP', 'MEDIUM', 20, 1, '2025-06-01 13:11:59');
INSERT INTO daily_tasks (id, title, description, task_type, difficulty, points, is_active, created_at) VALUES (8, 'Организуйте командную встречу', 'Инициируйте и проведите короткую командную встречу для обсуждения текущих задач или планов.', 'LEADERSHIP', 'HARD', 30, 1, '2025-06-01 13:11:59');
INSERT INTO daily_tasks (id, title, description, task_type, difficulty, points, is_active, created_at) VALUES (9, 'Предложите помощь коллеге', 'Активно предложите помощь коллеге с его задачей или проектом.', 'TEAMWORK', 'EASY', 10, 1, '2025-06-01 13:11:59');
INSERT INTO daily_tasks (id, title, description, task_type, difficulty, points, is_active, created_at) VALUES (10, 'Организуйте совместный обед', 'Пригласите коллег на совместный обед или кофе-брейк для неформального общения.', 'TEAMWORK', 'EASY', 15, 1, '2025-06-01 13:11:59');
INSERT INTO daily_tasks (id, title, description, task_type, difficulty, points, is_active, created_at) VALUES (11, 'Поделитесь знаниями с командой', 'Проведите небольшую сессию знакомства с новым инструментом или методом работы для коллег.', 'TEAMWORK', 'MEDIUM', 25, 1, '2025-06-01 13:11:59');
INSERT INTO daily_tasks (id, title, description, task_type, difficulty, points, is_active, created_at) VALUES (12, 'Разрешите конфликт в команде', 'Если есть разногласия в команде, помогите найти компромисс и решение, которое устроит всех.', 'TEAMWORK', 'HARD', 35, 1, '2025-06-01 13:11:59');
INSERT INTO daily_tasks (id, title, description, task_type, difficulty, points, is_active, created_at) VALUES (13, 'Найдите альтернативное решение', 'Для любой задачи, с которой вы столкнетесь сегодня, найдите как минимум два разных способа ее решения.', 'PROBLEM_SOLVING', 'EASY', 15, 1, '2025-06-01 13:11:59');
INSERT INTO daily_tasks (id, title, description, task_type, difficulty, points, is_active, created_at) VALUES (14, 'Проанализируйте сложную проблему', 'Разбейте сложную проблему на более мелкие части и составьте план решения каждой из них.', 'PROBLEM_SOLVING', 'MEDIUM', 20, 1, '2025-06-01 13:11:59');
INSERT INTO daily_tasks (id, title, description, task_type, difficulty, points, is_active, created_at) VALUES (15, 'Используйте метод ''Пять почему''', 'Примените технику ''5 почему'' к любой проблеме, чтобы добраться до ее корня.', 'PROBLEM_SOLVING', 'MEDIUM', 25, 1, '2025-06-01 13:11:59');
INSERT INTO daily_tasks (id, title, description, task_type, difficulty, points, is_active, created_at) VALUES (16, 'Предложите инновационное решение', 'Найдите творческий и нестандартный подход к решению рабочей задачи.', 'PROBLEM_SOLVING', 'HARD', 30, 1, '2025-06-01 13:11:59');
INSERT INTO daily_tasks (id, title, description, task_type, difficulty, points, is_active, created_at) VALUES (17, 'Составьте детальный план дня', 'Распланируйте свой день по часам, включая время на задачи, перерывы и неожиданности.', 'TIME_MANAGEMENT', 'EASY', 10, 1, '2025-06-01 13:11:59');
INSERT INTO daily_tasks (id, title, description, task_type, difficulty, points, is_active, created_at) VALUES (18, 'Используйте технику Помодоро', 'Поработайте минимум 2 часа, используя технику Помодоро (25 минут работы, 5 минут перерыв).', 'TIME_MANAGEMENT', 'EASY', 15, 1, '2025-06-01 13:11:59');
INSERT INTO daily_tasks (id, title, description, task_type, difficulty, points, is_active, created_at) VALUES (19, 'Устраните одного пожирателя времени', 'Определите одну вещь, которая тратит ваше время попусту, и исключите ее сегодня.', 'TIME_MANAGEMENT', 'MEDIUM', 20, 1, '2025-06-01 13:11:59');
INSERT INTO daily_tasks (id, title, description, task_type, difficulty, points, is_active, created_at) VALUES (20, 'Делегируйте задачу', 'Найдите задачу, которую можно делегировать, и передайте ее подходящему человеку с четкими инструкциями.', 'TIME_MANAGEMENT', 'HARD', 25, 1, '2025-06-01 13:11:59');
INSERT INTO daily_tasks (id, title, description, task_type, difficulty, points, is_active, created_at) VALUES (21, 'Проанализируйте свои эмоции', 'В течение дня 3 раза остановитесь и запишите, что вы чувствуете и почему.', 'EMOTIONAL_INTELLIGENCE', 'EASY', 10, 1, '2025-06-01 13:11:59');
INSERT INTO daily_tasks (id, title, description, task_type, difficulty, points, is_active, created_at) VALUES (22, 'Проявите эмпатию к коллеге', 'Попытайтесь понять точку зрения коллеги, с которым у вас есть разногласия.', 'EMOTIONAL_INTELLIGENCE', 'MEDIUM', 20, 1, '2025-06-01 13:11:59');
INSERT INTO daily_tasks (id, title, description, task_type, difficulty, points, is_active, created_at) VALUES (23, 'Управляйте стрессом', 'Когда почувствуете стресс, примените технику дыхания или медитации для успокоения.', 'EMOTIONAL_INTELLIGENCE', 'MEDIUM', 25, 1, '2025-06-01 13:11:59');
INSERT INTO daily_tasks (id, title, description, task_type, difficulty, points, is_active, created_at) VALUES (24, 'Поддержите коллегу', 'Найдите коллегу, который выглядит расстроенным или подавленным, и предложите поддержку.', 'EMOTIONAL_INTELLIGENCE', 'EASY', 15, 1, '2025-06-01 13:11:59');

-- Данные для таблицы user_levels
DELETE FROM user_levels;
INSERT INTO user_levels (id, user_id, total_points, current_level, points_to_next_level) VALUES (1, 1, 110, 2, 140);
INSERT INTO user_levels (id, user_id, total_points, current_level, points_to_next_level) VALUES (2, 4, 105, 2, 145);
INSERT INTO user_levels (id, user_id, total_points, current_level, points_to_next_level) VALUES (3, 10, 160, 2, 90);
INSERT INTO user_levels (id, user_id, total_points, current_level, points_to_next_level) VALUES (4, 9, 0, 1, 100);
INSERT INTO user_levels (id, user_id, total_points, current_level, points_to_next_level) VALUES (5, 11, 0, 1, 100);
INSERT INTO user_levels (id, user_id, total_points, current_level, points_to_next_level) VALUES (6, 12, 0, 1, 100);
INSERT INTO user_levels (id, user_id, total_points, current_level, points_to_next_level) VALUES (7, 13, 0, 1, 100);

-- Данные для таблицы task_completions
DELETE FROM task_completions;
INSERT INTO task_completions (id, user_id, task_id, completed_at, points_earned) VALUES (1, 1, 3, '2025-06-01 13:14:37', 30);
INSERT INTO task_completions (id, user_id, task_id, completed_at, points_earned) VALUES (2, 1, 6, '2025-06-01 13:14:46', 15);
INSERT INTO task_completions (id, user_id, task_id, completed_at, points_earned) VALUES (3, 1, 11, '2025-06-01 13:14:52', 25);
INSERT INTO task_completions (id, user_id, task_id, completed_at, points_earned) VALUES (4, 4, 13, '2025-06-01 19:50:44', 15);
INSERT INTO task_completions (id, user_id, task_id, completed_at, points_earned) VALUES (5, 4, 3, '2025-06-01 19:50:52', 30);
INSERT INTO task_completions (id, user_id, task_id, completed_at, points_earned) VALUES (6, 4, 23, '2025-06-01 19:51:06', 25);
INSERT INTO task_completions (id, user_id, task_id, completed_at, points_earned) VALUES (7, 4, 24, '2025-06-01 19:51:14', 15);
INSERT INTO task_completions (id, user_id, task_id, completed_at, points_earned) VALUES (8, 4, 19, '2025-06-01 19:51:30', 20);
INSERT INTO task_completions (id, user_id, task_id, completed_at, points_earned) VALUES (9, 1, 20, '2025-06-01 22:49:48', 25);
INSERT INTO task_completions (id, user_id, task_id, completed_at, points_earned) VALUES (10, 1, 13, '2025-06-02 11:12:57', 15);
INSERT INTO task_completions (id, user_id, task_id, completed_at, points_earned) VALUES (11, 10, 18, '2025-06-02 14:35:00', 15);
INSERT INTO task_completions (id, user_id, task_id, completed_at, points_earned) VALUES (12, 10, 14, '2025-06-02 14:35:03', 20);
INSERT INTO task_completions (id, user_id, task_id, completed_at, points_earned) VALUES (13, 10, 10, '2025-06-02 14:35:08', 15);
INSERT INTO task_completions (id, user_id, task_id, completed_at, points_earned) VALUES (14, 10, 15, '2025-06-02 14:35:18', 25);
INSERT INTO task_completions (id, user_id, task_id, completed_at, points_earned) VALUES (15, 10, 19, '2025-06-02 14:40:19', 20);
INSERT INTO task_completions (id, user_id, task_id, completed_at, points_earned) VALUES (16, 10, 11, '2025-06-02 15:08:21', 25);
INSERT INTO task_completions (id, user_id, task_id, completed_at, points_earned) VALUES (17, 10, 24, '2025-06-02 15:08:25', 15);
INSERT INTO task_completions (id, user_id, task_id, completed_at, points_earned) VALUES (18, 10, 6, '2025-06-02 15:13:00', 15);
INSERT INTO task_completions (id, user_id, task_id, completed_at, points_earned) VALUES (19, 10, 17, '2025-06-02 15:13:03', 10);
INSERT INTO task_completions (id, user_id, task_id, completed_at, points_earned) VALUES (20, 9, 17, '2025-06-02 15:17:35', 10);
INSERT INTO task_completions (id, user_id, task_id, completed_at, points_earned) VALUES (21, 9, 15, '2025-06-02 15:18:00', 25);
INSERT INTO task_completions (id, user_id, task_id, completed_at, points_earned) VALUES (22, 10, 8, '2025-06-02 15:19:25', 30);
INSERT INTO task_completions (id, user_id, task_id, completed_at, points_earned) VALUES (23, 10, 12, '2025-06-02 16:44:13', 35);
INSERT INTO task_completions (id, user_id, task_id, completed_at, points_earned) VALUES (24, 10, 21, '2025-06-02 16:48:12', 10);
INSERT INTO task_completions (id, user_id, task_id, completed_at, points_earned) VALUES (25, 10, 9, '2025-06-02 16:48:15', 10);
INSERT INTO task_completions (id, user_id, task_id, completed_at, points_earned) VALUES (26, 13, 15, '2025-06-03 00:27:07', 25);
INSERT INTO task_completions (id, user_id, task_id, completed_at, points_earned) VALUES (27, 13, 10, '2025-06-03 00:27:13', 15);
INSERT INTO task_completions (id, user_id, task_id, completed_at, points_earned) VALUES (28, 13, 9, '2025-06-03 00:27:16', 10);
INSERT INTO task_completions (id, user_id, task_id, completed_at, points_earned) VALUES (29, 13, 4, '2025-06-03 00:31:02', 10);
INSERT INTO task_completions (id, user_id, task_id, completed_at, points_earned) VALUES (30, 10, 10, '2025-06-03 04:14:16', 15);

-- Данные для таблицы user_daily_task_assignments
DELETE FROM user_daily_task_assignments;
INSERT INTO user_daily_task_assignments (id, user_id, task_id, assigned_date, is_completed, completed_at) VALUES (1, 1, 3, '2025-06-01 18:14:27.491295', 1, '2025-06-01 18:14:37.348808');
INSERT INTO user_daily_task_assignments (id, user_id, task_id, assigned_date, is_completed, completed_at) VALUES (2, 1, 6, '2025-06-01 18:14:27.491514', 1, '2025-06-01 18:14:46.663281');
INSERT INTO user_daily_task_assignments (id, user_id, task_id, assigned_date, is_completed, completed_at) VALUES (3, 1, 11, '2025-06-01 18:14:27.491554', 1, '2025-06-01 18:14:52.051008');
INSERT INTO user_daily_task_assignments (id, user_id, task_id, assigned_date, is_completed, completed_at) VALUES (4, 1, 20, '2025-06-02 00:20:33.143641', 1, '2025-06-02 03:49:48.499884');
INSERT INTO user_daily_task_assignments (id, user_id, task_id, assigned_date, is_completed, completed_at) VALUES (5, 4, 13, '2025-06-02 00:50:29.612424', 1, '2025-06-02 00:50:44.469492');
INSERT INTO user_daily_task_assignments (id, user_id, task_id, assigned_date, is_completed, completed_at) VALUES (6, 4, 3, '2025-06-02 00:50:44.475468', 1, '2025-06-02 00:50:52.224455');
INSERT INTO user_daily_task_assignments (id, user_id, task_id, assigned_date, is_completed, completed_at) VALUES (7, 4, 23, '2025-06-02 00:50:52.229210', 1, '2025-06-02 00:51:06.171770');
INSERT INTO user_daily_task_assignments (id, user_id, task_id, assigned_date, is_completed, completed_at) VALUES (8, 4, 24, '2025-06-02 00:51:06.175817', 1, '2025-06-02 00:51:14.696209');
INSERT INTO user_daily_task_assignments (id, user_id, task_id, assigned_date, is_completed, completed_at) VALUES (9, 4, 19, '2025-06-02 00:51:14.698754', 1, '2025-06-02 00:51:30.294645');
INSERT INTO user_daily_task_assignments (id, user_id, task_id, assigned_date, is_completed, completed_at) VALUES (10, 4, 2, '2025-06-02 00:51:30.300010', 0, NULL);
INSERT INTO user_daily_task_assignments (id, user_id, task_id, assigned_date, is_completed, completed_at) VALUES (11, 1, 13, '2025-06-02 03:49:48.509766', 1, '2025-06-02 16:12:57.870060');
INSERT INTO user_daily_task_assignments (id, user_id, task_id, assigned_date, is_completed, completed_at) VALUES (12, 1, 8, '2025-06-02 16:12:57.879379', 0, NULL);
INSERT INTO user_daily_task_assignments (id, user_id, task_id, assigned_date, is_completed, completed_at) VALUES (13, 10, 18, '2025-06-02 19:33:56.911802', 1, '2025-06-02 19:35:00.642532');
INSERT INTO user_daily_task_assignments (id, user_id, task_id, assigned_date, is_completed, completed_at) VALUES (14, 10, 14, '2025-06-02 19:35:00.651599', 1, '2025-06-02 19:35:03.146671');
INSERT INTO user_daily_task_assignments (id, user_id, task_id, assigned_date, is_completed, completed_at) VALUES (15, 10, 10, '2025-06-02 19:35:03.152606', 1, '2025-06-02 19:35:08.465470');
INSERT INTO user_daily_task_assignments (id, user_id, task_id, assigned_date, is_completed, completed_at) VALUES (16, 10, 15, '2025-06-02 19:35:08.471767', 1, '2025-06-02 19:35:18.041677');
INSERT INTO user_daily_task_assignments (id, user_id, task_id, assigned_date, is_completed, completed_at) VALUES (17, 10, 19, '2025-06-02 19:35:18.047192', 1, '2025-06-02 19:40:19.216442');
INSERT INTO user_daily_task_assignments (id, user_id, task_id, assigned_date, is_completed, completed_at) VALUES (18, 10, 11, '2025-06-02 19:40:19.218490', 1, '2025-06-02 20:08:21.860657');
INSERT INTO user_daily_task_assignments (id, user_id, task_id, assigned_date, is_completed, completed_at) VALUES (19, 10, 24, '2025-06-02 20:08:21.870167', 1, '2025-06-02 20:08:25.588795');
INSERT INTO user_daily_task_assignments (id, user_id, task_id, assigned_date, is_completed, completed_at) VALUES (20, 10, 6, '2025-06-02 20:08:25.595613', 1, '2025-06-02 20:12:59.999108');
INSERT INTO user_daily_task_assignments (id, user_id, task_id, assigned_date, is_completed, completed_at) VALUES (21, 10, 17, '2025-06-02 20:13:00.008903', 1, '2025-06-02 20:13:03.590510');
INSERT INTO user_daily_task_assignments (id, user_id, task_id, assigned_date, is_completed, completed_at) VALUES (22, 10, 8, '2025-06-02 20:13:03.597435', 1, '2025-06-02 20:19:25.668261');
INSERT INTO user_daily_task_assignments (id, user_id, task_id, assigned_date, is_completed, completed_at) VALUES (23, 9, 17, '2025-06-02 20:17:28.259965', 1, '2025-06-02 20:17:35.870309');
INSERT INTO user_daily_task_assignments (id, user_id, task_id, assigned_date, is_completed, completed_at) VALUES (24, 9, 15, '2025-06-02 20:17:35.874795', 1, '2025-06-02 20:18:00.483925');
INSERT INTO user_daily_task_assignments (id, user_id, task_id, assigned_date, is_completed, completed_at) VALUES (25, 9, 18, '2025-06-02 20:18:00.486007', 0, NULL);
INSERT INTO user_daily_task_assignments (id, user_id, task_id, assigned_date, is_completed, completed_at) VALUES (26, 10, 12, '2025-06-02 20:19:25.676423', 1, '2025-06-02 21:44:13.787148');
INSERT INTO user_daily_task_assignments (id, user_id, task_id, assigned_date, is_completed, completed_at) VALUES (27, 10, 21, '2025-06-02 21:44:13.797565', 1, '2025-06-02 21:48:12.665882');
INSERT INTO user_daily_task_assignments (id, user_id, task_id, assigned_date, is_completed, completed_at) VALUES (28, 10, 9, '2025-06-02 21:48:12.675025', 1, '2025-06-02 21:48:15.528120');
INSERT INTO user_daily_task_assignments (id, user_id, task_id, assigned_date, is_completed, completed_at) VALUES (29, 10, 20, '2025-06-02 21:48:15.535051', 0, NULL);
INSERT INTO user_daily_task_assignments (id, user_id, task_id, assigned_date, is_completed, completed_at) VALUES (30, 10, 10, '2025-06-03 03:57:33.778951', 1, '2025-06-03 09:14:16.041088');
INSERT INTO user_daily_task_assignments (id, user_id, task_id, assigned_date, is_completed, completed_at) VALUES (31, 11, 3, '2025-06-03 03:58:06.255084', 0, NULL);
INSERT INTO user_daily_task_assignments (id, user_id, task_id, assigned_date, is_completed, completed_at) VALUES (32, 12, 18, '2025-06-03 04:31:05.485386', 0, NULL);
INSERT INTO user_daily_task_assignments (id, user_id, task_id, assigned_date, is_completed, completed_at) VALUES (33, 13, 15, '2025-06-03 05:26:57.862949', 1, '2025-06-03 05:27:07.572802');
INSERT INTO user_daily_task_assignments (id, user_id, task_id, assigned_date, is_completed, completed_at) VALUES (34, 13, 10, '2025-06-03 05:27:07.585806', 1, '2025-06-03 05:27:13.981682');
INSERT INTO user_daily_task_assignments (id, user_id, task_id, assigned_date, is_completed, completed_at) VALUES (35, 13, 9, '2025-06-03 05:27:14.095841', 1, '2025-06-03 05:27:16.452910');
INSERT INTO user_daily_task_assignments (id, user_id, task_id, assigned_date, is_completed, completed_at) VALUES (36, 13, 4, '2025-06-03 05:27:16.464192', 1, '2025-06-03 05:31:02.665733');
INSERT INTO user_daily_task_assignments (id, user_id, task_id, assigned_date, is_completed, completed_at) VALUES (37, 13, 23, '2025-06-03 05:31:02.871134', 0, NULL);
INSERT INTO user_daily_task_assignments (id, user_id, task_id, assigned_date, is_completed, completed_at) VALUES (38, 10, 19, '2025-06-03 09:14:16.043954', 0, NULL);

-- Данные для таблицы learning_materials
DELETE FROM learning_materials;
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (3, 'Эффективная коммуникация', 'Изучите основы эффективного общения в команде', 'VIDEO', 'COMMUNICATION', 'BEGINNER', 15, 'Маргулан Жанкожа', '## Введение

Эффективная коммуникация является основой успешной работы в команде.

### Ключевые принципы

1. **Активное слушание** - внимательно слушайте собеседника
2. **Ясность изложения** - выражайте мысли четко и понятно
3. **Эмпатия** - понимайте точку зрения других

### Практические советы

- Используйте "Я-высказывания" вместо обвинений
- Задавайте открытые вопросы
- Подтверждайте понимание перефразированием

## Заключение

Применяя эти принципы, вы значительно улучшите качество коммуникации в команде.

## 📹 Видео к уроку

**Профессиональный урок об основах деловой коммуникации. Изучите ключевые принципы эффективного общения в бизнес-среде.**

🔗 **Ссылка на видео:** https://www.youtube.com/watch?v=Nu9uvs2UeaM

### Что вы узнаете из видео:
- Практические техники и методы
- Реальные примеры применения
- Экспертные советы и рекомендации
- Дополнительные инсайты по теме урока

*Рекомендуется просмотреть видео после изучения теоретического материала для закрепления знаний.*
', 'https://www.youtube.com/watch?v=Nu9uvs2UeaM', 'Nu9uvs2UeaM', 'https://example.com/communication-guide', 1, '2025-06-01 15:16:29', '2025-06-02 09:40:08');
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (4, 'Управление временем и приоритетами', 'Изучите техники планирования, методы расстановки приоритетов и борьбы с прокрастинацией', 'ARTICLE', 'TIME_MANAGEMENT', 'BEGINNER', 12, 'Михаил Иванов', '# Управление временем и приоритетами

## Основы тайм-менеджмента

Эффективное управление временем — ключевой навык для достижения успеха в любой сфере деятельности.

### Принципы эффективного планирования

1. **Правило 80/20 (Принцип Парето)**
   - 80% результатов достигается за счет 20% усилий
   - Сосредоточьтесь на наиболее важных задачах
   - Определите свои ключевые действия

2. **Техника Pomodoro**
   - Работайте блоками по 25 минут
   - Делайте перерывы по 5 минут
   - Каждые 4 блока — длинный перерыв 15-30 минут

3. **Метод GTD (Getting Things Done)**
   - Запишите все задачи
   - Обработайте каждую задачу
   - Организуйте по категориям
   - Регулярно просматривайте список

### Борьба с прокрастинацией

**Причины прокрастинации:**
- Страх неудачи
- Перфекционизм
- Отсутствие мотивации
- Overwhelm (перегрузка задачами)

**Методы борьбы:**
- Разбивайте большие задачи на маленькие
- Используйте технику "съесть лягушку" — делайте сложное утром
- Создавайте дедлайны и придерживайтесь их
- Награждайте себя за выполнение задач

### Инструменты планирования

- **Календари**: Google Calendar, Outlook
- **Таск-менеджеры**: Todoist, Notion, Trello
- **Техники**: Bullet Journal, Канбан-доски
', '', '', 'https://todoist.com/productivity-methods', 1, '2025-06-01 20:21:21', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (5, 'Эмоциональный интеллект в работе', 'Развитие навыков распознавания эмоций, управления стрессом и построения эмпатических отношений', 'VIDEO', 'EMOTIONAL_INTELLIGENCE', 'INTERMEDIATE', 18, 'Анна Смирнова', '# Эмоциональный интеллект в рабочей среде

## Что такое эмоциональный интеллект?

Эмоциональный интеллект (EQ) — способность понимать, управлять и эффективно использовать эмоции в общении с другими людьми.

### Четыре компонента EQ

1. **Самосознание**
   - Понимание своих эмоций
   - Осознание сильных и слабых сторон
   - Уверенность в себе

2. **Самоуправление**
   - Эмоциональный самоконтроль
   - Адаптивность
   - Мотивация достижения

3. **Социальное сознание**
   - Эмпатия
   - Организационная осведомленность
   - Ориентация на сервис

4. **Управление отношениями**
   - Влияние
   - Коучинг и наставничество
   - Управление конфликтами
   - Командное лидерство

### Развитие эмпатии

**Техники активной эмпатии:**
- Слушайте не только слова, но и эмоции
- Задавайте уточняющие вопросы
- Отражайте чувства собеседника
- Избегайте немедленных советов

### Управление стрессом

**Признаки стресса:**
- Физические: головная боль, усталость
- Эмоциональные: раздражительность, тревога
- Поведенческие: избегание, прокрастинация

**Техники снижения стресса:**
- Дыхательные упражнения
- Медитация и майндфулнес
- Физическая активность
- Техники релаксации

### Эмоциональная грамотность в команде

- Создавайте психологически безопасную среду
- Поощряйте открытое выражение эмоций
- Обучайте команду техникам эмоциональной регуляции
- Регулярно проводите эмоциональный чек-ин
', 'https://www.youtube.com/watch?v=Y7m9eNoB3NU', 'Y7m9eNoB3NU', 'https://hbr.org/topic/emotional-intelligence', 1, '2025-06-01 20:21:21', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (6, 'Построение эффективной команды', 'Принципы командной работы, роли в команде, разрешение конфликтов и создание синергии', 'TUTORIAL', 'TEAMWORK', 'INTERMEDIATE', 22, 'Дмитрий Козлов', '# Построение эффективной команды

## Стадии развития команды

### Модель Такмана (Forming-Storming-Norming-Performing)

1. **Формирование (Forming)**
   - Знакомство участников
   - Определение целей
   - Установление правил
   - Высокая зависимость от лидера

2. **Штурм (Storming)**
   - Конфликты и разногласия
   - Борьба за власть
   - Сопротивление задачам
   - Критический этап

3. **Нормирование (Norming)**
   - Установление норм
   - Развитие сплоченности
   - Принятие ролей
   - Улучшение коммуникации

4. **Продуктивность (Performing)**
   - Высокая эффективность
   - Взаимозависимость
   - Фокус на результате
   - Самоуправление

### Роли в команде по Белбину

**Мыслительные роли:**
- **Генератор идей** — креативность и инновации
- **Аналитик** — логический анализ и оценка
- **Специалист** — глубокие знания в области

**Социальные роли:**
- **Координатор** — направляет усилия команды
- **Вдохновитель** — мотивирует и влияет
- **Исследователь** — ищет внешние возможности

**Деятельные роли:**
- **Реализатор** — превращает идеи в действия
- **Доводчик** — обеспечивает качество
- **Снабженец** — решает проблемы

### Принципы эффективной командной работы

1. **Общая цель**
   - Четко сформулированная миссия
   - Измеримые результаты
   - Понимание вклада каждого

2. **Психологическая безопасность**
   - Право на ошибку
   - Открытое выражение мнений
   - Взаимное уважение

3. **Взаимозависимость**
   - Понимание важности каждого
   - Координация усилий
   - Взаимная поддержка

### Управление конфликтами

**Типы конфликтов:**
- Конфликт задач (что делать)
- Конфликт процессов (как делать)
- Конфликт отношений (личностные противоречия)

**Стратегии разрешения:**
- Сотрудничество — поиск win-win решений
- Компромисс — взаимные уступки
- Приспособление — уступка одной стороны
- Соперничество — принуждение
- Избегание — уход от конфликта

### Инструменты командной работы

- **Ретроспективы** — анализ работы команды
- **Планирование** — совместное планирование спринтов
- **Стендапы** — ежедневные синхронизации
- **Team building** — мероприятия для сплочения
', '', '', 'https://www.belbin.com/about/belbin-team-roles', 1, '2025-06-01 20:21:21', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (7, 'Продвинутые техники презентаций', 'Мастерство публичных выступлений, сторителлинг и работа с аудиторией', 'VIDEO', 'COMMUNICATION', 'ADVANCED', 25, 'Елена Петрова', '# Мастерство презентаций и публичных выступлений

## Структура эффективной презентации

### Правило пирамиды Минто

1. **Начните с выводов**
   - Главная идея в начале
   - Поддерживающие аргументы
   - Детали и примеры

2. **Группировка аргументов**
   - Логические группы по 3-7 элементов
   - Взаимоисключающие и исчерпывающие (MECE)
   - Порядок по важности

### Техники сторителлинга

**Структура истории:**
- **Герой** — с кем аудитория может идентифицироваться
- **Конфликт** — проблема, которую нужно решить
- **Разрешение** — как проблема была решена
- **Урок** — что можно извлечь из истории

**Типы историй для бизнеса:**
- История основания компании
- Кейс клиента
- Личный опыт неудачи и обучения
- Видение будущего

### Работа с аудиторией

**Анализ аудитории:**
- Демографические характеристики
- Уровень знаний по теме
- Мотивация и интересы
- Ожидания от презентации

**Техники вовлечения:**
- Интерактивные опросы
- Риторические вопросы
- Упражнения в малых группах
- Использование реальных примеров

### Невербальная коммуникация

**Язык тела:**
- Открытая поза
- Зрительный контакт с аудиторией
- Жестикуляция для подчеркивания
- Движение по сцене

**Голос и речь:**
- Вариация темпа и тона
- Паузы для акцента
- Четкая артикуляция
- Проекция голоса

### Визуальное оформление

**Принципы дизайна слайдов:**
- Правило 6x6 (максимум 6 строк, 6 слов)
- Использование визуальных метафор
- Контрастные цвета
- Единый стиль

**Типы визуализации данных:**
- Графики для трендов
- Диаграммы для сравнения
- Схемы для процессов
- Изображения для эмоций

### Работа с возражениями и вопросами

**Подготовка к Q&A:**
- Предвосхищение возможных вопросов
- Подготовка кратких и четких ответов
- Использование техники "мост" для перенаправления

**Типы сложных вопросов:**
- Агрессивные вопросы
- Вопросы вне темы
- Вопросы, на которые нет ответа
- Многосоставные вопросы
', 'https://www.youtube.com/watch?v=Unzc731iCUY', 'Unzc731iCUY', 'https://www.ted.com/talks', 1, '2025-06-01 20:21:21', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (8, 'Стратегическое мышление руководителя', 'Развитие навыков системного анализа, долгосрочного планирования и принятия стратегических решений', 'ARTICLE', 'LEADERSHIP', 'ADVANCED', 30, 'Игорь Волков', '# Стратегическое мышление руководителя

## Основы стратегического мышления

### Характеристики стратегического мыслителя

1. **Системность**
   - Видение взаимосвязей между элементами
   - Понимание влияния изменений на всю систему
   - Холистический подход к проблемам

2. **Долгосрочная перспектива**
   - Планирование на 3-5 лет вперед
   - Понимание трендов и циклов
   - Баланс между краткосрочными и долгосрочными целями

3. **Концептуальное мышление**
   - Работа с абстрактными понятиями
   - Создание ментальных моделей
   - Синтез информации из разных источников

### Инструменты стратегического анализа

**SWOT-анализ:**
- **Strengths** — сильные стороны
- **Weaknesses** — слабые стороны  
- **Opportunities** — возможности
- **Threats** — угрозы

**Анализ пяти сил Портера:**
1. Конкуренция в отрасли
2. Угроза новых игроков
3. Угроза замещающих продуктов
4. Переговорная сила поставщиков
5. Переговорная сила покупателей

**PESTEL-анализ:**
- **Political** — политические факторы
- **Economic** — экономические факторы
- **Social** — социальные факторы
- **Technological** — технологические факторы
- **Environmental** — экологические факторы
- **Legal** — правовые факторы

### Процесс стратегического планирования

1. **Анализ текущей ситуации**
   - Внутренний аудит ресурсов
   - Анализ внешней среды
   - Оценка конкурентной позиции

2. **Формулирование стратегии**
   - Определение миссии и видения
   - Постановка стратегических целей
   - Выбор стратегических инициатив

3. **Реализация стратегии**
   - Разработка операционных планов
   - Распределение ресурсов
   - Создание системы мотивации

4. **Контроль и корректировка**
   - Ключевые показатели эффективности (KPI)
   - Регулярный мониторинг прогресса
   - Адаптация к изменениям

### Принятие стратегических решений

**Модель рационального принятия решений:**
1. Определение проблемы
2. Сбор информации
3. Генерация альтернатив
4. Оценка альтернатив
5. Выбор решения
6. Реализация
7. Оценка результатов

**Учет неопределенности:**
- Сценарное планирование
- Анализ чувствительности
- Опционный подход
- Итеративное планирование

### Развитие стратегического мышления

**Практические упражнения:**
- Анализ кейсов успешных компаний
- Изучение отраслевых трендов
- Участие в стратегических сессиях
- Ментoring от опытных руководителей

**Инструменты развития:**
- Чтение бизнес-литературы
- Участие в конференциях
- Обучение в бизнес-школах
- Нетворкинг с коллегами

### Барьеры стратегического мышления

- Когнитивные искажения
- Операционная загруженность
- Корпоративная культура
- Недостаток информации
- Сопротивление изменениям
', '', '', 'https://hbr.org/topic/strategy', 1, '2025-06-01 20:21:21', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (9, 'Креативное решение проблем', 'Методы генерации идей, латеральное мышление и инновационные подходы к решению задач', 'TUTORIAL', 'PROBLEM_SOLVING', 'INTERMEDIATE', 20, 'Мария Новикова', '# Креативное решение проблем

## Основы креативного мышления

### Типы мышления

1. **Конвергентное мышление**
   - Логический анализ
   - Поиск правильного ответа
   - Использование известных методов

2. **Дивергентное мышление**
   - Генерация множества идей
   - Нестандартные подходы
   - Создание новых связей

### Препятствия для креативности

**Ментальные блоки:**
- Функциональная фиксированность
- Экспертный блок
- Страх критики
- Стремление к перфекционизму

**Организационные барьеры:**
- Жесткие процедуры
- Культура избегания рисков
- Недостаток времени
- Отсутствие поощрения инноваций

### Техники генерации идей

**Классический мозговой штурм:**
1. Четкая формулировка задачи
2. Отложенная критика
3. Стремление к количеству
4. Развитие идей других
5. Поощрение необычных идей

**Метод 6 шляп де Боно:**
- **Белая шляпа** — факты и информация
- **Красная шляпа** — эмоции и интуиция
- **Черная шляпа** — критика и осторожность
- **Желтая шляпа** — оптимизм и выгоды
- **Зеленая шляпа** — креативность и альтернативы
- **Синяя шляпа** — контроль процесса

**SCAMPER техника:**
- **S**ubstitute — заменить
- **C**ombine — объединить
- **A**dapt — адаптировать
- **M**odify — модифицировать
- **P**ut to other uses — использовать по-другому
- **E**liminate — исключить
- **R**everse — изменить порядок

### Латеральное мышление

**Принципы Эдварда де Боно:**
- Прерывание шаблонов мышления
- Использование случайных стимулов
- Провокационные операции
- Альтернативы как инструмент

**Техники латерального мышления:**
- Случайное слово
- Провокация
- Концептуальная экстракция
- Reverse assumption

### Дизайн-мышление (Design Thinking)

**Этапы процесса:**
1. **Эмпатия** — понимание пользователя
2. **Определение** — формулировка проблемы
3. **Идеация** — генерация идей
4. **Прототипирование** — создание решений
5. **Тестирование** — проверка гипотез

### Инструменты структурирования идей

**Mind Mapping:**
- Центральная тема в центре
- Ассоциативные ветки
- Использование цветов и изображений
- Нелинейная структура

**Морфологический анализ:**
- Выделение параметров задачи
- Определение возможных значений
- Систематический перебор комбинаций
- Поиск неожиданных решений

### Оценка и развитие идей

**Критерии оценки:**
- Новизна и оригинальность
- Практичность реализации
- Потенциальная эффективность
- Соответствие ресурсам

**Методы развития идей:**
- Построение на идеях других
- Комбинирование элементов
- Адаптация к новым условиям
- Масштабирование решения
', '', '', 'https://www.ideou.com/pages/design-thinking', 1, '2025-06-01 20:21:21', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (10, 'Основы делегирования', 'Эффективное распределение задач, развитие команды через делегирование и контроль результатов', 'ARTICLE', 'LEADERSHIP', 'BEGINNER', 15, 'Сергей Морозов', '# Основы эффективного делегирования

## Что такое делегирование?

Делегирование — это передача полномочий и ответственности за выполнение определенных задач от руководителя к подчиненному.

### Преимущества делегирования

**Для руководителя:**
- Освобождение времени для стратегических задач
- Возможность сосредоточиться на приоритетах
- Развитие управленческих навыков
- Снижение уровня стресса

**Для подчиненных:**
- Профессиональное развитие
- Повышение мотивации
- Расширение компетенций
- Подготовка к карьерному росту

**Для организации:**
- Повышение эффективности
- Развитие кадрового резерва
- Улучшение качества решений
- Увеличение гибкости

### Принципы эффективного делегирования

1. **Четкость задач**
   - Конкретное описание результата
   - Сроки выполнения
   - Доступные ресурсы
   - Критерии успеха

2. **Соответствие компетенциям**
   - Оценка навыков сотрудника
   - Постепенное усложнение задач
   - Баланс вызова и возможностей
   - Учет мотивации

3. **Передача полномочий**
   - Предоставление необходимых прав
   - Доступ к информации
   - Возможность принимать решения
   - Поддержка со стороны команды

### Что можно и нельзя делегировать

**Можно делегировать:**
- Рутинные операционные задачи
- Специализированную работу
- Проекты развития
- Подготовительную работу

**Нельзя делегировать:**
- Стратегическое планирование
- Оценку персонала
- Конфиденциальные вопросы
- Кризисные ситуации
- Задачи, требующие специфической экспертизы

### Модель RACI

**Матрица ответственности:**
- **R** (Responsible) — исполнитель
- **A** (Accountable) — ответственный
- **C** (Consulted) — консультант
- **I** (Informed) — информируемый

### Процесс делегирования

1. **Подготовка**
   - Анализ задачи
   - Выбор исполнителя
   - Планирование ресурсов

2. **Постановка задачи**
   - Объяснение контекста
   - Описание ожидаемого результата
   - Обсуждение методов
   - Установление контрольных точек

3. **Поддержка выполнения**
   - Регулярные check-in''ы
   - Консультации по запросу
   - Предоставление ресурсов
   - Корректировка при необходимости

4. **Контроль и обратная связь**
   - Проверка промежуточных результатов
   - Конструктивная обратная связь
   - Признание достижений
   - Анализ уроков

### Типичные ошибки в делегировании

**Недостаточное делегирование:**
- Страх потери контроля
- Недоверие к команде
- Убеждение "быстрее сделать самому"
- Желание быть незаменимым

**Избыточное делегирование:**
- Передача задач без поддержки
- Делегирование неподходящих задач
- Отсутствие контроля
- Снятие с себя ответственности

### Развитие навыков делегирования

**Практические шаги:**
- Начинайте с малых задач
- Постепенно увеличивайте сложность
- Изучайте сильные стороны команды
- Развивайте доверие

**Инструменты:**
- Чек-листы для постановки задач
- Шаблоны брифов
- Системы tracking''а прогресса
- Регулярные one-on-one встречи
', '', '', 'https://www.mindtools.com/pages/article/newLDR_98.htm', 1, '2025-06-01 20:21:21', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (11, 'Техники активного слушания', 'Развитие навыков внимательного восприятия, эмпатического слушания и конструктивного диалога', 'VIDEO', 'COMMUNICATION', 'BEGINNER', 14, 'Ольга Семенова', '# Техники активного слушания

## Основы активного слушания

Активное слушание — это навык полного погружения в процесс восприятия информации от собеседника с целью максимального понимания как содержания, так и эмоций.

### Уровни слушания

1. **Внутреннее слушание**
   - Фокус на собственных мыслях
   - Подготовка ответа во время речи собеседника
   - Оценочные суждения

2. **Фокусированное слушание**
   - Концентрация на словах собеседника
   - Понимание содержания
   - Минимальные внутренние отвлечения

3. **Глобальное слушание**
   - Восприятие всех сигналов
   - Внимание к эмоциям и энергии
   - Интуитивное понимание

### Техники активного слушания

**Парафраз (Перефразирование):**
- Повторение услышанного своими словами
- Проверка понимания
- Пример: "Если я правильно понял, вы говорите о..."

**Отражение чувств:**
- Озвучивание эмоционального состояния
- Демонстрация эмпатии
- Пример: "Я вижу, что вы расстроены этой ситуацией"

**Уточнение:**
- Открытые вопросы для получения деталей
- Избегание предположений
- Пример: "Можете ли вы рассказать больше о..."

**Резюмирование:**
- Обобщение ключевых моментов
- Структурирование информации
- Пример: "Итак, основные моменты..."

### Невербальные сигналы

**Поза и жесты:**
- Открытая поза тела
- Наклон к собеседнику
- Зрительный контакт
- Кивки головой

**Мимика:**
- Соответствующее выражение лица
- Отражение эмоций собеседника
- Искренность в выражениях

**Голосовые сигналы:**
- Тон голоса
- Скорость речи
- Паузы
- Интонации

### Препятствия для активного слушания

**Внутренние барьеры:**
- Предварительные суждения
- Эмоциональные реакции
- Отвлечение на собственные мысли
- Подготовка возражений

**Внешние факторы:**
- Шум и отвлекающие факторы
- Временные ограничения
- Неподходящая обстановка
- Технические помехи

### Эмпатическое слушание

**Принципы эмпатии:**
- Понимание без оценки
- Принятие чувств собеседника
- Сопереживание
- Поддержка

**Техники развития эмпатии:**
- Постановка себя на место другого
- Внимание к эмоциональным сигналам
- Отложение собственных суждений
- Создание безопасного пространства

### Активное слушание в конфликтах

**Деэскалация:**
- Спокойный тон голоса
- Признание чувств сторон
- Поиск общих интересов
- Фокус на фактах

**Медиация:**
- Нейтральная позиция
- Равное время для каждой стороны
- Структурирование диалога
- Поиск решений

### Практические упражнения

**Упражнение "Зеркало":**
- Повторение последних слов собеседника
- Отражение тона и эмоций
- Проверка понимания

**Упражнение "Три уровня":**
- Слушание фактов (что говорится)
- Слушание эмоций (как говорится)
- Слушание потребностей (зачем говорится)

### Развитие навыков

**Ежедневная практика:**
- Сосредоточенное слушание в каждом разговоре
- Отключение электронных устройств
- Задавание открытых вопросов
- Благодарность за откровенность


## 📹 Видео к уроку

**Практический урок о техниках активного слушания. Научитесь лучше понимать собеседника и выстраивать доверительные отношения.**

🔗 **Ссылка на видео:** https://www.youtube.com/watch?v=QWvijbXrCCQ

### Что вы узнаете из видео:
- Практические техники и методы
- Реальные примеры применения
- Экспертные советы и рекомендации
- Дополнительные инсайты по теме урока

*Рекомендуется просмотреть видео после изучения теоретического материала для закрепления знаний.*
', 'https://www.youtube.com/watch?v=QWvijbXrCCQ', 'QWvijbXrCCQ', 'https://www.ccl.org/articles/leading-effectively-articles/coaching-others-use-active-listening-skills/', 1, '2025-06-01 20:21:21', '2025-06-02 09:40:08');
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (12, 'Продвинутое планирование проектов', 'Методологии управления проектами, agile подходы, планирование ресурсов и управление рисками', 'TUTORIAL', 'TIME_MANAGEMENT', 'ADVANCED', 35, 'Алексей Петров', '# Продвинутое планирование проектов

## Методологии управления проектами

### Waterfall (Каскадная модель)

**Фазы разработки:**
1. Анализ требований
2. Проектирование
3. Реализация
4. Тестирование
5. Внедрение
6. Поддержка

**Преимущества:**
- Четкая структура
- Предсказуемость сроков
- Подробная документация
- Легкость контроля

**Недостатки:**
- Низкая гибкость
- Поздняя обратная связь
- Риск устаревания требований

### Agile методологии

**Принципы Agile:**
- Люди важнее процессов
- Работающий продукт важнее документации
- Сотрудничество с заказчиком важнее контрактов
- Готовность к изменениям важнее следования плану

**Scrum фреймворк:**
- **Sprint** — итерация 1-4 недели
- **Product Backlog** — список требований
- **Sprint Backlog** — задачи спринта
- **Daily Standup** — ежедневные синхронизации
- **Sprint Review** — демонстрация результатов
- **Retrospective** — анализ процессов

**Kanban метод:**
- Визуализация рабочего процесса
- Ограничение работы в процессе (WIP)
- Управление потоком задач
- Непрерывное улучшение

### Планирование ресурсов

**Типы ресурсов:**
- Человеческие ресурсы
- Материальные ресурсы
- Финансовые ресурсы
- Временные ресурсы
- Информационные ресурсы

**Техники планирования:**
- Resource leveling — выравнивание ресурсов
- Resource smoothing — сглаживание ресурсов
- Critical chain method — управление критической цепью
- Monte Carlo simulation — вероятностное моделирование

### Управление рисками

**Процесс управления рисками:**
1. **Идентификация рисков**
   - Brainstorming
   - Checklists
   - Интервью с экспертами
   - SWOT анализ

2. **Качественная оценка**
   - Вероятность возникновения
   - Влияние на проект
   - Матрица вероятность/влияние

3. **Количественная оценка**
   - Expected Monetary Value (EMV)
   - Анализ чувствительности
   - Дерево решений

4. **Планирование реагирования**
   - Избежание риска
   - Передача риска
   - Снижение риска
   - Принятие риска

### Work Breakdown Structure (WBS)

**Принципы декомпозиции:**
- Иерархическая структура
- Взаимоисключающие элементы
- Измеримые результаты
- Правило 8/80 часов

**Типы WBS:**
- По продукту (deliverable-oriented)
- По фазам (phase-oriented)
- Гибридный подход

### Планирование расписания

**Техники сетевого планирования:**
- Critical Path Method (CPM)
- Program Evaluation and Review Technique (PERT)
- Precedence Diagramming Method (PDM)

**Оценка длительности:**
- Аналогичная оценка
- Параметрическая оценка
- Трехточечная оценка
- Bottom-up estimating

### Инструменты планирования

**Диаграммы Гранта:**
- Временная шкала проекта
- Зависимости между задачами
- Критический путь
- Загрузка ресурсов

**Agile инструменты:**
- User Stories
- Planning Poker
- Burndown Charts
- Velocity tracking

### Контроль исполнения

**Earned Value Management (EVM):**
- Planned Value (PV) — плановая стоимость
- Earned Value (EV) — освоенный объем
- Actual Cost (AC) — фактическая стоимость

**Ключевые метрики:**
- Schedule Performance Index (SPI)
- Cost Performance Index (CPI)
- Estimate at Completion (EAC)
- Estimate to Complete (ETC)

### Управление изменениями

**Процесс управления изменениями:**
1. Запрос на изменение
2. Анализ влияния
3. Одобрение/отклонение
4. Реализация изменения
5. Верификация результата

**Change Control Board (CCB):**
- Состав комиссии
- Процедуры принятия решений
- Критерии оценки
- Документооборот

### Коммуникации в проекте

**План коммуникаций:**
- Заинтересованные стороны
- Информационные потребности
- Методы коммуникации
- Частота и формат отчетности

**Инструменты коммуникации:**
- Status reports
- Dashboard
- Stakeholder meetings
- Project website
', '', '', 'https://www.pmi.org/learning/library', 1, '2025-06-01 20:21:21', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (21, 'Основы планирования времени', 'Принципы эффективного планирования и постановки приоритетов', 'video', 'time_management', 'beginner', 16, NULL, '# Основы планирования времени

## Принципы тайм-менеджмента
1. **Планирование** - основа эффективности
2. **Приоритизация** - важное vs срочное
3. **Фокус** - одна задача за раз
4. **Отдых** - восстановление энергии

## Матрица Эйзенхауэра
### Квадрант 1: Важное + Срочное
- Кризисы и чрезвычайные ситуации
- Действовать немедленно

### Квадрант 2: Важное + Несрочное
- Планирование и профилактика
- Инвестировать время

### Квадрант 3: Неважное + Срочное
- Отвлекающие звонки и письма
- Делегировать

### Квадрант 4: Неважное + Несрочное
- Пустая трата времени
- Исключать

## Техники планирования
- Правило 80/20 (Парето)
- Метод SMART для целей
- Временные блоки
- Еженедельное планирование', 'https://www.youtube.com/watch?v=R-Q8TeOMev0', 'R-Q8TeOMev0', NULL, 1, '2025-06-02T04:00:44.512505', '2025-06-02T04:00:44.512505');
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (22, 'Техники концентрации', 'Методы повышения продуктивности и борьбы с отвлечениями', 'video', 'time_management', 'beginner', 18, NULL, '# Техники концентрации

## Техника Помодоро
1. 25 минут сосредоточенной работы
2. 5 минут короткий перерыв
3. После 4 циклов - длинный перерыв 15-30 минут

## Принципы deep work
- Исключение отвлечений
- Глубокое погружение
- Качество > количество
- Развитие навыка концентрации

## Борьба с отвлечениями
### Внешние:
- Уведомления телефона/компьютера
- Шум в офисе
- Прерывания коллег

### Внутренние:
- Тревожные мысли
- Многозадачность
- Прокрастинация

## Создание среды для концентрации
- Организованное рабочее место
- Минимум визуальных отвлечений
- Комфортная температура
- Правильное освещение', 'https://www.youtube.com/watch?v=sUwyjmrbt2E', 'sUwyjmrbt2E', NULL, 1, '2025-06-02T04:00:44.512520', '2025-06-02T04:00:44.512521');
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (23, 'Делегирование и автоматизация', 'Способы освобождения времени через делегирование и автоматизацию', 'video', 'time_management', 'beginner', 20, NULL, '# Делегирование и автоматизация

## Принцип делегирования времени
Если задачу может выполнить кто-то другой за 80% качества, лучше делегировать

## Что автоматизировать:
1. **Рутинные процессы**
   - Обработка email
   - Планирование встреч
   - Отчеты

2. **Повторяющиеся задачи**
   - Создание документов
   - Обновление данных
   - Коммуникация

## Инструменты автоматизации
- Email фильтры и шаблоны
- Календарные автоматизации
- CRM системы
- Макросы и скрипты

## Делегирование vs контроль
- Четкие инструкции
- Контрольные точки
- Обучение исполнителей
- Доверие процессу', 'https://www.youtube.com/watch?v=bsMdUVcCNEg', 'bsMdUVcCNEg', NULL, 1, '2025-06-02T04:00:44.512537', '2025-06-02T04:00:44.512538');
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (24, 'Введение в эффективную коммуникацию', 'Основы коммуникации, типы общения и их важность в профессиональной деятельности', 'VIDEO', 'COMMUNICATION', 'BEGINNER', 45, 'AI Assistant', '
# Введение в эффективную коммуникацию

## Что такое коммуникация?

Коммуникация — это процесс передачи информации между людьми с помощью слов, жестов, мимики и других способов.

### Основные элементы коммуникации:
- **Отправитель** — тот, кто передает сообщение
- **Сообщение** — информация, которую передают
- **Получатель** — тот, кто принимает сообщение
- **Канал связи** — способ передачи (устная речь, письмо, жесты)
- **Обратная связь** — реакция получателя на сообщение

## Типы коммуникации

### 1. Вербальная коммуникация
Общение с помощью слов (устно или письменно)

### 2. Невербальная коммуникация
- Мимика и жесты
- Интонация голоса
- Поза тела
- Зрительный контакт

### 3. Письменная коммуникация
Электронная почта, отчеты, презентации
        

## 📹 Видео к уроку

**Вводное видео о культуре речи и деловом общении. Основы профессиональной коммуникации на русском языке.**

🔗 **Ссылка на видео:** https://www.youtube.com/watch?v=U0PC37rubQ0

### Что вы узнаете из видео:
- Практические техники и методы
- Реальные примеры применения
- Экспертные советы и рекомендации
- Дополнительные инсайты по теме урока

*Рекомендуется просмотреть видео после изучения теоретического материала для закрепления знаний.*
', 'https://www.youtube.com/watch?v=U0PC37rubQ0', 'U0PC37rubQ0', NULL, 1, '2025-06-02 08:35:10', '2025-06-02 09:40:08');
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (25, 'Активное слушание и эмпатия', 'Техники активного слушания, развитие эмпатии и понимания собеседника', 'VIDEO', 'COMMUNICATION', 'BEGINNER', 50, 'AI Assistant', '
# Активное слушание и эмпатия

## Что такое активное слушание?

Активное слушание — это техника общения, при которой слушатель полностью сосредоточен на собеседнике.

### Принципы активного слушания:
1. **Полное внимание** — убираем отвлекающие факторы
2. **Не перебиваем** — даем возможность высказаться
3. **Задаем уточняющие вопросы**
4. **Перефразируем** сказанное для проверки понимания
5. **Показываем заинтересованность** кивками и короткими репликами

## Техники активного слушания

### 1. Перефразирование
"Если я правильно понял, вы имеете в виду..."

### 2. Резюмирование
"Итак, основные моменты..."

### 3. Эмоциональная поддержка
"Я понимаю, что это сложная ситуация"

## Развитие эмпатии

Эмпатия — способность понимать и разделять чувства другого человека.

### Как развить эмпатию:
- Ставьте себя на место собеседника
- Обращайте внимание на эмоции
- Не судите поспешно
- Задавайте открытые вопросы
        

## 📹 Видео к уроку

**Краткий, но содержательный урок о техниках активного слушания за 6 минут. Практические советы для улучшения навыков общения.**

🔗 **Ссылка на видео:** https://www.youtube.com/watch?v=SB5MMQcJ1YA

### Что вы узнаете из видео:
- Практические техники и методы
- Реальные примеры применения
- Экспертные советы и рекомендации
- Дополнительные инсайты по теме урока

*Рекомендуется просмотреть видео после изучения теоретического материала для закрепления знаний.*
', 'https://www.youtube.com/watch?v=SB5MMQcJ1YA', 'SB5MMQcJ1YA', NULL, 1, '2025-06-02 08:35:10', '2025-06-02 09:40:08');
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (26, 'Невербальная коммуникация и язык тела', 'Изучение жестов, мимики, позы и их влияния на восприятие собеседника', 'VIDEO', 'COMMUNICATION', 'BEGINNER', 40, 'AI Assistant', '
# Невербальная коммуникация и язык тела

## Важность невербального общения

По исследованиям, 55% информации передается через язык тела, 38% через интонацию и только 7% через слова.

### Основные элементы невербальной коммуникации:

#### 1. Мимика лица
- Улыбка создает доверие
- Нахмуренные брови — признак недовольства
- Поднятые брови — удивление или интерес

#### 2. Жесты рук
- Открытые ладони — честность
- Скрещенные руки — защитная позиция
- Указательный жест может восприниматься агрессивно

#### 3. Поза тела
- Прямая осанка — уверенность
- Наклон вперед — заинтересованность
- Отклонение назад — дистанцирование

#### 4. Зрительный контакт
- Поддержание контакта — внимание и уважение
- Избегание взгляда — неуверенность или обман
- Слишком пристальный взгляд — агрессия

## Культурные различия

Важно помнить, что жесты могут иметь разное значение в разных культурах.
        

## 📹 Видео к уроку

**Обучающее видео о невербальном общении и языке тела. Изучите секреты успешной коммуникации без слов.**

🔗 **Ссылка на видео:** https://www.youtube.com/watch?v=rYLfcUFZ8kQ

### Что вы узнаете из видео:
- Практические техники и методы
- Реальные примеры применения
- Экспертные советы и рекомендации
- Дополнительные инсайты по теме урока

*Рекомендуется просмотреть видео после изучения теоретического материала для закрепления знаний.*
', 'https://www.youtube.com/watch?v=rYLfcUFZ8kQ', 'rYLfcUFZ8kQ', NULL, 1, '2025-06-02 08:35:10', '2025-06-02 09:40:08');
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (27, 'Управление конфликтами в общении', 'Стратегии предотвращения и разрешения конфликтов, техники деэскалации', 'VIDEO', 'COMMUNICATION', 'BEGINNER', 55, 'AI Assistant', '
# Управление конфликтами в общении

## Типы конфликтов

### 1. Конфликт интересов
Когда стороны хотят разного результата

### 2. Конфликт ценностей
Разные взгляды на то, что правильно

### 3. Конфликт восприятия
Разная интерпретация одних и тех же фактов

## Стратегии разрешения конфликтов

### 1. Сотрудничество
Поиск решения, выгодного для всех сторон

### 2. Компромисс
Взаимные уступки

### 3. Приспособление
Уступка более важной стороне

### 4. Избегание
Временное откладывание решения

### 5. Соперничество
Настаивание на своем (крайняя мера)

## Техники деэскалации

1. **Слушайте активно** — дайте выговориться
2. **Признавайте эмоции** — "Я вижу, вы расстроены"
3. **Ищите общие интересы** — что объединяет
4. **Фокусируйтесь на проблеме**, а не на личности
5. **Предлагайте варианты** решения

## Модель WIN-WIN

Стремитесь к решениям, где выигрывают все стороны.
        

## 📹 Видео к уроку

**Практический урок по управлению конфликтами. Научитесь эффективно разрешать споры и выходить из сложных ситуаций.**

🔗 **Ссылка на видео:** https://www.youtube.com/watch?v=Qug4IStz4_Y

### Что вы узнаете из видео:
- Практические техники и методы
- Реальные примеры применения
- Экспертные советы и рекомендации
- Дополнительные инсайты по теме урока

*Рекомендуется просмотреть видео после изучения теоретического материала для закрепления знаний.*
', 'https://www.youtube.com/watch?v=Qug4IStz4_Y', 'Qug4IStz4_Y', NULL, 1, '2025-06-02 08:35:10', '2025-06-02 09:40:08');
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (28, 'Эффективная обратная связь', 'Как давать и принимать конструктивную обратную связь', 'VIDEO', 'COMMUNICATION', 'BEGINNER', 45, 'AI Assistant', '
# Эффективная обратная связь

## Что такое обратная связь?

Обратная связь — это информация о том, как ваши действия влияют на других и на результат работы.

## Принципы конструктивной обратной связи

### При ДАЧИ обратной связи:

#### 1. Модель SBI (Situation-Behavior-Impact)
- **Ситуация**: Опишите контекст
- **Поведение**: Что конкретно наблюдали
- **Влияние**: Как это повлияло на результат

#### 2. Будьте конкретными
❌ "Ты плохо работаешь"
✅ "В презентации не хватало данных о продажах"

#### 3. Фокус на поведении, не на личности
❌ "Ты безответственный"
✅ "Отчет был сдан с опозданием"

#### 4. Предлагайте решения
"В следующий раз можно добавить график с результатами"

### При ПОЛУЧЕНИИ обратной связи:

1. **Слушайте открыто** — не защищайтесь сразу
2. **Задавайте уточняющие вопросы**
3. **Благодарите** за информацию
4. **Планируйте улучшения**

## Модель GROW для развивающей обратной связи

- **Goal** — Какой цели хотим достичь?
- **Reality** — Что происходит сейчас?
- **Options** — Какие есть варианты?
- **Will** — Что будем делать?
        

## 📹 Видео к уроку

**Урок об эмоциональном интеллекте в коммуникации. Изучите основы управления эмоциями в процессе общения.**

🔗 **Ссылка на видео:** https://www.youtube.com/watch?v=fdUR9qYl7iU

### Что вы узнаете из видео:
- Практические техники и методы
- Реальные примеры применения
- Экспертные советы и рекомендации
- Дополнительные инсайты по теме урока

*Рекомендуется просмотреть видео после изучения теоретического материала для закрепления знаний.*
', 'https://www.youtube.com/watch?v=fdUR9qYl7iU', 'fdUR9qYl7iU', NULL, 1, '2025-06-02 08:35:10', '2025-06-02 09:40:08');
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (29, 'Презентационные навыки', 'Структура эффективной презентации, работа с аудиторией', 'VIDEO', 'COMMUNICATION', 'BEGINNER', 60, 'AI Assistant', '
# Презентационные навыки

## Структура эффективной презентации

### 1. Вступление (10-15%)
- Привлечение внимания
- Представление темы
- Анонс структуры

### 2. Основная часть (70-80%)
- 3-5 ключевых пунктов
- Аргументы и примеры
- Визуальная поддержка

### 3. Заключение (10-15%)
- Резюме ключевых моментов
- Призыв к действию
- Ответы на вопросы

## Правило 10/20/30

- **10 слайдов** максимум
- **20 минут** презентация
- **30 пунктов** шрифт минимум

## Работа с аудиторией

### До презентации:
- Изучите аудиторию
- Подготовьте ответы на возможные вопросы
- Проверьте технику

### Во время презентации:
- Поддерживайте зрительный контакт
- Используйте паузы
- Вовлекайте аудиторию вопросами
- Следите за реакцией

### Управление волнением:
1. Глубокое дыхание
2. Позитивная визуализация
3. Подготовка и репетиции
4. Фокус на сообщении, а не на себе

## Визуальные материалы

- Один слайд — одна идея
- Больше изображений, меньше текста
- Контрастные цвета
- Читаемые шрифты
        

## 📹 Видео к уроку

**Обучающее видео о навыках публичных выступлений. Научитесь уверенно выступать перед аудиторией.**

🔗 **Ссылка на видео:** https://www.youtube.com/watch?v=2HT59cO72xg

### Что вы узнаете из видео:
- Практические техники и методы
- Реальные примеры применения
- Экспертные советы и рекомендации
- Дополнительные инсайты по теме урока

*Рекомендуется просмотреть видео после изучения теоретического материала для закрепления знаний.*
', 'https://www.youtube.com/watch?v=2HT59cO72xg', '2HT59cO72xg', NULL, 1, '2025-06-02 08:35:10', '2025-06-02 09:40:08');
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (30, 'Цифровая коммуникация и этикет', 'Эффективное общение по email, в мессенджерах и видеоконференциях', 'VIDEO', 'COMMUNICATION', 'BEGINNER', 40, 'AI Assistant', '
# Цифровая коммуникация и этикет

## Email-этикет

### Структура эффективного письма:

#### 1. Тема письма
- Конкретная и информативная
- ✅ "Вопрос по проекту X — нужно решение до пятницы"
- ❌ "Важно!" или "Вопрос"

#### 2. Приветствие
- Формальное: "Уважаемый/ая [Имя]"
- Полуформальное: "Здравствуйте, [Имя]"
- Неформальное: "Привет, [Имя]"

#### 3. Основная часть
- Сначала контекст, потом детали
- Короткие абзацы
- Маркированные списки для перечислений

#### 4. Призыв к действию
- Четко указывайте, что нужно сделать
- Дедлайны и приоритеты

#### 5. Подпись
- Имя, должность, контакты

## Мессенджеры на работе

### Принципы:
- Уважайте рабочее время
- Используйте статусы доступности
- Групповые чаты — для общих вопросов
- Личные сообщения — для приватных тем

### Emoji и стикеры:
- Умеренно в рабочем контексте
- Помогают передать эмоции
- Не заменяют слова полностью

## Видеоконференции

### Технические аспекты:
- Проверьте связь заранее
- Хорошее освещение лица
- Нейтральный фон
- Качественный звук

### Этикет:
- Приходите вовремя
- Выключайте микрофон, когда не говорите
- Смотрите в камеру, а не на экран
- Одевайтесь профессионально
        

## 📹 Видео к уроку

**Урок о цифровом этикете и правилах вежливого общения онлайн. Изучите современные нормы сетевого этикета.**

🔗 **Ссылка на видео:** https://www.youtube.com/watch?v=bs6IALQmxYs

### Что вы узнаете из видео:
- Практические техники и методы
- Реальные примеры применения
- Экспертные советы и рекомендации
- Дополнительные инсайты по теме урока

*Рекомендуется просмотреть видео после изучения теоретического материала для закрепления знаний.*
', 'https://www.youtube.com/watch?v=bs6IALQmxYs', 'bs6IALQmxYs', NULL, 1, '2025-06-02 08:35:10', '2025-06-02 09:40:08');
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (31, 'Межкультурная коммуникация', 'Особенности общения в мультикультурной среде', 'VIDEO', 'COMMUNICATION', 'BEGINNER', 45, 'AI Assistant', '
# Межкультурная коммуникация

## Культурные измерения Хофстеде

### 1. Дистанция власти
- **Высокая**: четкая иерархия (Россия, Корея)
- **Низкая**: равенство в общении (Дания, Австралия)

### 2. Индивидуализм vs Коллективизм
- **Индивидуалистские**: США, Германия
- **Коллективистские**: Япония, Китай

### 3. Избегание неопределенности
- **Высокое**: четкие правила (Германия)
- **Низкое**: гибкость (США, Индия)

## Стили коммуникации

### Прямой vs Косвенный
- **Прямой**: говорят что думают (Германия, Нидерланды)
- **Косвенный**: намеки и контекст (Япония, Корея)

### Высококонтекстный vs Низкоконтекстный
- **Высокий контекст**: важна ситуация (Япония, Арабские страны)
- **Низкий контекст**: важны слова (Германия, США)

## Практические советы

### При работе с разными культурами:

1. **Изучите основы** культуры коллег
2. **Будьте терпеливы** к различиям
3. **Не обобщайте** — каждый человек уникален
4. **Уточняйте понимание** чаще
5. **Адаптируйте стиль** общения

### Невербальные различия:
- Зрительный контакт
- Личное пространство
- Жесты и их значения
- Отношение к времени

## Построение инклюзивной среды

- Избегайте культурных стереотипов
- Создавайте возможности для всех высказаться
- Учитывайте временные зоны при планировании
- Используйте простой и понятный язык
        

## 📹 Видео к уроку

**Образовательная программа о русском языке в культуре речи и деловом общении с представителями разных культур.**

🔗 **Ссылка на видео:** https://www.youtube.com/watch?v=YOkgQbJnB5A

### Что вы узнаете из видео:
- Практические техники и методы
- Реальные примеры применения
- Экспертные советы и рекомендации
- Дополнительные инсайты по теме урока

*Рекомендуется просмотреть видео после изучения теоретического материала для закрепления знаний.*
', 'https://www.youtube.com/watch?v=YOkgQbJnB5A', 'YOkgQbJnB5A', NULL, 1, '2025-06-02 08:35:10', '2025-06-02 09:40:08');
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (32, 'Эмоциональный интеллект в коммуникации', 'Понимание и управление эмоциями в профессиональном общении', 'VIDEO', 'COMMUNICATION', 'BEGINNER', 50, 'AI Assistant', '
# Эмоциональный интеллект в коммуникации

## Что такое эмоциональный интеллект?

EQ (Emotional Quotient) — способность понимать и управлять своими и чужими эмоциями.

## Четыре компонента EQ

### 1. Самосознание
- Понимание своих эмоций
- Знание своих сильных и слабых сторон
- Реалистичная самооценка

### 2. Саморегуляция
- Управление импульсами
- Адаптивность к изменениям
- Инициативность

### 3. Социальное понимание
- Эмпатия к другим
- Понимание организационной динамики
- Ориентация на сервис

### 4. Управление отношениями
- Влияние на других
- Лидерство
- Управление конфликтами
- Командная работа

## Эмоции в рабочей среде

### Позитивные эмоции:
- Энтузиазм — мотивирует команду
- Благодарность — укрепляет отношения
- Оптимизм — помогает в трудностях

### Сложные эмоции:
- Стресс — может снижать эффективность
- Фрустрация — требует конструктивного выхода
- Тревога — нужны техники успокоения

## Техники управления эмоциями

### 1. Техника STOP
- **S**top — остановитесь
- **T**ake a breath — сделайте вдох
- **O**bserve — понаблюдайте за эмоциями
- **P**roceed — действуйте осознанно

### 2. Переформулирование
Измените внутренний диалог:
❌ "Это катастрофа!"
✅ "Это вызов, который можно решить"

### 3. Техника 5-4-3-2-1
При стрессе назовите:
- 5 вещей, которые видите
- 4 вещи, которые слышите  
- 3 вещи, которые можете потрогать
- 2 запаха
- 1 вкус
        

## 📹 Видео к уроку

**Профессиональная лекция об основах эмоционального интеллекта. Развитие навыков управления эмоциями в общении.**

🔗 **Ссылка на видео:** https://www.youtube.com/watch?v=JJ6Pa83oW7w

### Что вы узнаете из видео:
- Практические техники и методы
- Реальные примеры применения
- Экспертные советы и рекомендации
- Дополнительные инсайты по теме урока

*Рекомендуется просмотреть видео после изучения теоретического материала для закрепления знаний.*
', 'https://www.youtube.com/watch?v=JJ6Pa83oW7w', 'JJ6Pa83oW7w', NULL, 1, '2025-06-02 08:35:10', '2025-06-02 09:40:08');
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (33, 'Практикум: Интеграция коммуникативных навыков', 'Практическое применение всех изученных навыков коммуникации в реальных ситуациях', 'VIDEO', 'COMMUNICATION', 'BEGINNER', 75, 'AI Assistant', '
# Практикум: Интеграция коммуникативных навыков

## Цель практикума

Объединить все изученные навыки коммуникации и применить их в комплексных сценариях.

## Ключевые навыки для интеграции

### 1. Активное слушание
- Техники SBI (Situation-Behavior-Impact)
- Эмпатическое понимание
- Парафразирование и резюмирование

### 2. Невербальная коммуникация
- Язык тела и жесты
- Зрительный контакт
- Управление пространством

### 3. Управление эмоциями
- Техника STOP
- Эмоциональная регуляция
- Конструктивное выражение чувств

### 4. Конфликт-менеджмент
- Деэскалация напряжения
- Поиск win-win решений
- Медиация между сторонами

## Практические сценарии

### Сценарий 1: Сложная презентация
**Ситуация**: Презентация проекта перед скептически настроенной аудиторией

**Применяемые навыки**:
- Структурирование информации
- Работа с возражениями
- Невербальная уверенность
- Адаптация к аудитории

### Сценарий 2: Командный конфликт
**Ситуация**: Конфликт между двумя коллегами влияет на работу команды

**Применяемые навыки**:
- Активное слушание всех сторон
- Эмоциональная регуляция
- Медиация и поиск компромиссов
- Обратная связь

### Сценарий 3: Межкультурная коммуникация
**Ситуация**: Работа с международной командой с разными культурными особенностями

**Применяемые навыки**:
- Культурная чувствительность
- Адаптация стиля общения
- Цифровая коммуникация
- Инклюзивность

## Модель GROW в действии

Для каждого сценария используйте модель GROW:

- **Goal** — Какой результат хотим достичь?
- **Reality** — Что происходит сейчас?
- **Options** — Какие у нас есть варианты?
- **Will** — Что конкретно будем делать?

## Самооценка и планирование развития

### Чек-лист коммуникативных навыков:

1. **Слушание** (1-10): ___
2. **Говорение** (1-10): ___
3. **Невербальное общение** (1-10): ___
4. **Управление конфликтами** (1-10): ___
5. **Обратная связь** (1-10): ___
6. **Презентации** (1-10): ___
7. **Цифровая коммуникация** (1-10): ___
8. **Межкультурное общение** (1-10): ___
9. **Эмоциональный интеллект** (1-10): ___

### План развития на 3 месяца:

**Цель 1**: (выберите 2-3 навыка для фокуса)
**Действия**: (конкретные шаги)
**Метрики**: (как измерить прогресс)

## Заключение

Эффективная коммуникация — это навык, который развивается постоянно. Продолжайте практиковаться и получать обратную связь!
    

## 📹 Видео к уроку

**Урок о различных видах публичных выступлений. Практическое применение всех изученных коммуникативных техник.**

🔗 **Ссылка на видео:** https://www.youtube.com/watch?v=hcAm5lyQVyk

### Что вы узнаете из видео:
- Практические техники и методы
- Реальные примеры применения
- Экспертные советы и рекомендации
- Дополнительные инсайты по теме урока

*Рекомендуется просмотреть видео после изучения теоретического материала для закрепления знаний.*
', 'https://www.youtube.com/watch?v=hcAm5lyQVyk', 'hcAm5lyQVyk', NULL, 1, '2025-06-02 08:36:46', '2025-06-02 09:40:08');
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (34, 'Основы лидерства: лидер vs менеджер', 'Различия между лидерством и менеджментом, ключевые качества лидера', 'VIDEO', 'LEADERSHIP', 'INTERMEDIATE', 45, 'AI Assistant', '
# Основы лидерства: лидер vs менеджер

## В чем разница?

### Лидер:
- **Вдохновляет** людей на достижение целей
- **Создает видение** будущего
- **Развивает** потенциал команды
- **Инициирует изменения**
- **Завоевывает доверие** личным примером

### Менеджер:
- **Управляет** процессами и ресурсами
- **Планирует** и контролирует выполнение
- **Организует** рабочие процессы
- **Поддерживает** стабильность
- **Использует** должностную власть

## 5 уровней лидерства по Джону Максвеллу

### Уровень 1: Позиция
Люди следуют за вами, потому что должны

### Уровень 2: Разрешение
Люди следуют за вами, потому что хотят

### Уровень 3: Производство
Люди следуют за вами из-за ваших результатов

### Уровень 4: Развитие людей
Люди следуют за вами из-за того, что вы для них сделали

### Уровень 5: Личность
Люди следуют за вами из-за того, кто вы есть

## Ключевые качества лидера

1. **Самосознание** — понимание своих сильных и слабых сторон
2. **Эмоциональный интеллект** — управление эмоциями
3. **Честность** — соответствие слов и дел
4. **Видение** — способность видеть будущее
5. **Коммуникация** — умение донести идеи
6. **Решительность** — готовность принимать решения
7. **Адаптивность** — гибкость в изменениях
        ', 'https://www.youtube.com/watch?v=_Yve-X0sQCM', '_Yve-X0sQCM', NULL, 1, '2025-06-02 08:47:29', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (35, 'Эмоциональный интеллект лидера', 'Развитие эмоционального интеллекта как основы эффективного лидерства', 'VIDEO', 'LEADERSHIP', 'INTERMEDIATE', 50, 'AI Assistant', '
# Эмоциональный интеллект лидера

## Модель EQ Даниэля Гоулмана

### 1. Самосознание
- **Эмоциональное самосознание**: понимание своих эмоций
- **Точная самооценка**: знание сильных и слабых сторон
- **Уверенность в себе**: здоровая самооценка

### 2. Саморегуляция
- **Эмоциональный самоконтроль**: управление деструктивными эмоциями
- **Адаптивность**: гибкость в изменениях
- **Ориентация на достижения**: стремление к совершенству
- **Позитивный настрой**: видение хорошего в людях и событиях

### 3. Социальное сознание
- **Эмпатия**: понимание эмоций других
- **Организационное сознание**: понимание политики и сетей
- **Ориентация на сервис**: предвосхищение потребностей клиентов

### 4. Управление отношениями
- **Влияние**: способность убеждать
- **Коуч и ментор**: помощь в развитии других
- **Управление конфликтами**: разрешение разногласий
- **Командное лидерство**: вдохновление команд

## Практические техники

### Управление собственными эмоциями:
1. **Пауза** — не реагируйте немедленно
2. **Дыхание** — глубокие вдохи успокаивают
3. **Переформулирование** — найдите позитивный взгляд
4. **Физическая активность** — снимает напряжение

### Работа с эмоциями команды:
1. **Наблюдение** — замечайте эмоциональные сигналы
2. **Признание** — "Я вижу, что вы расстроены"
3. **Исследование** — "Что вас беспокоит?"
4. **Поддержка** — "Как я могу помочь?"
        ', 'https://www.youtube.com/watch?v=RemJXW-jaz0', 'RemJXW-jaz0', NULL, 1, '2025-06-02 08:47:29', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (36, 'Стили лидерства и ситуационное лидерство', 'Различные стили лидерства и их применение в зависимости от ситуации', 'VIDEO', 'LEADERSHIP', 'INTERMEDIATE', 55, 'AI Assistant', '
# Стили лидерства и ситуационное лидерство

## Классические стили лидерства

### 1. Авторитарный (Директивный)
**Когда использовать**: Кризисы, новички, срочные задачи
- Лидер принимает решения единолично
- Четкие инструкции и контроль
- Быстрая реализация решений

### 2. Демократический (Партисипативный)
**Когда использовать**: Опытная команда, творческие задачи
- Участие команды в принятии решений
- Обсуждение и консенсус
- Высокая мотивация команды

### 3. Делегативный (Либеральный)
**Когда использовать**: Эксперты, самомотивированная команда
- Минимальное вмешательство лидера
- Команда сама принимает решения
- Лидер — координатор и ресурс

## Модель ситуационного лидерства Херси-Бланшара

### S1: Директивный стиль
- **Высокая задача + Низкие отношения**
- Для новичков (низкая компетентность + высокая мотивация)
- "Скажи что делать"

### S2: Коучинговый стиль  
- **Высокая задача + Высокие отношения**
- Для обучающихся (низкая компетентность + низкая мотивация)
- "Продай идею"

### S3: Поддерживающий стиль
- **Низкая задача + Высокие отношения**
- Для способных (высокая компетентность + низкая мотивация)
- "Участвуй в решении"

### S4: Делегирующий стиль
- **Низкая задача + Низкие отношения**
- Для экспертов (высокая компетентность + высокая мотивация)
- "Делегируй полномочия"

## Адаптивное лидерство

### Ключевые принципы:
1. **Диагностика ситуации** — оценка готовности команды
2. **Гибкость стиля** — адаптация под ситуацию
3. **Развитие команды** — постепенное повышение автономии
4. **Обратная связь** — корректировка подхода
        ', 'https://www.youtube.com/watch?v=04DfKSuhC-0', '04DfKSuhC-0', NULL, 1, '2025-06-02 08:47:33', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (37, 'Мотивация и вдохновение команды', 'Теории мотивации и практические техники вдохновения сотрудников', 'VIDEO', 'LEADERSHIP', 'INTERMEDIATE', 60, 'AI Assistant', '
# Мотивация и вдохновение команды

## Теории мотивации

### Пирамида потребностей Маслоу
1. **Физиологические** — зарплата, условия работы
2. **Безопасности** — стабильность, защищенность
3. **Социальные** — принадлежность к команде
4. **Уважения** — признание достижений
5. **Самоактуализации** — реализация потенциала

### Теория двух факторов Херцберга

#### Гигиенические факторы (предотвращают демотивацию):
- Зарплата и льготы
- Условия труда
- Политика компании
- Отношения с руководством

#### Мотивирующие факторы (создают мотивацию):
- Достижения и признание
- Интересная работа
- Ответственность
- Возможности роста

### Теория самодетерминации (SDT)
Три базовые потребности:
1. **Автономия** — чувство выбора и контроля
2. **Компетентность** — ощущение мастерства
3. **Связанность** — принадлежность к группе

## Практические техники мотивации

### 1. Персонализированный подход
- Изучите мотивы каждого сотрудника
- Адаптируйте задачи под их интересы
- Учитывайте жизненные цели

### 2. Постановка вдохновляющих целей
- **SMART + E** (Exciting) цели
- Связь с общей миссией
- Промежуточные достижения

### 3. Обратная связь и признание
- Регулярная позитивная обратная связь
- Публичное признание заслуг
- Празднование успехов команды

### 4. Развитие и рост
- Индивидуальные планы развития
- Новые вызовы и проекты
- Обучение и менторство

### 5. Создание смысла
- Объяснение важности работы
- Влияние на клиентов и общество
- Личный вклад в общий результат
        ', 'https://www.youtube.com/watch?v=vqPCsO8V3Vo', 'vqPCsO8V3Vo', NULL, 1, '2025-06-02 08:47:33', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (38, 'Делегирование и развитие сотрудников', 'Эффективные техники делегирования и развития потенциала команды', 'VIDEO', 'LEADERSHIP', 'INTERMEDIATE', 50, 'AI Assistant', '
# Делегирование и развитие сотрудников

## Почему лидеры не делегируют?

### Основные барьеры:
1. **"Быстрее сделать самому"** — краткосрочное мышление
2. **Страх потери контроля** — недоверие к команде
3. **Перфекционизм** — "Никто не сделает лучше меня"
4. **Нехватка времени на объяснения** — ложная экономия
5. **Страх конкуренции** — боязнь, что подчиненный превзойдет

## Модель эффективного делегирования

### 1. Выбор задачи и исполнителя
**Что делегировать:**
- Рутинные задачи
- Задачи для развития сотрудника
- Задачи в экспертной области подчиненного

**Кому делегировать:**
- Готовность взять ответственность
- Необходимые навыки или возможность их развить
- Доступность и загруженность

### 2. Постановка задачи (модель SMART-R)
- **S**pecific — Конкретная
- **M**easurable — Измеримая
- **A**chievable — Достижимая
- **R**elevant — Релевантная
- **T**ime-bound — Ограниченная во времени
- **R**esources — С необходимыми ресурсами

### 3. Уровни делегирования
1. **Исследуйте и доложите** — минимальная автономия
2. **Исследуйте и рекомендуйте** — больше самостоятельности
3. **Действуйте и информируйте** — высокая автономия
4. **Действуйте самостоятельно** — полная автономия

### 4. Поддержка и контроль
- Регулярные check-in встречи
- Доступность для вопросов
- Корректирующая обратная связь
- Признание результатов

## Развитие сотрудников

### Модель 70-20-10:
- **70%** — обучение на рабочем месте (проекты, задачи)
- **20%** — социальное обучение (менторство, коучинг)
- **10%** — формальное обучение (курсы, тренинги)

### Техники развития:
1. **Stretch assignments** — задачи на пределе возможностей
2. **Job rotation** — ротация по разным функциям
3. **Mentoring** — наставничество опытных коллег
4. **Coaching** — развивающие беседы
5. **Action learning** — обучение через решение реальных проблем
        ', 'https://www.youtube.com/watch?v=nyKdjm9ezfE', 'nyKdjm9ezfE', NULL, 1, '2025-06-02 08:47:33', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (39, 'Принятие решений и решение проблем', 'Методы принятия эффективных решений и системного решения проблем', 'VIDEO', 'LEADERSHIP', 'INTERMEDIATE', 55, 'AI Assistant', '
# Принятие решений и решение проблем

## Типы решений

### По степени структурированности:
1. **Программируемые** — стандартные, повторяющиеся
2. **Непрограммируемые** — уникальные, творческие

### По уровню риска:
1. **В условиях определенности** — известны все последствия
2. **В условиях риска** — известны вероятности исходов
3. **В условиях неопределенности** — неизвестны вероятности

## Процесс принятия решений

### 1. Определение проблемы
- Симптомы vs корневые причины
- Техника "5 почему"
- Анализ заинтересованных сторон

### 2. Генерация альтернатив
- Мозговой штурм
- Синектика (поиск аналогий)
- Морфологический анализ

### 3. Оценка альтернатив
- Критерии оценки
- Взвешивание важности критериев
- Матрица решений

### 4. Выбор решения
- Анализ "за" и "против"
- Сценарное планирование
- Интуиция vs рациональность

### 5. Реализация и контроль
- План внедрения
- Мониторинг результатов
- Корректирующие действия

## Методы принятия решений

### 1. Модель DECIDE
- **D**efine — Определите проблему
- **E**stablish — Установите критерии
- **C**onsider — Рассмотрите альтернативы
- **I**dentify — Выберите лучшую альтернативу
- **D**evelop — Разработайте план действий
- **E**valuate — Оцените результат

### 2. Матрица Эйзенхауэра для приоритизации
- Важно + Срочно = Делать немедленно
- Важно + Несрочно = Планировать
- Неважно + Срочно = Делегировать
- Неважно + Несрочно = Исключать

### 3. Анализ SWOT для стратегических решений
- **S**trengths — Сильные стороны
- **W**eaknesses — Слабые стороны
- **O**pportunities — Возможности
- **T**hreats — Угрозы

## Когнитивные ловушки

### Основные предубеждения:
1. **Якорение** — привязка к первой информации
2. **Подтверждение** — поиск подтверждающих фактов
3. **Доступность** — переоценка ярких примеров
4. **Самоуверенность** — переоценка своих способностей
5. **Эскалация обязательств** — продолжение неудачного проекта

### Как избежать ловушек:
- Ищите альтернативные точки зрения
- Играйте роль "адвоката дьявола"
- Используйте структурированные методы
- Получайте обратную связь от команды
        ', 'https://www.youtube.com/watch?v=p5fJGlPqC-k', 'p5fJGlPqC-k', NULL, 1, '2025-06-02 08:47:33', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (40, 'Коммуникация и влияние лидера', 'Эффективная коммуникация лидера и техники влияния на команду', 'VIDEO', 'LEADERSHIP', 'INTERMEDIATE', 50, 'AI Assistant', '
# Коммуникация и влияние лидера

## Особенности коммуникации лидера

### Лидер как коммуникатор должен:
1. **Вдохновлять** — создавать эмоциональную связь
2. **Объяснять** — делать сложное простым
3. **Убеждать** — использовать логику и эмоции
4. **Слушать** — понимать потребности команды
5. **Адаптироваться** — менять стиль под аудиторию

## Модель влияния Роберта Чалдини

### 1. Взаимность (Reciprocity)
Люди стремятся отплатить за оказанную услугу
- Первыми помогайте другим
- Делитесь знаниями и ресурсами
- Персонализируйте помощь

### 2. Обязательность (Commitment)
Люди стремятся быть последовательными
- Получайте публичные обязательства
- Вовлекайте в процесс принятия решений
- Напоминайте о предыдущих договоренностях

### 3. Социальное доказательство (Social Proof)
Люди ориентируются на поведение других
- Демонстрируйте примеры коллег
- Используйте истории успеха
- Создавайте положительные традиции

### 4. Симпатия (Liking)
Люди легче соглашаются с теми, кто им нравится
- Находите общие интересы
- Делайте искренние комплименты
- Сотрудничайте в достижении целей

### 5. Авторитет (Authority)
Люди следуют за экспертами
- Демонстрируйте экспертизу
- Получайте признание достижений
- Учитесь и развивайтесь постоянно

### 6. Дефицит (Scarcity)
Люди ценят редкие возможности
- Подчеркивайте уникальность предложений
- Создавайте ограничения по времени
- Показывайте потенциальные потери

## Техники влияния для лидеров

### 1. Сторителлинг
- Используйте личные истории
- Создавайте эмоциональную связь
- Делайте абстрактное конкретным

### 2. Активное слушание
- Парафразируйте сказанное
- Задавайте уточняющие вопросы
- Показывайте понимание эмоций

### 3. Постановка правильных вопросов
- Открытые vs закрытые вопросы
- Наводящие vs нейтральные
- Вопросы для развития мышления

### 4. Невербальная коммуникация
- Уверенная поза и жесты
- Зрительный контакт
- Соответствие слов и тела
        ', 'https://www.youtube.com/watch?v=qj5jtraqsnQ', 'qj5jtraqsnQ', NULL, 1, '2025-06-02 08:47:33', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (41, 'Управление изменениями', 'Лидерство в условиях изменений и трансформаций', 'VIDEO', 'LEADERSHIP', 'INTERMEDIATE', 60, 'AI Assistant', '
# Управление изменениями

## Модель изменений Джона Коттера

### 8 шагов трансформации:

#### 1. Создание чувства безотлагательности
- Анализ рынка и конкурентных реалий
- Выявление и обсуждение кризисов и возможностей
- 75% менеджеров должны быть убеждены в необходимости

#### 2. Формирование коалиции
- Объединение людей с достаточной властью
- Развитие командной работы в группе
- Проверка отсутствия "тяжелых эго"

#### 3. Создание видения и стратегии
- Видение, которое можно объяснить за 5 минут
- Стратегия достижения видения
- Видение должно быть простым и понятным

#### 4. Донесение видения трансформации
- Использование всех каналов коммуникации
- Обучение новым моделям поведения
- Лидеры должны быть примером

#### 5. Расширение возможностей действий
- Устранение препятствий для видения
- Изменение систем и структур
- Поощрение нестандартных идей и действий

#### 6. Обеспечение краткосрочных побед
- Планирование видимых улучшений результатов
- Создание этих улучшений
- Признание и награждение участников

#### 7. Консолидация достижений
- Использование возросшего доверия для больших изменений
- Найм, продвижение людей, способных реализовать видение
- Активизация процесса новыми проектами

#### 8. Закрепление новых подходов в культуре
- Артикуляция связи между новым поведением и успехом
- Развитие средств обеспечения развития лидерства

## Кривая изменений (Change Curve)

### Стадии реакции на изменения:
1. **Отрицание** — "Это нас не коснется"
2. **Сопротивление** — "Это плохая идея"
3. **Исследование** — "Может быть, есть что-то полезное"
4. **Обязательство** — "Давайте сделаем это работать"

### Роль лидера на каждой стадии:
- **Отрицание**: Информирование и объяснение
- **Сопротивление**: Слушание и поддержка
- **Исследование**: Вовлечение и обучение
- **Обязательство**: Поддержание и развитие

## Сопротивление изменениям

### Источники сопротивления:
1. **Страх неизвестного** — что будет дальше?
2. **Потеря контроля** — изменение статуса-кво
3. **Потеря компетентности** — навыки могут устареть
4. **Потеря отношений** — изменения в команде
5. **Потеря направления** — неясность целей

### Преодоление сопротивления:
1. **Коммуникация** — объяснение причин и выгод
2. **Участие** — вовлечение в планирование
3. **Поддержка** — помощь в адаптации
4. **Переговоры** — компромиссы и стимулы
5. **Принуждение** — в крайних случаях
        ', 'https://www.youtube.com/watch?v=hhWZWt180YU', 'hhWZWt180YU', NULL, 1, '2025-06-02 08:47:33', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (42, 'Лидерство и корпоративная культура', 'Влияние лидера на формирование и развитие корпоративной культуры', 'VIDEO', 'LEADERSHIP', 'INTERMEDIATE', 45, 'AI Assistant', '
# Лидерство и корпоративная культура

## Что такое корпоративная культура?

Корпоративная культура — это совокупность общих ценностей, убеждений, традиций и норм поведения, которые определяют "как мы здесь делаем дела".

### Уровни культуры по Эдгару Шейну:

#### 1. Артефакты (видимый уровень)
- Физическая среда и обстановка
- Язык и жаргон
- Технологии и продукты
- Стиль одежды
- Мифы и истории
- Церемонии и ритуалы

#### 2. Провозглашаемые ценности
- Официальная философия
- Стратегии и цели
- Миссия и видение
- Правила поведения

#### 3. Базовые предположения (глубинный уровень)
- Отношение к времени и пространству
- Природа человека
- Отношения между людьми
- Природа реальности и истины

## Роль лидера в формировании культуры

### Лидер влияет на культуру через:

#### 1. Личный пример
- Поведение говорит громче слов
- Последовательность в действиях
- Соответствие ценностям

#### 2. Распределение внимания
- На что лидер обращает внимание
- Что измеряет и контролирует
- Что обсуждает на встречах

#### 3. Реакция на кризисы
- Как ведет себя под давлением
- Какие решения принимает
- На что делает акцент

#### 4. Распределение ресурсов
- Бюджетные приоритеты
- Инвестиции в развитие
- Система вознаграждений

#### 5. Назначения и увольнения
- Кого продвигает
- Кого нанимает
- С кем расстается

#### 6. Организационные структуры
- Как организует работу
- Системы коммуникации
- Процедуры и политики

## Типы корпоративных культур

### Модель конкурирующих ценностей (CVF):

#### 1. Клановая культура
- **Фокус**: Люди и развитие
- **Характеристики**: Семейная атмосфера, наставничество
- **Лидерство**: Ментор, фасилитатор

#### 2. Адхократическая культура
- **Фокус**: Инновации и адаптивность
- **Характеристики**: Творчество, предпринимательство
- **Лидерство**: Инноватор, визионер

#### 3. Рыночная культура
- **Фокус**: Результаты и достижения
- **Характеристики**: Конкуренция, достижение целей
- **Лидерство**: Продюсер, директор

#### 4. Иерархическая культура
- **Фокус**: Стабильность и контроль
- **Характеристики**: Формальные процедуры, эффективность
- **Лидерство**: Координатор, монитор

## Изменение культуры

### Принципы изменения культуры:
1. **Начните с себя** — будьте примером
2. **Определите желаемую культуру** — четкое видение
3. **Найдите культурных агентов** — союзников изменений
4. **Используйте символы** — ритуалы и традиции
5. **Измеряйте прогресс** — опросы и обратная связь
6. **Будьте терпеливы** — культура меняется медленно
        ', 'https://www.youtube.com/watch?v=W6R10bQpxEA', 'W6R10bQpxEA', NULL, 1, '2025-06-02 08:47:33', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (43, 'Интеграция лидерских навыков: от теории к практике', 'Комплексное применение всех изученных лидерских навыков в реальных ситуациях', 'VIDEO', 'LEADERSHIP', 'INTERMEDIATE', 75, 'AI Assistant', '
# Интеграция лидерских навыков: от теории к практике

## Модель интегрированного лидерства

### Внутренний мир лидера (Self)
1. **Самосознание** — понимание себя
2. **Саморегуляция** — управление собой
3. **Мотивация** — внутренний драйв
4. **Ценности** — моральный компас
5. **Видение** — представление о будущем

### Отношения с людьми (Others)
1. **Эмпатия** — понимание других
2. **Коммуникация** — эффективное общение
3. **Влияние** — способность убеждать
4. **Развитие других** — коучинг и менторство
5. **Управление конфликтами** — разрешение споров

### Управление результатами (Results)
1. **Стратегическое мышление** — видение целого
2. **Принятие решений** — выбор курса действий
3. **Исполнение** — достижение результатов
4. **Инновации** — создание нового
5. **Адаптивность** — гибкость в изменениях

## Ситуационные вызовы лидера

### Сценарий 1: Кризисное лидерство
**Ситуация**: Неожиданный кризис требует быстрых решений

**Ключевые навыки**:
- Эмоциональная стабильность
- Быстрое принятие решений
- Четкая коммуникация
- Мобилизация команды

**Действия лидера**:
1. Оценить ситуацию объективно
2. Стабилизировать эмоциональное состояние команды
3. Принять быстрые решения
4. Координировать действия
5. Поддерживать моральный дух

### Сценарий 2: Лидерство роста
**Ситуация**: Компания/команда быстро растет

**Ключевые навыки**:
- Масштабирование процессов
- Развитие людей
- Поддержание культуры
- Стратегическое планирование

**Действия лидера**:
1. Планировать рост заранее
2. Инвестировать в развитие людей
3. Адаптировать структуры и процессы
4. Поддерживать качество и культуру
5. Готовить следующее поколение лидеров

### Сценарий 3: Трансформационное лидерство
**Ситуация**: Необходимы кардинальные изменения

**Ключевые навыки**:
- Создание видения
- Управление изменениями
- Преодоление сопротивления
- Вдохновение команды

**Действия лидера**:
1. Создать убедительное видение
2. Сформировать коалицию поддержки
3. Коммуницировать необходимость изменений
4. Вовлечь людей в процесс
5. Закрепить новые подходы

## Самооценка лидерских компетенций

### Чек-лист лидерских навыков (оценка 1-10):

#### Самолидерство:
- Самосознание: ___
- Саморегуляция: ___
- Мотивация: ___
- Целеполагание: ___

#### Лидерство других:
- Коммуникация: ___
- Влияние: ___
- Развитие команды: ___
- Управление конфликтами: ___

#### Лидерство результатов:
- Принятие решений: ___
- Стратегическое мышление: ___
- Управление изменениями: ___
- Инновационность: ___

## План развития лидера

### 1. Определите приоритеты развития
- Выберите 3-5 ключевых навыков
- Учтите требования роли
- Получите обратную связь от команды

### 2. Создайте план действий
- Конкретные шаги развития
- Временные рамки
- Ресурсы и поддержка
- Метрики прогресса

### 3. Найдите возможности практики
- Проекты и задачи
- Ментор или коуч
- Книги и курсы
- Сообщества лидеров

### 4. Измеряйте прогресс
- Регулярная самооценка
- Обратная связь от команды
- 360-градусная оценка
- Результаты команды
        ', 'https://www.youtube.com/watch?v=GenluOJeKmU', 'GenluOJeKmU', NULL, 1, '2025-06-02 08:47:33', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (44, 'Основы эмоционального интеллекта', 'Введение в концепцию EQ, самосознание и понимание эмоций', 'VIDEO', 'EMOTIONAL_INTELLIGENCE', 'INTERMEDIATE', 60, NULL, '# Основы эмоционального интеллекта

## Что такое эмоциональный интеллект?
Эмоциональный интеллект (EQ) — это способность распознавать, понимать и управлять своими эмоциями, а также эффективно взаимодействовать с эмоциями других людей.

## Модель Гоулмана: 4 компонента EQ

### 1. Самосознание (Self-awareness)
- Понимание своих эмоций
- Осознание сильных и слабых сторон
- Уверенность в себе

### 2. Саморегуляция (Self-regulation)
- Контроль импульсов
- Адаптивность
- Оптимизм

### 3. Социальная осведомленность (Social awareness)
- Эмпатия
- Организационная осведомленность
- Сервисная ориентация

### 4. Управление отношениями (Relationship management)
- Влияние
- Лидерство
- Управление конфликтами
- Командная работа

## Преимущества высокого EQ в работе
- Лучшее лидерство
- Эффективная коммуникация
- Снижение стресса
- Повышение производительности
- Улучшение отношений в команде

## Оценка своего EQ
Эмоциональный интеллект можно развивать. Первый шаг - честная оценка текущего уровня и понимание областей для роста.', 'https://www.youtube.com/watch?v=4-e0naex7P0', '4-e0naex7P0', NULL, 1, '2025-06-02 08:59:43', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (45, 'Развитие самосознания и эмоциональной осведомленности', 'Техники для лучшего понимания своих эмоций и их влияния на поведение', 'VIDEO', 'EMOTIONAL_INTELLIGENCE', 'INTERMEDIATE', 65, NULL, '# Развитие самосознания и эмоциональной осведомленности

## Что такое самосознание?
Самосознание — это способность распознавать и понимать свои эмоции в реальном времени, осознавать их влияние на мысли и поведение.

## Компоненты эмоционального самосознания

### 1. Эмоциональная осведомленность
- Распознавание эмоций по мере их возникновения
- Понимание связи между чувствами, мыслями и действиями
- Осознание влияния эмоций на производительность

### 2. Точная самооценка
- Понимание своих сильных сторон и ограничений
- Способность учиться на ошибках
- Открытость к обратной связи

### 3. Уверенность в себе
- Здоровое чувство собственного достоинства
- Способность выражать непопулярные точки зрения
- Решительность в принятии решений

## Техники развития самосознания

### Техника "Эмоциональный термометр"
1. Регулярно (каждые 2 часа) спрашивайте себя: "Что я сейчас чувствую?"
2. Оцените интенсивность эмоции по шкале 1-10
3. Определите триггер (что вызвало эмоцию)
4. Проанализируйте влияние на поведение

### Практика mindfulness
- Медитация осознанности 10-15 минут в день
- Осознанное дыхание в моменты стресса
- Body scan для связи с физическими ощущениями

### Ведение эмоционального дневника
- Ежедневные записи о значимых эмоциональных событиях
- Анализ паттернов и триггеров
- Отслеживание прогресса в управлении эмоциями

## Препятствия для самосознания
- Избегание неприятных эмоций
- Социальные маски и роли
- Автоматические реакции
- Недостаток времени для рефлексии', 'https://www.youtube.com/watch?v=33JzSaS03yI', '33JzSaS03yI', NULL, 1, '2025-06-02 09:01:14', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (46, 'Саморегуляция и управление импульсами', 'Стратегии контроля эмоций и продуктивного реагирования в сложных ситуациях', 'VIDEO', 'EMOTIONAL_INTELLIGENCE', 'INTERMEDIATE', 70, NULL, '# Саморегуляция и управление импульсами

## Понятие саморегуляции
Саморегуляция — это способность управлять своими эмоциями, импульсами и поведением для достижения долгосрочных целей.

## Компоненты саморегуляции

### 1. Эмоциональный самоконтроль
- Управление деструктивными эмоциями
- Сохранение спокойствия под давлением
- Быстрое восстановление после стресса

### 2. Адаптивность
- Гибкость в изменяющихся обстоятельствах
- Готовность пересматривать планы
- Открытость новым идеям

### 3. Ориентация на достижения
- Стремление к совершенствованию
- Готовность использовать возможности
- Оптимизм перед лицом неудач

## Техники саморегуляции

### Техника STOP
- **S**top — остановитесь
- **T**ake a breath — сделайте глубокий вдох
- **O**bserve — понаблюдайте за ситуацией
- **P**roceed — действуйте осознанно

### Когнитивная переоценка
1. Выявите негативную мысль
2. Проверьте ее на реалистичность
3. Найдите альтернативные интерпретации
4. Выберите более конструктивную точку зрения

### Техника "6 секунд"
Нейробиологические исследования показывают, что химический импульс эмоции длится примерно 6 секунд. Если вы сможете не реагировать эти 6 секунд, импульс ослабнет.

### Управление дыханием
- Диафрагмальное дыхание: 4 счета вдох, 4 счета задержка, 6 счетов выдох
- Техника 4-7-8: вдох на 4, задержка на 7, выдох на 8
- Box breathing: 4-4-4-4

## Работа с триггерами
1. Выявление личных триггеров
2. Разработка стратегий предотвращения
3. Создание плана действий для неизбежных ситуаций
4. Практика альтернативных реакций', 'https://www.youtube.com/watch?v=QVE2kDQO4Mk', 'QVE2kDQO4Mk', NULL, 1, '2025-06-02 09:01:14', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (47, 'Эмпатия и социальная осведомленность', 'Развитие способности понимать эмоции других людей и эффективно взаимодействовать', 'VIDEO', 'EMOTIONAL_INTELLIGENCE', 'INTERMEDIATE', 60, NULL, '# Эмпатия и социальная осведомленность

## Понятие эмпатии
Эмпатия — это способность понимать и разделять эмоции других людей, видеть ситуацию с их точки зрения.

## Типы эмпатии

### 1. Когнитивная эмпатия
- Понимание мыслей и чувств других
- Способность "читать" эмоции
- Предвидение реакций людей

### 2. Эмоциональная эмпатия
- Разделение эмоций других
- Физическое ощущение чужих эмоций
- Эмоциональное заражение

### 3. Сострадательная эмпатия
- Желание помочь
- Активные действия для поддержки
- Баланс между пониманием и действием

## Навыки социальной осведомленности

### Чтение невербальных сигналов
- Мимика и выражение лица
- Язык тела и поза
- Тон голоса и интонация
- Жесты и движения

### Активное слушание
1. Полное внимание собеседнику
2. Отражение услышанного
3. Задавание уточняющих вопросов
4. Невербальная поддержка

### Понимание групповой динамики
- Выявление лидеров и последователей
- Распознавание скрытых конфликтов
- Понимание неформальных сетей
- Чувствительность к атмосфере

## Техники развития эмпатии

### Упражнение "Смена перспектив"
1. Выберите человека, с которым у вас сложности
2. Попробуйте понять его точку зрения
3. Подумайте о его мотивах и страхах
4. Найдите общие точки соприкосновения

### Практика любопытства
- Задавайте открытые вопросы
- Проявляйте искренний интерес к другим
- Избегайте поспешных суждений
- Ищите истории за поведением

### Эмпатическое слушание
- Слушайте не только слова, но и эмоции
- Отражайте чувства собеседника
- Используйте фразы: "Я понимаю, что вы чувствуете..."
- Задавайте вопросы о переживаниях

## Границы эмпатии
Важно развивать эмпатию, сохраняя эмоциональные границы, чтобы избежать выгорания и сохранить объективность.', 'https://www.youtube.com/watch?v=YFZ2PxAxCdM', 'YFZ2PxAxCdM', NULL, 1, '2025-06-02 09:01:14', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (48, 'Социальные навыки и управление отношениями', 'Эффективное взаимодействие, влияние и построение крепких рабочих отношений', 'VIDEO', 'EMOTIONAL_INTELLIGENCE', 'INTERMEDIATE', 75, NULL, '# Социальные навыки и управление отношениями

## Компоненты социальных навыков

### 1. Влияние
- Способность убеждать и мотивировать
- Использование различных стилей влияния
- Построение коалиций и союзов

### 2. Коучинг и наставничество
- Развитие потенциала других
- Предоставление конструктивной обратной связи
- Создание возможностей для роста

### 3. Управление конфликтами
- Предотвращение и разрешение разногласий
- Поиск беспроигрышных решений
- Медиация между сторонами

### 4. Лидерство
- Вдохновение и мотивация команды
- Четкое видение и направление
- Создание позитивной атмосферы

## Стили влияния

### 1. Рациональное убеждение
- Логические аргументы
- Факты и данные
- Пошаговые объяснения

### 2. Вдохновляющие призывы
- Обращение к ценностям
- Эмоциональная мотивация
- Видение будущего

### 3. Консультации
- Вовлечение в принятие решений
- Учет мнений других
- Совместная разработка планов

### 4. Обмены
- Взаимные выгоды
- Компромиссы
- "Ты мне — я тебе"

## Техники построения отношений

### Раппорт и доверие
1. Найдите общие интересы
2. Проявляйте искреннюю заинтересованность
3. Соблюдайте обещания
4. Будьте последовательными

### Эффективная коммуникация
- Ясность и конкретность
- Адаптация стиля под аудиторию
- Использование историй и метафор
- Невербальная согласованность

### Управление командной динамикой
- Создание психологической безопасности
- Поощрение разнообразия мнений
- Управление групповым процессом
- Празднование успехов

## Разрешение конфликтов

### Модель WIN-WIN
1. Определите интересы всех сторон
2. Генерируйте варианты решений
3. Используйте объективные критерии
4. Разделяйте людей и проблемы

### Техника "Эмоциональный пинг-понг"
1. Признайте эмоции собеседника
2. Поделитесь своими чувствами
3. Найдите общую основу
4. Переключитесь на решение проблемы

## Обратная связь

### Модель SBI (Situation-Behavior-Impact)
- **Situation**: Опишите ситуацию
- **Behavior**: Укажите конкретное поведение
- **Impact**: Объясните влияние

### Принципы эффективной обратной связи
- Своевременность
- Конкретность
- Фокус на поведении, не личности
- Баланс позитивного и развивающего', 'https://www.youtube.com/watch?v=SGBGr0ojjmM', 'SGBGr0ojjmM', NULL, 1, '2025-06-02 09:01:14', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (49, 'Постановка целей и приоритизация по методу SMART', 'Эффективная постановка целей и определение приоритетов для максимальной продуктивности', 'VIDEO', 'TIME_MANAGEMENT', 'BEGINNER', 55, NULL, '# Постановка целей и приоритизация по методу SMART

## Важность правильной постановки целей
Четко сформулированные цели — основа эффективного управления временем. Без ясных целей время тратится на второстепенные задачи.

## Метод SMART для постановки целей

### S - Specific (Конкретные)
- Четко определенные и понятные
- Отвечают на вопросы: что, где, когда, как, почему
- Избегают общих формулировок

### M - Measurable (Измеримые)
- Количественные критерии успеха
- Возможность отслеживать прогресс
- Ясные метрики достижения

### A - Achievable (Достижимые)
- Реалистичные с учетом ресурсов
- Не слишком простые, но выполнимые
- Учитывают текущие возможности

### R - Relevant (Релевантные)
- Соответствуют общим целям
- Важны для развития и роста
- Связаны с ключевыми приоритетами

### T - Time-bound (Ограниченные во времени)
- Четкие сроки выполнения
- Промежуточные контрольные точки
- Чувство срочности

## Методы приоритизации

### Матрица приоритетов ABC
- **A**: Критически важные задачи
- **B**: Важные, но менее срочные
- **C**: Приятные, но не обязательные

### Метод MoSCoW
- **Must have**: Обязательно сделать
- **Should have**: Желательно сделать
- **Could have**: Можно сделать при наличии времени
- **Won''t have**: Не делать в текущем периоде

### Правило 3-х
Выбирайте максимум 3 приоритетные задачи на день для фокусировки усилий.

## Техники планирования

### Getting Things Done (GTD)
1. Сбор всех задач в одном месте
2. Обработка и классификация
3. Организация по контекстам
4. Регулярный обзор
5. Выполнение

### Временные блоки
- Выделение конкретного времени под задачи
- Группировка похожих активностей
- Защита времени от прерываний

## Обзор и корректировка целей
Регулярный пересмотр целей (еженедельно/ежемесячно) для поддержания актуальности и мотивации.', 'https://www.youtube.com/watch?v=I0pmdduIlkw', 'I0pmdduIlkw', NULL, 1, '2025-06-02 09:10:14', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (50, 'Борьба с прокрастинацией и повышение мотивации', 'Психологические методы преодоления откладывания дел и поддержания высокой мотивации', 'VIDEO', 'TIME_MANAGEMENT', 'BEGINNER', 50, NULL, '# Борьба с прокрастинацией и повышение мотивации

## Понимание прокрастинации

### Что такое прокрастинация?
Прокрастинация — это добровольное откладывание важных задач, несмотря на понимание негативных последствий.

### Типы прокрастинации
1. **Перфекционизм**: страх сделать несовершенно
2. **Overwhelm**: ощущение подавленности объемом задач
3. **Страх неудачи**: избегание риска провала
4. **Отсутствие мотивации**: задача кажется неинтересной
5. **Недостаток ясности**: непонимание как начать

## Техники преодоления прокрастинации

### Правило 2-х минут
Если задача займет менее 2 минут — делайте ее немедленно, не откладывая.

### Техника "Swiss Cheese"
Делайте случайные "дырки" в большой задаче, выполняя небольшие части в произвольном порядке.

### Метод 15 минут
Работайте над сложной задачей всего 15 минут. Часто этого достаточно чтобы войти в поток.

### Принцип "Съесть слона"
Разбивайте большие задачи на мелкие, выполнимые за один присест части.

### Техника "Следующее действие"
Всегда определяйте конкретное следующее физическое действие для продвижения к цели.

## Методы повышения мотивации

### Визуализация результата
- Представьте преимущества выполнения задачи
- Визуализируйте последствия невыполнения
- Создайте мысленную картину успеха

### Система вознаграждений
- Небольшие награды за промежуточные достижения
- Крупные вознаграждения за значимые цели
- Социальное признание успехов

### Техника "Momentum"
Начинайте день с выполнения простых задач для создания импульса движения.

### Accountability partner
Найдите человека, перед которым будете отчитываться о прогрессе.

## Работа с внутренними барьерами

### Негативный внутренний диалог
- Замечайте самокритичные мысли
- Заменяйте их конструктивными
- Практикуйте self-compassion

### Страх неудачи
- Переформулируйте неудачи как обучение
- Сосредоточьтесь на процессе, а не результате
- Принимайте несовершенство как норму

## Создание поддерживающей среды
- Уберите отвлекающие факторы
- Создайте ритуалы начала работы
- Окружите себя мотивирующими элементами', 'https://www.youtube.com/watch?v=uRsb2TlH2QY', 'uRsb2TlH2QY', NULL, 1, '2025-06-02 09:10:14', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (51, 'Цифровые инструменты для управления временем', 'Обзор и практическое применение современных приложений и сервисов для планирования', 'VIDEO', 'TIME_MANAGEMENT', 'BEGINNER', 45, NULL, '# Цифровые инструменты для управления временем

## Принципы выбора инструментов

### Ключевые критерии
1. **Простота использования**: интуитивный интерфейс
2. **Синхронизация**: доступ с разных устройств
3. **Гибкость**: адаптация под ваши процессы
4. **Интеграция**: совместимость с другими инструментами
5. **Надежность**: стабильная работа

## Категории инструментов

### Планировщики задач
**Todoist**
- Естественный язык для ввода задач
- Проекты и метки для организации
- Шаблоны для повторяющихся процессов

**Any.do**
- Минималистичный дизайн
- Голосовой ввод задач
- Интеграция с календарем

**Things 3** (Mac/iOS)
- Award-winning дизайн
- Natural planning workflow
- Powerful organization features

### Календарные приложения
**Google Calendar**
- Умные предложения времени
- Интеграция с Gmail
- Совместное планирование

**Calendly**
- Автоматическое планирование встреч
- Избежание конфликтов времени
- Интеграция с видеоконференциями

### Методология и фокус
**Forest**
- Pomodoro timer с геймификацией
- Блокировка отвлекающих приложений
- Визуализация продуктивности

**Focus Keeper**
- Простой Pomodoro timer
- Статистика фокуса
- Настраиваемые интервалы

**RescueTime**
- Автоматический трекинг времени
- Анализ продуктивности
- Блокировка отвлекающих сайтов

## Системы управления проектами

### Trello
- Kanban boards для визуального планирования
- Командная работа
- Power-ups для расширения функций

### Asana
- Проекты, задачи и подзадачи
- Timeline view для планирования
- Отчеты и аналитика

### Notion
- All-in-one workspace
- Базы данных и шаблоны
- Настраиваемые workflow

## Принципы эффективного использования

### Правило одного инструмента
Избегайте использования множества похожих приложений — выберите одно основное для каждой категории.

### Регулярная синхронизация
Настройте автоматическую синхронизацию между устройствами и резервное копирование.

### Еженедельный обзор
Регулярно анализируйте эффективность ваших инструментов и корректируйте настройки.

## Автоматизация рутинных задач

### IFTTT/Zapier
- Автоматизация между приложениями
- Триггеры и действия
- Экономия времени на рутине

### Шаблоны и чек-листы
- Стандартизация повторяющихся процессов
- Снижение когнитивной нагрузки
- Уменьшение ошибок

## Цифровая гигиена
- Регулярная очистка устаревших задач
- Организация файлов и папок
- Управление уведомлениями', 'https://www.youtube.com/watch?v=YSjr2zPbuHo', 'YSjr2zPbuHo', NULL, 1, '2025-06-02 09:10:14', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (52, 'Управление энергией и биоритмы', 'Оптимизация работоспособности через понимание естественных циклов энергии', 'VIDEO', 'TIME_MANAGEMENT', 'BEGINNER', 48, NULL, '# Управление энергией и биоритмы

## Энергия важнее времени

### Парадигма управления энергией
Традиционное управление временем фокусируется на часах, но продуктивность зависит больше от уровня энергии в конкретный момент.

### Типы энергии
1. **Физическая**: здоровье, выносливость, сила
2. **Эмоциональная**: настроение, мотивация, страсть
3. **Ментальная**: концентрация, творчество, принятие решений
4. **Духовная**: смысл, ценности, цель

## Циркадные ритмы и хронотипы

### Понимание биоритмов
Циркадные ритмы — это естественные 24-часовые циклы физиологических процессов, влияющие на:
- Температуру тела
- Выработку гормонов
- Когнитивные способности
- Настроение и энергию

### Хронотипы
**Жаворонки (25% населения)**
- Пик энергии: 6:00-12:00
- Лучшее время для сложных задач: утро
- Спад энергии: после обеда

**Совы (25% населения)**
- Пик энергии: 17:00-24:00
- Лучшее время для сложных задач: вечер
- Медленный старт утром

**Голуби (50% населения)**
- Пик энергии: 10:00-14:00
- Универсальное время продуктивности
- Умеренные колебания энергии

## Принципы энергетического планирования

### Соответствие задач уровню энергии
- **Высокая энергия**: творческие и аналитические задачи
- **Средняя энергия**: рутинные задачи, коммуникация
- **Низкая энергия**: организационные задачи, планирование

### Ритм работы и отдыха
**Ультрадианные ритмы (90-120 минут)**
- Естественные циклы концентрации
- Необходимость перерывов каждые 90 минут
- Микросон для восстановления

## Стратегии управления энергией

### Физическая энергия
**Сон**
- 7-9 часов качественного сна
- Постоянное время отхода ко сну
- Создание ритуалов засыпания

**Питание**
- Регулярные приемы пищи
- Избегание резких скачков сахара
- Гидратация в течение дня

**Физическая активность**
- Ежедневные упражнения
- Прогулки между задачами
- Растяжка для снятия напряжения

### Ментальная энергия
**Однозадачность**
- Глубокое погружение в одну задачу
- Избегание multitasking
- Использование техник концентрации

**Когнитивные перерывы**
- Смена типа деятельности
- Медитация или mindfulness
- Природа для восстановления внимания

### Эмоциональная энергия
**Позитивные эмоции**
- Благодарность и признательность
- Социальные связи
- Достижение небольших целей

**Управление стрессом**
- Техники дыхания
- Переформулирование ситуаций
- Поиск поддержки

## Персональная энергетическая карта
Отслеживайте свои уровни энергии в течение дня в течение 1-2 недель для выявления персональных паттернов.', 'https://www.youtube.com/watch?v=QhJZXA9DPi8', 'QhJZXA9DPi8', NULL, 1, '2025-06-02 09:10:14', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (53, 'Эффективные совещания и коммуникация', 'Оптимизация времени, затрачиваемого на встречи и общение с коллегами', 'VIDEO', 'TIME_MANAGEMENT', 'BEGINNER', 42, NULL, '# Эффективные совещания и коммуникация

## Проблема неэффективных совещаний

### Статистика потерь времени
- Средний офисный работник проводит 23 часа в неделю на совещаниях
- 67% работников считают совещания самой большой тратой времени
- 39% участников засыпают на совещаниях

### Основные проблемы
- Отсутствие четкой повестки дня
- Слишком много участников
- Затягивание обсуждений
- Отсутствие конкретных решений
- Игнорирование временных рамок

## Принципы эффективных совещаний

### Правило необходимости
**Вопросы перед назначением встречи:**
- Можно ли решить вопрос email/чатом?
- Нужны ли все приглашенные участники?
- Есть ли четкая цель встречи?
- Какой конкретный результат ожидается?

### Структура эффективного совещания
1. **Подготовка** (до встречи)
2. **Проведение** (четкий процесс)
3. **Последующие действия** (после встречи)

## Подготовка к совещанию

### Четкая повестка дня
- Конкретные вопросы для обсуждения
- Время на каждый пункт
- Ответственные за презентацию
- Ожидаемые решения

### Подготовка материалов
- Предварительная рассылка документов
- Время для изучения до встречи
- Конкретные вопросы для решения

### Оптимальное количество участников
**Правило "двух пицц" Amazon:**
Если группу нельзя накормить двумя пиццами — она слишком большая.

**Роли участников:**
- **Владелец решения**: принимает финальное решение
- **Консультанты**: предоставляют экспертизу
- **Исполнители**: будут реализовывать решения

## Проведение совещания

### Временные рамки
- Начинайте точно в назначенное время
- Используйте таймер для каждого пункта
- Делайте перерывы каждые 45-60 минут
- Завершайте вовремя

### Фасилитация дискуссий
**Техники управления обсуждением:**
- Parking lot для второстепенных вопросов
- Round robin для равного участия
- Devil''s advocate для критического мышления
- Silent start для индивидуального размышления

### Принятие решений
- Четко формулируйте варианты
- Используйте голосование при необходимости
- Документируйте принятые решения
- Назначайте ответственных и дедлайны

## Альтернативы традиционным совещаниям

### Stand-up meetings (15 минут)
- Что сделано вчера
- Планы на сегодня
- Препятствия и помощь

### Walking meetings
- Для креативных обсуждений
- Один на один
- Максимум 3 человека

### Асинхронные обновления
- Письменные отчеты
- Видео-сообщения
- Shared документы для комментариев

## Эффективная цифровая коммуникация

### Email этикет
- Четкие темы писем
- Краткость и структурированность
- Использование bullet points
- Четкие call-to-action

### Мгновенные сообщения
- Статусы доступности
- Использование каналов по темам
- Асинхронная vs синхронная коммуникация

### Видеоконференции
- Проверка технической части заранее
- Мute по умолчанию
- Включение камеры для вовлеченности
- Запись для отсутствующих

## Защита времени от прерываний

### Техники управления прерываниями
- Назначение office hours для вопросов
- Использование статусов "не беспокоить"
- Батчинг похожих коммуникаций
- Делегирование части коммуникации', 'https://www.youtube.com/watch?v=8GxznpGPOJs', '8GxznpGPOJs', NULL, 1, '2025-06-02 09:10:14', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (54, 'Стресс-менеджмент и work-life баланс', 'Управление стрессом и поддержание здорового баланса между работой и личной жизнью', 'VIDEO', 'TIME_MANAGEMENT', 'BEGINNER', 52, NULL, '# Стресс-менеджмент и work-life баланс

## Понимание стресса и его влияния на время

### Типы стресса
**Эустресс (положительный)**
- Мотивирует к действию
- Повышает производительность
- Краткосрочный эффект

**Дистресс (отрицательный)**
- Подавляет способности
- Снижает эффективность
- Долгосрочные негативные последствия

### Влияние стресса на управление временем
- Снижение концентрации
- Прокрастинация и избегание
- Плохие решения под давлением
- Физическое и эмоциональное истощение

## Техники управления стрессом

### Физиологические методы
**Дыхательные техники**
- Диафрагмальное дыхание 4-7-8
- Box breathing для быстрого успокоения
- Coherent breathing для баланса

**Прогрессивная мышечная релаксация**
- Последовательное напряжение и расслабление мышц
- Осознание физических проявлений стресса
- Развитие навыка быстрой релаксации

**Физическая активность**
- Кардиотренировки для выработки эндорфинов
- Йога для гибкости и осознанности
- Прогулки на природе для восстановления

### Когнитивные стратегии
**Переформулирование ситуаций**
- Поиск возможностей в проблемах
- Фокус на контролируемых аспектах
- Разделение фактов и интерпретаций

**Техника "Worst case scenario"**
- Планирование для худшего сценария
- Снижение тревожности через подготовку
- Понимание, что большинство страхов преувеличены

**Mindfulness и медитация**
- Осознанное присутствие в моменте
- Наблюдение мыслей без оценки
- Регулярная практика для долгосрочных результатов

## Work-life баланс vs Work-life интеграция

### Традиционный баланс
- Четкое разделение работы и личной жизни
- Фиксированные границы времени
- Подходит для структурированных профессий

### Современная интеграция
- Гибкое смешивание сфер жизни
- Фокус на энергии, а не времени
- Адаптация под личные потребности

## Стратегии создания границ

### Временные границы
**Фиксированное время работы**
- Четкое начало и конец рабочего дня
- Ритуалы перехода между сферами
- Уважение к личному времени

**Технологические границы**
- Отключение уведомлений после работы
- Отдельные устройства для работы и личной жизни
- "Цифровой детокс" в выходные

### Физические границы
**Рабочее пространство**
- Отдельная зона для работы дома
- Организация пространства для фокуса
- Ритуалы "закрытия офиса"

### Эмоциональные границы
**Научение говорить "нет"**
- Оценка запросов на соответствие приоритетам
- Предложение альтернатив
- Защита времени для важных целей

## Восстановление и отдых

### Качественный отдых
**Активное vs пассивное восстановление**
- Активное: хобби, спорт, социальное общение
- Пассивное: сон, медитация, отдых на природе

**Микро-перерывы в течение дня**
- 5-минутные паузы каждый час
- Смена обстановки и активности
- Техники быстрого восстановления

### Отпуск и полное отключение
**Планирование отпуска**
- Полное делегирование обязанностей
- Настройка автоответчиков
- Ментальная подготовка к отключению

**Возвращение после отпуска**
- Постепенное погружение в работу
- Анализ накопившихся задач
- Сохранение отпускных инсайтов

## Признаки выгорания и профилактика

### Симптомы выгорания
- Хроническая усталость
- Цинизм и раздражительность
- Снижение производительности
- Физические симптомы стресса

### Профилактические меры
- Регулярная самооценка состояния
- Поддержка социальных связей
- Развитие интересов вне работы
- Профессиональная помощь при необходимости

## Создание персональной системы

### Индивидуальный подход
- Понимание личных триггеров стресса
- Выбор подходящих техник восстановления
- Создание персональных ритуалов
- Регулярная корректировка системы', 'https://www.youtube.com/watch?v=gJDbQ3hxnic', 'gJDbQ3hxnic', NULL, 1, '2025-06-02 09:10:14', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (55, 'Долгосрочное планирование и развитие навыков', 'Стратегическое планирование карьеры и личностного роста с фокусом на управление временем', 'VIDEO', 'TIME_MANAGEMENT', 'BEGINNER', 58, NULL, '# Долгосрочное планирование и развитие навыков

## Философия долгосрочного мышления

### Compound Effect
Небольшие постоянные улучшения дают экспоненциальные результаты со временем. 1% улучшения каждый день = 37x улучшение за год.

### Time Perspective Theory
Люди с долгосрочной перспективой:
- Принимают лучшие решения
- Более устойчивы к стрессу
- Достигают больших результатов
- Лучше управляют временем

## Стратегическое планирование жизни

### Видение и миссия
**Личная миссия**
- Четкое понимание своих ценностей
- Определение жизненной цели
- Критерии для принятия решений

**10-летнее видение**
- Представление идеального будущего
- Ключевые области развития
- Конкретные достижения

### Планирование по горизонтам
**Горизонт 1: Текущие приоритеты (1-2 года)**
- Оптимизация существующих процессов
- Достижение краткосрочных целей
- 70% времени и ресурсов

**Горизонт 2: Возникающие возможности (2-5 лет)**
- Развитие новых навыков
- Экспериментирование
- 20% времени и ресурсов

**Горизонт 3: Трансформационные инициативы (5-10 лет)**
- Радикальные изменения
- Инновационные проекты
- 10% времени и ресурсов

## Развитие навыков управления временем

### Модель 70-20-10
**70% - Обучение через опыт**
- Challenging assignments
- Решение сложных проблем
- Выход из зоны комфорта

**20% - Обучение через других**
- Менторство и коучинг
- Наблюдение за экспертами
- Обратная связь и рефлексия

**10% - Формальное обучение**
- Курсы и тренинги
- Чтение и изучение
- Сертификации

### Deliberate Practice для тайм-менеджмента
**Принципы осознанной практики:**
1. Фокус на слабых сторонах
2. Немедленная обратная связь
3. Постепенное усложнение
4. Регулярная практика

**Применение к управлению временем:**
- Ежедневная рефлексия эффективности
- Эксперименты с новыми техниками
- Измерение результатов
- Корректировка подходов

## Системы личностного развития

### Getting Things Done (GTD) как философия
**Пять этапов продуктивности:**
1. **Capture**: Сбор всего в одном месте
2. **Clarify**: Определение сути и действий
3. **Organize**: Структурирование по контекстам
4. **Reflect**: Регулярный обзор системы
5. **Engage**: Выбор правильных действий

### Создание персональной системы
**Ключевые компоненты:**
- Inbox для всех входящих задач
- Система хранения справочной информации
- Calendar для назначенных времени событий
- Next Actions по контекстам
- Someday/Maybe для будущих идей

## Долгосрочные метрики и KPI

### Ведущие vs отстающие показатели
**Отстающие показатели** (результаты):
- Достигнутые цели
- Завершенные проекты
- Карьерный рост

**Ведущие показатели** (процесс):
- Время в состоянии потока
- Количество выполненных приоритетных задач
- Часы обучения в неделю
- Качество планирования

### Персональный dashboard
**Еженедельные метрики:**
- Соотношение планового vs фактического времени
- Процент времени на приоритетных задачах
- Энергетические уровни
- Удовлетворенность прогрессом

**Ежемесячные обзоры:**
- Прогресс по долгосрочным целям
- Эффективность использованных техник
- Выявленные паттерны и тренды
- Корректировка стратегии

## Создание legacy и наставничество

### Передача знаний
**Документирование процессов:**
- Личные best practices
- Lessons learned
- Шаблоны и чек-листы

**Наставничество других:**
- Обучение коллег эффективным техникам
- Создание команды с высокой продуктивностью
- Влияние на организационную культуру

### Непрерывное совершенствование
**Принцип Kaizen:**
- Постоянные небольшие улучшения
- Эксперименты и итерации
- Культура обучения на ошибках

**Staying current:**
- Отслеживание новых методик
- Участие в профессиональных сообществах
- Регулярное обновление инструментов

## Интеграция всех аспектов

### Holistic approach
Управление временем не изолированный навык, а интегральная часть:
- Лидерских качеств
- Профессионального мастерства
- Личностного развития
- Качества жизни

### Создание персональной системы жизни
Разработка индивидуального подхода, объединяющего:
- Ценности и приоритеты
- Естественные ритмы и предпочтения
- Профессиональные требования
- Личные обстоятельства', 'https://www.youtube.com/watch?v=9vkUIP_EEpQ', '9vkUIP_EEpQ', NULL, 1, '2025-06-02 09:10:14', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (56, 'Эмоциональный интеллект в командной работе', NULL, 'ARTICLE', 'EMOTIONAL_INTELLIGENCE', 'INTERMEDIATE', 70, NULL, '# Эмоциональный интеллект в командной работе

## Цель урока
Изучить применение навыков эмоционального интеллекта для эффективной командной работы и создания позитивной рабочей атмосферы.

## Основные темы

### 1. Роль EQ в команде
- Влияние эмоций на командную динамику
- Создание психологической безопасности
- Управление групповыми эмоциями

### 2. Эмоциональные роли в команде
- Эмоциональный лидер команды
- Медиатор конфликтов
- Мотиватор и вдохновитель

### 3. Коллективный эмоциональный интеллект
- Нормы эмоционального взаимодействия
- Групповая эмпатия
- Совместное решение проблем

### 4. Управление конфликтами
- Эмоциональные триггеры в команде
- Техники деэскалации
- Превращение конфликта в возможность

## Практические техники

### Техника "Эмоциональный барометр команды"
1. Ежедневная проверка эмоционального состояния
2. Открытое обсуждение чувств
3. Корректировка командной работы

### Метод "Эмоциональная перспектива"
1. Рассмотрение ситуации с точки зрения каждого участника
2. Поиск общих эмоциональных потребностей
3. Выработка компромиссных решений

## Заключение
Эмоциональный интеллект команды создает синергетический эффект, где общий результат превышает сумму индивидуальных усилий.', 'https://www.youtube.com/watch?v=6tG1Ly5XBS8', '6tG1Ly5XBS8', NULL, 0, '2025-06-02 09:15:38', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (57, 'Стрессоустойчивость и эмоциональная выносливость', NULL, 'ARTICLE', 'EMOTIONAL_INTELLIGENCE', 'INTERMEDIATE', 75, NULL, '# Стрессоустойчивость и эмоциональная выносливость

## Цель урока
Развить навыки управления стрессом и повышения эмоциональной выносливости в профессиональной деятельности.

## Основные темы

### 1. Понимание стресса
- Физиология стресса
- Положительный vs деструктивный стресс
- Индивидуальные стрессоры

### 2. Эмоциональная выносливость
- Компоненты эмоциональной выносливости
- Ресурсы восстановления
- Профилактика эмоционального выгорания

### 3. Стратегии управления стрессом
- Когнитивные техники
- Физиологические методы
- Поведенческие стратегии

### 4. Восстановление после стресса
- Эмоциональная регенерация
- Техники быстрого восстановления
- Планирование отдыха

## Практические техники

### Техника "4-7-8" (дыхательная)
1. Вдох на 4 счета
2. Задержка на 7 счетов
3. Выдох на 8 счетов
4. Повторить 4 цикла

### Метод "Эмоциональная перезагрузка"
1. Остановка и осознание стресса
2. Глубокое дыхание
3. Переформулирование ситуации
4. Выбор конструктивного действия

### Техника "Энергетический аудит"
1. Определение источников энергии
2. Выявление "энергетических вампиров"
3. Планирование восстановления

## Долгосрочные стратегии
- Регулярные практики осознанности
- Физическая активность
- Социальная поддержка
- Хобби и творчество

## Заключение
Эмоциональная выносливость - это навык, который можно развивать. Регулярная практика и осознанный подход помогают создать устойчивость к стрессам.', 'https://www.youtube.com/watch?v=JhKrwT2Kpjc', 'JhKrwT2Kpjc', NULL, 0, '2025-06-02 09:15:38', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (58, 'Эмоциональное лидерство и влияние', NULL, 'ARTICLE', 'EMOTIONAL_INTELLIGENCE', 'INTERMEDIATE', 80, NULL, '# Эмоциональное лидерство и влияние

## Цель урока
Изучить принципы эмоционального лидерства и методы позитивного влияния на окружающих через управление эмоциями.

## Основные темы

### 1. Эмоциональное лидерство
- Определение эмоционального лидера
- Отличия от традиционного лидерства
- Влияние на результативность команды

### 2. Модель эмоционального влияния
- Резонансное лидерство
- Эмоциональное заражение
- Создание вдохновляющей атмосферы

### 3. Стили эмоционального лидерства
- Визионерский стиль
- Коучинговый подход
- Демократичное лидерство
- Лидер-миротворец

### 4. Управление эмоциональным климатом
- Диагностика эмоционального состояния группы
- Инструменты изменения атмосферы
- Поддержание позитивного настроя

## Практические инструменты

### Техника "Эмоциональный камертон"
1. Настройка на эмоциональную волну группы
2. Постепенное смещение к желаемому состоянию
3. Закрепление нового эмоционального тона

### Модель "INSPIRE"
- **I**dentify (определить текущие эмоции)
- **N**avigate (направить в нужное русло)
- **S**upport (поддержать участников)
- **P**articipate (активно участвовать)
- **I**nvigorate (вдохновить на действия)
- **R**ecognize (признать достижения)
- **E**valuate (оценить результат)

### Техника "Эмоциональное моделирование"
1. Демонстрация желаемых эмоций
2. Объяснение их значимости
3. Поощрение подражания
4. Поддержание нового поведения

## Этика эмоционального влияния
- Честность намерений
- Уважение к автономии других
- Развитие, а не манипулирование
- Взаимная польза

## Заключение
Эмоциональное лидерство - это искусство создания среды, где люди могут проявить свой лучший потенциал через позитивные эмоциональные состояния.', 'https://www.youtube.com/watch?v=HN4HQGuz0GQ', 'HN4HQGuz0GQ', NULL, 0, '2025-06-02 09:15:38', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (59, 'Цифровой эмоциональный интеллект', NULL, 'ARTICLE', 'EMOTIONAL_INTELLIGENCE', 'INTERMEDIATE', 65, NULL, '# Цифровой эмоциональный интеллект

## Цель урока
Освоить навыки эмоционального интеллекта в цифровой среде и виртуальном взаимодействии.

## Основные темы

### 1. Особенности цифрового общения
- Потеря невербальных сигналов
- Эмоциональная амбивалентность текста
- Скорость и объем коммуникаций

### 2. Эмоциональные вызовы цифровой эпохи
- Информационная перегрузка
- Социальные сети и сравнение
- Цифровое выгорание

### 3. Инструменты цифрового EQ
- Эмоциональная разметка сообщений
- Паузы перед отправкой
- Виртуальная эмпатия

### 4. Управление онлайн-репутацией
- Эмоциональный след в интернете
- Профессиональный имидж
- Кризис-менеджмент в соцсетях

## Практические стратегии

### Техника "Цифровая пауза"
1. Написать сообщение
2. Сохранить в черновиках
3. Подождать 10 минут
4. Перечитать и отредактировать
5. Отправить осознанно

### Правило "3С" для email
- **С**ясность: четко выражать мысли
- **С**ердечность: добавлять эмоциональную теплоту
- **С**жатость: быть лаконичным

### Метод "Эмоциональных смайлов"
- Использование эмодзи для передачи эмоций
- Адаптация к корпоративной культуре
- Баланс между профессионализмом и человечностью

## Виртуальное лидерство
- Создание эмоциональной связи онлайн
- Управление удаленными командами
- Мотивация через экран

## Цифровая детоксикация
- Планирование офлайн-времени
- Осознанное потребление контента
- Восстановление реальных связей

## Заключение
Цифровой эмоциональный интеллект становится критически важным навыком в современном мире, требующим адаптации традиционных EQ-навыков к новой реальности.', 'https://www.youtube.com/watch?v=C_NJT_KtTPY', 'C_NJT_KtTPY', NULL, 0, '2025-06-02 09:15:38', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (60, 'Интеграция и развитие эмоционального интеллекта', NULL, 'ARTICLE', 'EMOTIONAL_INTELLIGENCE', 'INTERMEDIATE', 85, NULL, '# Интеграция и развитие эмоционального интеллекта

## Цель урока
Создать персональный план развития эмоционального интеллекта и интегрировать все изученные навыки в повседневную профессиональную деятельность.

## Основные темы

### 1. Комплексная модель EQ
- Интеграция всех компонентов
- Синергия навыков
- Системный подход к развитию

### 2. Персональная оценка EQ
- Диагностические инструменты
- 360-градусная обратная связь
- Самоанализ и рефлексия

### 3. План развития EQ
- SMART-цели для эмоционального роста
- Этапы развития
- Метрики прогресса

### 4. Поддерживающая среда
- Создание EQ-культуры
- Ментoring и коучинг
- Обучающиеся организации

## Диагностические инструменты

### EQ-360 Assessment
1. Самооценка по 4 доменам EQ
2. Оценка коллегами и подчиненными
3. Сравнительный анализ восприятия
4. Выявление слепых зон

### Техника "Эмоциональный дневник"
- Ежедневные записи о эмоциональных событиях
- Анализ триггеров и паттернов
- Отслеживание прогресса

### Модель развития "GROW EQ"
- **G**oal (цель): что хочу развить в EQ
- **R**eality (реальность): текущий уровень
- **O**ptions (варианты): способы развития
- **W**ay forward (путь): конкретные шаги

## Персональный план развития

### Этап 1: Основы (1-3 месяца)
- Развитие самосознания
- Базовые техники саморегуляции
- Улучшение эмпатии

### Этап 2: Применение (3-6 месяцев)
- Интеграция в рабочие процессы
- Развитие социальных навыков
- Практика в сложных ситуациях

### Этап 3: Мастерство (6-12 месяцев)
- Эмоциональное лидерство
- Обучение других
- Создание EQ-культуры

## Поддержание мотивации
- Празднование маленьких побед
- Поиск единомышленников
- Регулярная обратная связь

## Измерение результатов
- Количественные метрики (опросы, тесты)
- Качественные показатели (истории успеха)
- Долгосрочные изменения в карьере

## Заключение курса
Эмоциональный интеллект - это не пункт назначения, а путешествие длиною в жизнь. Постоянное развитие и практика приводят к профессиональному и личностному росту.

## Ресурсы для дальнейшего развития
- Рекомендуемая литература
- Онлайн-курсы и тренинги
- Профессиональные сообщества
- Приложения для развития EQ', 'https://www.youtube.com/watch?v=lk_hEN8pWE0', 'lk_hEN8pWE0', NULL, 0, '2025-06-02 09:15:38', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (61, 'Основы критического мышления', NULL, 'VIDEO', 'PROBLEM_SOLVING', 'INTERMEDIATE', 60, NULL, '# Основы критического мышления

## Цель урока
Освоить фундаментальные принципы критического мышления и научиться анализировать информацию объективно.

## Что такое критическое мышление
Критическое мышление — это способность анализировать информацию, делать обоснованные выводы и принимать взвешенные решения.

### Ключевые навыки:
- **Анализ** — разбор информации на составляющие
- **Оценка** — определение достоверности и значимости
- **Синтез** — объединение фактов в логичные выводы
- **Интерпретация** — понимание смысла и контекста

## Барьеры критического мышления

### 1. Когнитивные искажения
- Предвзятость подтверждения
- Эффект якорения
- Поспешные обобщения

### 2. Эмоциональные блоки
- Страх ошибиться
- Стремление к комфорту
- Групповое мышление

## Модель критического мышления "CLEAR"
- **C**laim (Утверждение) — что утверждается?
- **L**ogic (Логика) — логично ли рассуждение?
- **E**vidence (Доказательства) — есть ли подтверждения?
- **A**ssumptions (Предположения) — какие допущения сделаны?
- **R**elevance (Релевантность) — относится ли к делу?', 'https://www.youtube.com/watch?v=Fa5512cDROk', 'Fa5512cDROk', NULL, 0, '2025-06-02 09:25:38', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (62, 'Структурированный подход к решению проблем', NULL, 'VIDEO', 'PROBLEM_SOLVING', 'INTERMEDIATE', 65, NULL, '# Структурированный подход к решению проблем

## Цель урока
Изучить системные методы решения проблем и научиться применять структурированный подход.

## Модель решения проблем "PDCA"
### Plan (Планирование)
1. Определение проблемы
2. Анализ причин
3. Выбор решения
4. Планирование внедрения

### Do (Выполнение)
- Реализация плана
- Сбор данных

### Check (Проверка)
- Анализ результатов
- Сравнение с ожиданиями

### Act (Действие)
- Стандартизация решения
- Или возврат к планированию

## Техника "5 почему"
Последовательное задавание вопроса "Почему?" для выявления корневой причины:
1. Почему произошла проблема?
2. Почему это случилось?
3. Почему...? (и так далее)

## Диаграмма Исикавы (Fishbone)
Анализ причин по категориям:
- **Люди** — квалификация, мотивация
- **Процессы** — методы, процедуры
- **Материалы** — качество, доступность
- **Машины** — оборудование, инструменты
- **Методы** — технологии, подходы
- **Среда** — условия работы', 'https://www.youtube.com/watch?v=lhhmIfRPuIg', 'lhhmIfRPuIg', NULL, 0, '2025-06-02 09:25:38', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (63, 'Креативные методы генерации идей', NULL, 'VIDEO', 'PROBLEM_SOLVING', 'INTERMEDIATE', 55, NULL, '# Креативные методы генерации идей

## Цель урока
Освоить техники креативного мышления для поиска нестандартных решений.

## Мозговой штурм 2.0
### Правила:
1. Отсрочка критики
2. Стремление к количеству
3. Развитие чужих идей
4. Поощрение "диких" идей

### Вариации:
- **Обратный мозговой штурм** — как НЕ решить проблему
- **6-3-5** — 6 человек, 3 идеи, 5 минут
- **Номинальная групповая техника**

## Метод SCAMPER
- **S**ubstitute — что заменить?
- **C**ombine — что объединить?
- **A**dapt — что адаптировать?
- **M**odify — что изменить?
- **P**ut to other uses — как использовать по-другому?
- **E**liminate — что убрать?
- **R**everse — что обратить?

## Латеральное мышление
Техники Эдварда де Боно:
- **Случайное слово** — генерация идей через случайные ассоциации
- **Провокация** — "А что если...?"
- **Альтернативы** — поиск других способов

## Метод Уолта Диснея
Три роли:
1. **Мечтатель** — генерирует идеи без ограничений
2. **Реалист** — оценивает практичность
3. **Критик** — выявляет проблемы', 'https://www.youtube.com/watch?v=OWLbSxwPHhQ', 'OWLbSxwPHhQ', NULL, 0, '2025-06-02 09:25:38', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (64, 'Принятие решений в условиях неопределенности', NULL, 'VIDEO', 'PROBLEM_SOLVING', 'INTERMEDIATE', 70, NULL, '# Принятие решений в условиях неопределенности

## Цель урока
Научиться принимать качественные решения даже при недостатке информации.

## Типы неопределенности
### 1. Риск
Известны вероятности исходов

### 2. Неопределенность
Неизвестны вероятности

### 3. Невежество
Неизвестны даже возможные исходы

## Матрица решений
| Критерий | Альтернатива 1 | Альтернатива 2 | Альтернатива 3 |
|----------|----------------|----------------|----------------|
| Стоимость| 8              | 6              | 7              |
| Время    | 7              | 9              | 8              |
| Качество | 9              | 7              | 8              |

## Методы принятия решений

### 1. Метод весовых коэффициентов
- Определение важности критериев
- Оценка альтернатив по каждому критерию
- Расчет взвешенных оценок

### 2. Анализ чувствительности
Проверка стабильности решения при изменении параметров

### 3. Дерево решений
Визуализация последовательности решений и их последствий

## Правило 10-10-10
Как я буду относиться к этому решению через:
- 10 минут?
- 10 месяцев?
- 10 лет?

## Принцип минимального сожаления
Выбор решения, которое минимизирует максимальное сожаление', 'https://www.youtube.com/watch?v=F4OgfA12RXg', 'F4OgfA12RXg', NULL, 0, '2025-06-02 09:25:38', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (65, 'Анализ данных и доказательства', NULL, 'VIDEO', 'PROBLEM_SOLVING', 'INTERMEDIATE', 60, NULL, '# Анализ данных и доказательства

## Цель урока
Научиться работать с данными, оценивать качество доказательств и избегать манипуляций.

## Типы доказательств
### 1. По силе
- **Прямые** — непосредственно подтверждают утверждение
- **Косвенные** — подтверждают через логические связи
- **Отсутствующие** — важность того, чего нет

### 2. По источнику
- **Первичные** — оригинальные исследования
- **Вторичные** — анализ первичных данных
- **Экспертные мнения**

## Оценка качества данных
### Критерии CRAAP
- **C**urrency — актуальность
- **R**elevance — релевантность
- **A**uthority — авторитетность источника
- **A**ccuracy — точность
- **P**urpose — цель публикации

## Статистические ловушки
### 1. Корреляция vs причинность
Связь не означает причину

### 2. Селективная выборка
Представление только части данных

### 3. Базовая ошибка
Игнорирование базовых вероятностей

### 4. Средние значения
Могут скрывать важные детали

## Визуализация данных
### Эффективные графики:
- Столбчатые диаграммы для сравнения
- Линейные графики для трендов
- Круговые диаграммы для долей (до 5 сегментов)

### Манипулятивная визуализация:
- Обрезанные оси
- Неподходящий масштаб
- 3D-эффекты без необходимости', 'https://www.youtube.com/watch?v=Foswckom4mc', 'Foswckom4mc', NULL, 0, '2025-06-02 09:25:38', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (66, 'Системное мышление', NULL, 'VIDEO', 'PROBLEM_SOLVING', 'INTERMEDIATE', 65, NULL, '# Системное мышление

## Цель урока
Развить способность видеть взаимосвязи и понимать системы как единое целое.

## Принципы системного мышления

### 1. Холистический подход
Система больше суммы своих частей

### 2. Взаимосвязанность
Изменение одного элемента влияет на всю систему

### 3. Цель системы
У каждой системы есть назначение

### 4. Структура определяет поведение
Изменение структуры меняет результаты

## Системные архетипы

### 1. Пределы роста
Быстрый рост → ограничивающий фактор → замедление

### 2. Перенос бремени
Симптоматическое решение → ослабление способности к фундаментальному решению

### 3. Трагедия общих ресурсов
Индивидуальная выгода → истощение общего ресурса

## Инструменты системного анализа

### 1. Диаграмма петель причинности
Визуализация причинно-следственных связей:
- **R** — усиливающие петли (рост)
- **B** — балансирующие петли (стабилизация)

### 2. Богатые картинки
Неформальное изображение ситуации со всеми участниками и связями

### 3. Iceberg Model
- **События** — что произошло?
- **Паттерны** — какие тренды?
- **Структуры** — что влияет на паттерны?
- **Ментальные модели** — какие убеждения создают структуры?

## Рычаги воздействия
По возрастанию эффективности:
1. Константы, числа
2. Материальные потоки
3. Правила системы
4. Распределение власти
5. Цели системы
6. Парадигма системы', 'https://www.youtube.com/watch?v=Inlq08Cfhh0', 'Inlq08Cfhh0', NULL, 0, '2025-06-02 09:25:38', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (67, 'Работа с противоположными мнениями', NULL, 'VIDEO', 'PROBLEM_SOLVING', 'INTERMEDIATE', 55, NULL, '# Работа с противоположными мнениями

## Цель урока
Научиться конструктивно работать с разногласиями и использовать их для улучшения решений.

## Ценность разногласий
### Преимущества:
- Выявление слабых мест
- Генерация новых идей
- Избежание группового мышления
- Повышение качества решений

## Техника "Адвокат дьявола"
Специально назначенная роль для критики идей:
1. Выявление предположений
2. Поиск контраргументов
3. Проверка логики
4. Поиск альтернатив

## Метод "За и против"
### Структурированный анализ:
1. Список аргументов "за"
2. Список аргументов "против"
3. Оценка силы каждого аргумента
4. Поиск компромиссов

## Диалектическое мышление
### Триада Гегеля:
- **Тезис** — исходное утверждение
- **Антитезис** — противоположное мнение
- **Синтез** — объединение лучшего из обеих позиций

## Активное слушание оппонентов
### Техники:
1. **Парафразирование** — "Правильно ли я понимаю..."
2. **Уточняющие вопросы** — "Что вы имеете в виду под..."
3. **Эмпатическое отражение** — "Вы чувствуете..."

## Поиск общих точек
1. Общие цели
2. Разделяемые ценности
3. Признанные факты
4. Области согласия

## Конструктивная конфронтация
- Фокус на идеях, не на личностях
- Использование фактов
- Открытость к изменению мнения
- Поиск win-win решений', 'https://www.youtube.com/watch?v=XDV5nGOsXDU', 'XDV5nGOsXDU', NULL, 0, '2025-06-02 09:25:38', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (68, 'Инновационное решение проблем', NULL, 'VIDEO', 'PROBLEM_SOLVING', 'INTERMEDIATE', 70, NULL, '# Инновационное решение проблем

## Цель урока
Освоить передовые методы поиска прорывных решений и инноваций.

## ТРИЗ (Теория решения изобретательских задач)
### Принципы:
1. Техническая система развивается по объективным законам
2. Развитие идет в направлении повышения идеальности
3. Развитие неравномерно
4. Изобретательские задачи и их решения имеют типы

### 40 принципов ТРИЗ (примеры):
- **Дробление** — разделить объект на части
- **Вынесение** — отделить мешающую часть
- **Динамичность** — сделать объект адаптивным
- **Обратить вред в пользу**

## Design Thinking
### 5 этапов:
1. **Эмпатия** — понимание пользователей
2. **Формулировка** — определение проблемы
3. **Идеация** — генерация идей
4. **Прототипирование** — создание MVP
5. **Тестирование** — проверка с пользователями

## Метод синектики
### Типы аналогий:
- **Прямая** — как это решается в природе/технике?
- **Личная** — если бы я был этим объектом?
- **Символическая** — краткая метафора
- **Фантастическая** — как бы это решили волшебники?

## Blue Ocean Strategy
### Поиск новых рынков:
- **Исключить** — какие факторы убрать?
- **Снизить** — что уменьшить?
- **Повысить** — что усилить?
- **Создать** — что добавить нового?

## Подрывные инновации
### Характеристики:
1. Начинаются в нишевых сегментах
2. Проще и дешевле существующих решений
3. Со временем улучшаются
4. Вытесняют традиционные решения', 'https://www.youtube.com/watch?v=0Z_9gt_q6NE', '0Z_9gt_q6NE', NULL, 0, '2025-06-02 09:25:38', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (69, 'Практическое применение и интеграция навыков', NULL, 'VIDEO', 'PROBLEM_SOLVING', 'INTERMEDIATE', 75, NULL, '# Практическое применение и интеграция навыков

## Цель урока
Интегрировать все изученные методы в комплексный подход к решению проблем.

## Интегрированная модель решения проблем

### Этап 1: Диагностика (Критическое мышление)
- Анализ ситуации
- Выявление истинной проблемы
- Сбор и оценка данных

### Этап 2: Генерация (Креативные методы)
- Мозговой штурм
- SCAMPER
- Латеральное мышление

### Этап 3: Анализ (Системное мышление)
- Рассмотрение взаимосвязей
- Оценка последствий
- Поиск рычагов воздействия

### Этап 4: Принятие решения (Структурированный подход)
- Матрица решений
- Анализ рисков
- Проверка альтернатив

### Этап 5: Реализация (Управление изменениями)
- Планирование внедрения
- Работа с сопротивлением
- Мониторинг результатов

## Персональный набор инструментов
### Создайте свой toolkit:
1. **Для анализа проблем** — любимые техники диагностики
2. **Для генерации идей** — предпочитаемые креативные методы
3. **Для принятия решений** — проверенные подходы
4. **Для реализации** — эффективные стратегии внедрения

## Развитие навыков решения проблем
### Регулярные практики:
- **Ежедневно** — задавать уточняющие вопросы
- **Еженедельно** — анализировать одну проблему системно
- **Ежемесячно** — применять новый метод
- **Ежеквартально** — оценивать эффективность подходов

## Ментальные модели
### Полезные фреймворки:
- **First Principles** — разложение на основы
- **Inversion** — мышление от противного
- **Circle of Competence** — знание границ экспертизы
- **Mental Models Checklist** — список для проверки мышления

## Создание культуры решения проблем
### В команде:
1. Поощрение вопросов
2. Принятие ошибок как обучения
3. Документирование решений
4. Обмен лучшими практиками', 'https://www.youtube.com/watch?v=bb_OLMxBSfk', 'bb_OLMxBSfk', NULL, 0, '2025-06-02 09:25:38', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (70, 'Основы эффективной командной работы', NULL, 'VIDEO', 'TEAMWORK', 'BEGINNER', 50, NULL, '# Основы эффективной командной работы

## Цель урока
Понять принципы создания и функционирования высокопроизводительных команд.

## Что такое команда?
Команда — это группа людей с взаимодополняющими навыками, объединенных общей целью и несущих взаимную ответственность за результат.

### Отличия команды от группы:
- **Общая цель** vs индивидуальные задачи
- **Взаимозависимость** vs независимость
- **Коллективная ответственность** vs индивидуальная
- **Синергия** vs сумма усилий

## Стадии развития команды (Такман)
### 1. Формирование (Forming)
- Знакомство участников
- Неопределенность ролей
- Зависимость от лидера

### 2. Штормование (Storming)
- Конфликты и разногласия
- Борьба за лидерство
- Сопротивление задачам

### 3. Нормирование (Norming)
- Выработка правил
- Укрепление сплоченности
- Распределение ролей

### 4. Выполнение (Performing)
- Высокая производительность
- Автономность
- Взаимная поддержка

### 5. Расформирование (Adjourning)
- Завершение проекта
- Рефлексия опыта
- Эмоциональное завершение

## Характеристики эффективных команд
- **Психологическая безопасность**
- **Ясность целей и ролей**
- **Доверие и открытость**
- **Эффективная коммуникация**
- **Навыки решения конфликтов**', 'https://www.youtube.com/watch?v=cklqtXopXGI', 'cklqtXopXGI', NULL, 0, '2025-06-02 09:27:50', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (71, 'Роли в команде и их динамика', NULL, 'VIDEO', 'TEAMWORK', 'BEGINNER', 55, NULL, '# Роли в команде и их динамика

## Цель урока
Изучить различные командные роли и научиться эффективно взаимодействовать в многообразной команде.

## Командные роли по Белбину

### Роли, ориентированные на действие:
- **Исполнитель** — надежный, дисциплинированный
- **Завершитель** — тщательный, добросовестный
- **Формирователь** — энергичный, бросает вызов

### Роли, ориентированные на людей:
- **Координатор** — зрелый, уверенный, хороший председатель
- **Работник команды** — миротворец, дипломат
- **Исследователь ресурсов** — экстравертный, коммуникабельный

### Роли, ориентированные на мышление:
- **Мыслитель** — творческий, неординарный
- **Аналитик** — рассудительный, стратегически мыслящий
- **Специалист** — целеустремленный, преданный делу

## Баланс ролей в команде
### Оптимальная команда включает:
- Разнообразие ролей
- Покрытие всех ключевых функций
- Минимальное дублирование
- Компенсацию слабых сторон

## Адаптация стиля взаимодействия
### В зависимости от роли партнера:
- **С исполнителями** — четкие инструкции
- **С мыслителями** — время на размышления
- **С работниками команды** — эмоциональная поддержка
- **С формирователями** — конструктивные дискуссии

## Развитие гибкости ролей
- Осознание своей естественной роли
- Развитие дополнительных ролей
- Адаптация к потребностям команды
- Временное принятие нужных ролей', 'https://www.youtube.com/watch?v=QXIzhKKTLdE', 'QXIzhKKTLdE', NULL, 0, '2025-06-02 09:27:50', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (72, 'Построение доверия в команде', NULL, 'VIDEO', 'TEAMWORK', 'BEGINNER', 60, NULL, '# Построение доверия в команде

## Цель урока
Изучить механизмы формирования доверия и научиться создавать атмосферу взаимного уважения.

## Пирамида доверия (Ленсиони)
### Уровень 1: Уязвимость
- Признание ошибок
- Просьба о помощи
- Открытость к критике

### Уровень 2: Конструктивный конфликт
- Открытые дискуссии
- Выражение несогласия
- Фокус на идеях, не на личностях

### Уровень 3: Приверженность
- Активное участие в решениях
- Поддержка командных решений
- Четкость в обязательствах

### Уровень 4: Подотчетность
- Взаимный контроль
- Прямые разговоры о проблемах
- Высокие стандарты

### Уровень 5: Результат
- Фокус на командных целях
- Готовность жертвовать личными интересами
- Гордость за командные достижения

## Компоненты доверия
### Компетентность
- Профессиональные навыки
- Надежность в выполнении
- Качество работы

### Характер
- Честность и интегритет
- Последовательность действий
- Искренние намерения

### Забота
- Интерес к благополучию других
- Эмпатия и понимание
- Готовность помочь

## Действия для построения доверия
### Личный уровень:
- Держать обещания
- Признавать ошибки
- Быть предсказуемым
- Проявлять искренний интерес

### Командный уровень:
- Прозрачная коммуникация
- Справедливое распределение ресурсов
- Последовательные стандарты
- Празднование успехов', 'https://www.youtube.com/watch?v=YVxBlWs4-5M', 'YVxBlWs4-5M', NULL, 0, '2025-06-02 09:27:50', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (73, 'Эффективная коммуникация в команде', NULL, 'VIDEO', 'TEAMWORK', 'BEGINNER', 65, NULL, '# Эффективная коммуникация в команде

## Цель урока
Освоить техники командной коммуникации и создать систему обмена информацией.

## Принципы командной коммуникации
### 1. Открытость и прозрачность
- Своевременное информирование
- Доступность информации
- Честность в сообщениях

### 2. Активное слушание
- Полное внимание к говорящему
- Уточняющие вопросы
- Подтверждение понимания

### 3. Конструктивная обратная связь
- Специфичность и своевременность
- Фокус на поведении, не на личности
- Баланс между похвалой и критикой

## Модель эффективного общения
### 1. Подготовка
- Четкая цель сообщения
- Анализ аудитории
- Выбор подходящего канала

### 2. Передача
- Ясность и краткость
- Соответствующий тон
- Невербальные сигналы

### 3. Проверка понимания
- Вопросы для уточнения
- Парафразирование
- Подтверждение договоренностей

## Инструменты командной коммуникации
### Синхронная коммуникация:
- Встречи и совещания
- Видеоконференции
- Мгновенные сообщения

### Асинхронная коммуникация:
- Email и документы
- Системы управления проектами
- Общие рабочие пространства

## Управление конфликтами в коммуникации
### Техника "Я-сообщений":
1. Описание ситуации
2. Выражение чувств
3. Объяснение влияния
4. Просьба об изменении

### Метод "ЛИФТ":
- **Л**истенинг — слушание
- **И**нтересы — выявление потребностей
- **Ф**акты — объективная информация
- **Т**ворчество — поиск решений', 'https://www.youtube.com/watch?v=47I0C9ZrMA4', '47I0C9ZrMA4', NULL, 0, '2025-06-02 09:27:50', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (74, 'Коллективное принятие решений', NULL, 'VIDEO', 'TEAMWORK', 'BEGINNER', 55, NULL, '# Коллективное принятие решений

## Цель урока
Научиться эффективно принимать решения в команде и достигать консенсуса.

## Методы командного принятия решений

### 1. Консенсус
**Плюсы:** Высокая поддержка, качественные решения
**Минусы:** Медленный процесс, возможная размытость

### 2. Большинство голосов
**Плюсы:** Быстро и демократично
**Минусы:** Может создать "проигравших"

### 3. Делегирование эксперту
**Плюсы:** Использование экспертизы
**Минусы:** Меньшая вовлеченность команды

### 4. Авторитарное решение
**Плюсы:** Быстрота в критических ситуациях
**Минусы:** Низкая поддержка команды

## Процесс достижения консенсуса
### Этап 1: Определение проблемы
- Четкая формулировка вопроса
- Понимание контекста
- Определение критериев решения

### Этап 2: Генерация вариантов
- Мозговой штурм
- Анализ альтернатив
- Творческие подходы

### Этап 3: Обсуждение
- Открытый диалог
- Выявление за и против
- Уточнение позиций

### Этап 4: Конвергенция
- Поиск общих точек
- Компромиссы
- Модификация предложений

### Этап 5: Принятие решения
- Проверка согласия всех
- Формулировка решения
- План реализации

## Техники фасилитации
### Метод "Кулак - пять пальцев":
- 5 пальцев — полная поддержка
- 4 пальца — поддерживаю
- 3 пальца — могу жить с этим
- 2 пальца — есть сомнения
- 1 палец — серьезные возражения
- Кулак — блокирую решение

### Техника "Дот-вотинг":
Каждый участник получает точки для голосования за предпочтительные варианты', 'https://www.youtube.com/watch?v=MhNMb_W481g', 'MhNMb_W481g', NULL, 0, '2025-06-02 09:27:50', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (75, 'Управление конфликтами в команде', NULL, 'VIDEO', 'TEAMWORK', 'BEGINNER', 70, NULL, '# Управление конфликтами в команде

## Цель урока
Освоить навыки предотвращения, управления и разрешения командных конфликтов.

## Типы командных конфликтов
### 1. Конфликт задач
- Разногласия по целям и стратегиям
- Может быть полезен для поиска лучших решений

### 2. Процессный конфликт
- Разногласия о том, как выполнять работу
- Требует четких процедур

### 3. Межличностный конфликт
- Личная неприязнь
- Деструктивен для команды

## Стили управления конфликтами
### 1. Конкуренция (Win-Lose)
- Настаивание на своем
- Подходит в кризисных ситуациях

### 2. Приспособление (Lose-Win)
- Уступка другой стороне
- Полезно для сохранения отношений

### 3. Избегание (Lose-Lose)
- Игнорирование конфликта
- Временная мера

### 4. Компромисс (Lose-Lose)
- Взаимные уступки
- Быстрое решение

### 5. Сотрудничество (Win-Win)
- Поиск взаимовыгодного решения
- Наилучший долгосрочный подход

## Процесс разрешения конфликтов
### 1. Диагностика
- Выявление истинных причин
- Анализ позиций и интересов
- Оценка эмоционального состояния

### 2. Деэскалация
- Снижение эмоционального напряжения
- Создание безопасной атмосферы
- Установление правил диалога

### 3. Переговоры
- Активное слушание всех сторон
- Фокус на интересах, не позициях
- Генерация вариантов решения

### 4. Соглашение
- Четкие договоренности
- Взаимные обязательства
- План реализации

## Роль медиатора в команде
### Навыки медиатора:
- Нейтральность
- Активное слушание
- Управление процессом
- Креативность в поиске решений

### Техники медиации:
- Рефрейминг — переформулирование
- Разделение позиций и интересов
- Генерация альтернатив
- Проверка реалистичности решений', 'https://www.youtube.com/watch?v=_sypItO78jE', '_sypItO78jE', NULL, 0, '2025-06-02 09:27:50', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (76, 'Мотивация и вовлеченность команды', NULL, 'VIDEO', 'TEAMWORK', 'BEGINNER', 60, NULL, '# Мотивация и вовлеченность команды

## Цель урока
Изучить факторы командной мотивации и методы повышения вовлеченности участников.

## Теория мотивации в командах
### Внутренняя мотивация (Self-Determination Theory):
- **Автономия** — свобода выбора и контроля
- **Мастерство** — развитие навыков и компетенций
- **Цель** — значимость и смысл работы

### Командная мотивация:
- **Принадлежность** — чувство части команды
- **Признание** — оценка вклада
- **Влияние** — возможность влиять на результат

## Драйверы командной вовлеченности
### 1. Ясность целей
- Понимание миссии команды
- Связь личных и командных целей
- Измеримые результаты

### 2. Роль и ответственность
- Четкое понимание своей роли
- Соответствие навыков и задач
- Возможности для роста

### 3. Поддержка и ресурсы
- Доступ к необходимым инструментам
- Поддержка руководства
- Обучение и развитие

### 4. Признание и вознаграждение
- Справедливая оценка вклада
- Публичное признание
- Карьерные возможности

## Инструменты повышения мотивации
### 1. Постановка целей команды
- SMART-цели для команды
- Каскадирование целей
- Регулярный мониторинг

### 2. Ротация ролей
- Развитие новых навыков
- Предотвращение выгорания
- Взаимопонимание

### 3. Командные ритуалы
- Еженедельные ретроспективы
- Празднование успехов
- Командные мероприятия

### 4. Автономия в выполнении
- Выбор методов работы
- Гибкий график
- Самоорганизация

## Измерение вовлеченности
### Индикаторы:
- Инициативность
- Готовность помочь коллегам
- Участие в обсуждениях
- Удовлетворенность работой', 'https://www.youtube.com/watch?v=Mhdyto5KZe8', 'Mhdyto5KZe8', NULL, 0, '2025-06-02 09:27:50', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (77, 'Виртуальная командная работа', NULL, 'VIDEO', 'TEAMWORK', 'BEGINNER', 55, NULL, '# Виртуальная командная работа

## Цель урока
Освоить особенности управления удаленными командами и эффективного онлайн-сотрудничества.

## Вызовы виртуальных команд
### Коммуникационные:
- Потеря невербальных сигналов
- Задержки в обратной связи
- Технические проблемы

### Социальные:
- Снижение неформального общения
- Труднее строить доверие
- Изоляция участников

### Процессные:
- Координация часовых поясов
- Различия в технологиях
- Контроль выполнения задач

## Принципы виртуального лидерства
### 1. Сверхкоммуникация
- Более частое общение
- Четкость сообщений
- Подтверждение понимания

### 2. Структурированность
- Четкие процессы
- Регулярные проверки
- Документирование решений

### 3. Построение отношений
- Время для неформального общения
- Виртуальные тимбилдинги
- Личные встречи при возможности

### 4. Гибкость
- Адаптация к часовым поясам
- Различные стили работы
- Технологические предпочтения

## Инструменты виртуального сотрудничества
### Коммуникация:
- Видеоконференции (Zoom, Teams)
- Мессенджеры (Slack, Teams Chat)
- Асинхронное общение (email, форумы)

### Совместная работа:
- Облачные документы (Google Docs, Office 365)
- Доски для совместной работы (Miro, Mural)
- Системы управления проектами (Jira, Trello)

### Социальное взаимодействие:
- Виртуальные кофе-брейки
- Онлайн-игры и активности
- Социальные каналы в мессенджерах

## Этикет виртуальных встреч
### Подготовка:
- Проверка технологий
- Четкая повестка
- Предварительные материалы

### Проведение:
- Управление временем
- Активное вовлечение
- Интерактивные элементы

### Следование:
- Краткое резюме
- Четкие следующие шаги
- Обратная связь о встрече', 'https://www.youtube.com/watch?v=Z8FZYmQcIZ4', 'Z8FZYmQcIZ4', NULL, 0, '2025-06-02 09:27:50', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (78, 'Развитие и обучение команды', NULL, 'VIDEO', 'TEAMWORK', 'BEGINNER', 65, NULL, '# Развитие и обучение команды

## Цель урока
Создать систему непрерывного развития команды и индивидуального роста участников.

## Принципы командного обучения
### 1. Обучающаяся организация
- Культура экспериментирования
- Извлечение уроков из ошибок
- Обмен знаниями

### 2. Коллективное обучение
- Обучение в процессе работы
- Взаимное наставничество
- Командные ретроспективы

### 3. Развитие T-shaped навыков
- Глубокая экспертиза в одной области
- Широкие знания в смежных областях
- Навыки сотрудничества

## Модели командного развития
### 1. Модель 70-20-10
- **70%** — обучение через опыт
- **20%** — обучение от других
- **10%** — формальное обучение

### 2. Цикл Колба
- **Опыт** — практическая деятельность
- **Рефлексия** — анализ произошедшего
- **Теория** — поиск закономерностей
- **Эксперимент** — применение новых знаний

## Инструменты развития команды
### 1. Ретроспективы
- Регулярный анализ работы
- Выявление улучшений
- Планирование изменений

### 2. Внутреннее обучение
- Презентации экспертизы
- Мастер-классы коллег
- Ротация ролей

### 3. Внешнее обучение
- Конференции и семинары
- Онлайн-курсы
- Сертификация

### 4. Коучинг и менторинг
- Индивидуальное развитие
- Передача опыта
- Поддержка роста

## Планирование развития
### Индивидуальные планы развития:
1. Оценка текущих навыков
2. Определение целей роста
3. Выбор методов развития
4. Временные рамки
5. Измерение прогресса

### Командный план развития:
1. Аудит командных компетенций
2. Определение пробелов
3. Приоритизация областей развития
4. Создание программы обучения
5. Мониторинг результатов

## Культура непрерывного обучения
### Элементы культуры:
- Время для обучения в рабочем графике
- Поощрение экспериментов
- Безопасность ошибок
- Обмен знаниями
- Измерение обучения', 'https://www.youtube.com/watch?v=waLDpEsS_nQ', 'waLDpEsS_nQ', NULL, 0, '2025-06-02 09:27:50', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (79, 'Стратегическая коммуникация и влияние', NULL, 'VIDEO', 'COMMUNICATION', 'ADVANCED', 70, NULL, '# Стратегическая коммуникация и влияние

## Цель урока
Освоить продвинутые техники стратегической коммуникации для достижения бизнес-целей.

## Модель стратегической коммуникации
### 1. Анализ контекста
- **Стейкхолдеры** — кто принимает решения?
- **Политика** — какие интересы и альянсы?
- **Культура** — какие ценности и нормы?
- **Время** — какие временные ограничения?

### 2. Определение целей
- **SMART-цели** коммуникации
- **Краткосрочные** vs долгосрочные
- **Измеримые результаты**

### 3. Выбор стратегии
- **Push** — принуждение через авторитет
- **Pull** — привлечение через мотивацию
- **Nudge** — мягкое подталкивание

## Принципы влияния Чалдини 2.0
### Классические принципы:
1. **Взаимность** — люди отвечают добром на добро
2. **Обязательство** — соответствие своим словам
3. **Социальное доказательство** — следование за большинством
4. **Симпатия** — согласие с теми, кто нравится
5. **Авторитет** — подчинение экспертам
6. **Дефицит** — ценность редкого

### Новый 7-й принцип:
7. **Единство** — "мы" вместо "я и вы"

## Техники стратегического фрейминга
### Фрейм выгоды vs фрейм потерь
- **Позитивный фрейм:** "Получите 90% эффективности"
- **Негативный фрейм:** "Избегните 10% потерь"

### Фрейм проблемы vs фрейм возможности
- **Проблемный:** "Устранить недостатки"
- **Возможностный:** "Реализовать потенциал"

## Управление сопротивлением
### Источники сопротивления:
- **Страх потерь** — статуса, контроля, компетентности
- **Недоверие** — к мотивам, способностям
- **Неясность** — целей, процесса, выгод

### Стратегии преодоления:
1. **Активное слушание** сопротивления
2. **Адресация страхов** напрямую
3. **Вовлечение** в процесс решения
4. **Постепенность** изменений', 'https://www.youtube.com/watch?v=bmhdvziMCX4', 'bmhdvziMCX4', NULL, 0, '2025-06-02 09:31:20', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (80, 'Мастерство переговоров', NULL, 'VIDEO', 'COMMUNICATION', 'ADVANCED', 75, NULL, '# Мастерство переговоров

## Цель урока
Развить продвинутые навыки ведения переговоров в сложных бизнес-ситуациях.

## Подготовка к переговорам
### Анализ BATNA
- **B**est **A**lternative **T**o **N**egotiated **A**greement
- Что происходит, если переговоры провалятся?
- Укрепление собственной BATNA
- Ослабление BATNA оппонента

### Зона возможного соглашения (ZOPA)
- Минимум, на который готовы вы
- Максимум, на который готов оппонент
- Поиск пересечений

### Исследование интересов
- **Позиции** — что хотят
- **Интересы** — почему хотят
- **Потребности** — что действительно нужно

## Стратегии переговоров
### 1. Конкурентная (Win-Lose)
- Максимизация собственной выгоды
- Применение давления
- Скрытие информации

### 2. Кооперативная (Win-Win)
- Поиск взаимной выгоды
- Открытый обмен информацией
- Совместное решение проблем

### 3. Адаптивная
- Изменение стратегии по ходу
- Чтение сигналов оппонента
- Гибкое реагирование

## Тактики ведения переговоров
### Конструктивные тактики:
- **Опционы** — генерация альтернатив
- **Пакетирование** — связка вопросов
- **Условные предложения** — "если..., то..."
- **Этапность** — разбивка на стадии

### Деструктивные тактики (защита):
- **Ультиматумы** — "последнее предложение"
- **Эмоциональные атаки** — давление и угрозы
- **Дедлайны** — искусственные ограничения
- **Якорение** — крайние первоначальные предложения

## Управление эмоциями в переговорах
### Техника "Разделения"
1. **Отделить** людей от проблемы
2. **Сфокусироваться** на интересах
3. **Генерировать** варианты
4. **Использовать** объективные критерии

### Работа с агрессией
- Не отвечать агрессией на агрессию
- Перенаправлять на проблему
- Использовать "айкидо" — перенаправление энергии

## Международные переговоры
### Культурные различия:
- **Монохронные** vs **полихронные** культуры
- **Высокий** vs **низкий** контекст
- **Индивидуализм** vs **коллективизм**
- **Дистанция власти**', 'https://www.youtube.com/watch?v=vogCSEO_CB8', 'vogCSEO_CB8', NULL, 0, '2025-06-02 09:31:20', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (81, 'Искусство презентаций высокого уровня', NULL, 'VIDEO', 'COMMUNICATION', 'ADVANCED', 80, NULL, '# Искусство презентаций высокого уровня

## Цель урока
Овладеть мастерством создания и проведения убедительных презентаций для топ-менеджмента.

## Структура executive-презентации
### Пирамида Минто
1. **Заключение** — главное сообщение вначале
2. **Группировка** — логическое объединение идей
3. **Порядок** — логическая последовательность
4. **Резюме** — краткое подведение итогов

### SCRAP-структура
- **S**ituation — ситуация
- **C**omplication — проблема
- **R**esolution — решение
- **A**ction — действия
- **P**ayoff — результат

## Сторителлинг в бизнес-презентациях
### Элементы истории:
- **Герой** — кто главный персонаж?
- **Вызов** — какая проблема?
- **Путешествие** — как решали?
- **Трансформация** — что изменилось?

### Типы бизнес-историй:
- **Истории проблем** — для обоснования изменений
- **Истории успеха** — для мотивации
- **Истории видения** — для вдохновения
- **Истории ценностей** — для культуры

## Работа с данными
### Правило 6x6
- Максимум 6 строк
- Максимум 6 слов в строке
- Размер шрифта не менее 24

### Визуализация данных:
- **Тренды** — линейные графики
- **Сравнения** — столбчатые диаграммы
- **Части целого** — круговые диаграммы
- **Корреляции** — точечные диаграммы

## Техники убеждения в презентациях
### Этос, Пафос, Логос (Аристотель)
- **Этос** — доверие к спикеру
- **Пафос** — эмоциональная связь
- **Логос** — логические аргументы

### Техника "Проблема-Агитация-Решение"
1. **Проблема** — что не так?
2. **Агитация** — почему это критично?
3. **Решение** — как исправить?

## Управление вопросами и возражениями
### Типы вопросов:
- **Уточняющие** — для понимания
- **Провокационные** — для проверки
- **Скептические** — выражение сомнений
- **Политические** — скрытые мотивы

### Техника ПИРС:
- **П**ауза — обдумать ответ
- **И**нтерес — показать заинтересованность
- **Р**ефрейминг — переформулировать при необходимости
- **С**одержательный ответ

## Работа с враждебной аудиторией
### Стратегии:
1. **Признание** различий во мнениях
2. **Поиск** общих точек
3. **Постепенное** изменение восприятия
4. **Фокус** на фактах, не эмоциях', 'https://www.youtube.com/watch?v=kAEJodCpxyk', 'kAEJodCpxyk', NULL, 0, '2025-06-02 09:31:20', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (82, 'Управление репутацией и личным брендом', NULL, 'VIDEO', 'COMMUNICATION', 'ADVANCED', 65, NULL, '# Управление репутацией и личным брендом

## Цель урока
Научиться стратегически управлять своей профессиональной репутацией и коммуникационным имиджем.

## Анатомия личного бренда
### Компоненты бренда:
- **Экспертиза** — в чем вы эксперт?
- **Ценности** — что для вас важно?
- **Личность** — как вы общаетесь?
- **Визуал** — как вы выглядите?

### Матрица позиционирования
| | Высокая видимость | Низкая видимость |
|--|-------------------|------------------|
| **Высокая ценность** | Звезда | Скрытая жемчужина |
| **Низкая ценность** | Самопродавец | Невидимка |

## Стратегии построения репутации
### 1. Экспертное позиционирование
- **Нишевание** — выбор специализации
- **Контент-маркетинг** — статьи, выступления
- **Мысленное лидерство** — новые идеи
- **Наставничество** — развитие других

### 2. Нетворкинг и альянсы
- **Стратегический нетворкинг** — целевые связи
- **Взаимная поддержка** — win-win отношения
- **Кросс-промоушн** — взаимная реклама
- **Альянсы** — долгосрочные партнерства

### 3. Цифровое присутствие
- **LinkedIn-стратегия** — профессиональная сеть
- **Контент-план** — регулярные публикации
- **Мониторинг репутации** — отслеживание упоминаний
- **Кризис-менеджмент** — работа с негативом

## Техники повышения видимости
### Внутри организации:
- **Добровольные проекты** — инициативность
- **Презентации достижений** — регулярная отчетность
- **Наставничество коллег** — помощь в развитии
- **Участие в комитетах** — влияние на решения

### Во внешней среде:
- **Публичные выступления** — конференции, подкасты
- **Публикации** — статьи, блоги, книги
- **Медиа-участие** — интервью, комментарии
- **Профессиональные ассоциации** — лидерство в сообществах

## Коммуникация в кризисе
### Принципы кризисной коммуникации:
1. **Скорость** — быстрая реакция
2. **Честность** — открытое признание фактов
3. **Ответственность** — принятие на себя
4. **Действия** — конкретные шаги по исправлению

### Модель SOAR:
- **S**top — остановить распространение
- **O**wn — взять ответственность
- **A**pologize — извиниться если нужно
- **R**espond — действовать по исправлению

## Измерение репутации
### Качественные метрики:
- **360-градусная обратная связь**
- **Репутационные опросы**
- **Анализ сетевой позиции**
- **Медиа-мониторинг**

### Количественные метрики:
- **Размер сети** — количество контактов
- **Активность** — частота взаимодействий
- **Охват** — количество людей в аудитории
- **Вовлеченность** — реакции на контент', 'https://www.youtube.com/watch?v=P6k2id_AJko', 'P6k2id_AJko', NULL, 0, '2025-06-02 09:31:20', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (83, 'Межкультурная деловая коммуникация', NULL, 'VIDEO', 'COMMUNICATION', 'ADVANCED', 70, NULL, '# Межкультурная деловая коммуникация

## Цель урока
Развить навыки эффективной коммуникации в мультикультурной бизнес-среде.

## Модель культурных различий Хофстеде
### 6 измерений культуры:
1. **Дистанция власти** — иерархия vs равенство
2. **Индивидуализм** — личность vs коллектив
3. **Мужественность** — конкуренция vs сотрудничество
4. **Избегание неопределенности** — правила vs гибкость
5. **Ориентация на время** — традиции vs изменения
6. **Потворство** — контроль vs свобода

### Практическое применение:
- **Высокая дистанция власти** — формальность, титулы
- **Коллективизм** — групповые решения, гармония
- **Высокое избегание неопределенности** — детальные планы

## Модели коммуникации
### Высокий vs низкий контекст (Холл)
#### Высокий контекст:
- Неявная информация
- Невербальные сигналы важны
- Отношения первичны
- Примеры: Япония, Корея, арабские страны

#### Низкий контекст:
- Прямая коммуникация
- Слова важнее контекста
- Задачи первичны
- Примеры: Германия, Скандинавия, США

## Стили принятия решений
### Консенсусные культуры:
- Долгое обсуждение
- Участие всех заинтересованных
- Медленное принятие, быстрое исполнение
- Примеры: Япония, Нидерланды

### Авторитарные культуры:
- Быстрое принятие решений
- Роль лидера критична
- Быстрое принятие, медленное исполнение
- Примеры: Россия, Китай

## Переговоры в разных культурах
### Отношенческие культуры:
- Важность установления отношений
- Личные встречи и ужины
- Долгосрочная перспектива
- Терпение в процессе

### Транзакционные культуры:
- Фокус на деловых аспектах
- Прямолинейность в переговорах
- Краткосрочные результаты
- Эффективность процесса

## Управление мультикультурными командами
### Вызовы:
- **Языковые барьеры** — понимание и выражение
- **Временные зоны** — координация активности
- **Стили работы** — индивидуальные vs командные
- **Ожидания** — от лидерства и участия

### Стратегии:
1. **Культурная осведомленность** — изучение особенностей
2. **Инклюзивное лидерство** — учет всех голосов
3. **Адаптация стиля** — гибкость в подходах
4. **Создание общей культуры** — командные нормы

## Протокол и этикет
### Деловые встречи:
- **Пунктуальность** — важность времени
- **Приветствие** — рукопожатия, поклоны
- **Обмен визитками** — ритуалы и правила
- **Подарки** — уместность и ограничения

### Деловые ужины:
- **Разговоры** — личные vs деловые темы
- **Алкоголь** — культурные нормы
- **Оплата** — кто платит за ужин
- **Тосты** — традиции и этикет', 'https://www.youtube.com/watch?v=sbrdIwmATv8', 'sbrdIwmATv8', NULL, 0, '2025-06-02 09:31:20', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (84, 'Цифровая коммуникация и социальные медиа', NULL, 'VIDEO', 'COMMUNICATION', 'ADVANCED', 60, NULL, '# Цифровая коммуникация и социальные медиа

## Цель урока
Освоить продвинутые стратегии цифровой коммуникации для профессионального развития.

## Экосистема цифровой коммуникации
### Платформы и их специфика:
- **LinkedIn** — профессиональный нетворкинг
- **Twitter** — мысленное лидерство, новости
- **Medium** — длинные аналитические статьи
- **YouTube** — видео-контент, обучение
- **Clubhouse** — аудио-дискуссии

### Выбор платформ:
1. **Где ваша аудитория?** — исследование присутствия
2. **Какой формат контента?** — текст, видео, аудио
3. **Сколько времени?** — ресурсы на поддержку
4. **Какие цели?** — продажи, найм, экспертиза

## Контент-стратегия для профессионалов
### Модель 4E:
- **E**ducate — обучайте аудиторию
- **E**ngage — вовлекайте в диалог
- **E**ntertain — развлекайте качественно
- **E**nthuse — вдохновляйте на действия

### Правило 80/20:
- **80%** — полезный контент для аудитории
- **20%** — продвижение себя и услуг

### Контент-календарь:
- **Понедельник** — мотивация и планы
- **Среда** — образовательный контент
- **Пятница** — инсайты и размышления

## Техники вовлечения аудитории
### Формат постов:
- **Истории** — personal experiences
- **Списки** — практические советы
- **Вопросы** — стимулирование дискуссий
- **Карусели** — пошаговые инструкции

### Элементы виральности:
1. **Эмоциональный крючок** — первые 3 секунды
2. **Персональная история** — человечность
3. **Практическая ценность** — применимость
4. **Призыв к действию** — что делать дальше

## Управление онлайн-репутацией
### Мониторинг:
- **Google Alerts** — упоминания имени
- **Социальные медиа** — мониторинг тегов
- **Профессиональные форумы** — отраслевые обсуждения
- **Рейтинговые сайты** — отзывы и оценки

### Реагирование:
- **Позитивные отзывы** — благодарность и усиление
- **Негативные отзывы** — быстрое и конструктивное реагирование
- **Нейтральные упоминания** — возможность для вовлечения

## Этика цифровой коммуникации
### Принципы:
1. **Аутентичность** — быть собой
2. **Прозрачность** — открытость мотивов
3. **Уважение** — к чужим мнениям
4. **Конфиденциальность** — защита частной информации

### Избегать:
- **Оверпостинга** — спам и навязчивость
- **Политических споров** — профессиональная нейтральность
- **Персональных атак** — фокус на идеях
- **Clickbait** — честные заголовки

## Измерение эффективности
### Количественные метрики:
- **Охват** — количество просмотров
- **Вовлеченность** — лайки, комментарии, репосты
- **Прирост подписчиков** — рост аудитории
- **Клики** — переходы на сайт

### Качественные метрики:
- **Качество комментариев** — глубина дискуссий
- **Профиль аудитории** — релевантность подписчиков
- **Бизнес-результаты** — лиды, возможности
- **Репутационные изменения** — восприятие бренда', 'https://www.youtube.com/watch?v=S5ZyoQsdGZo', 'S5ZyoQsdGZo', NULL, 0, '2025-06-02 09:31:20', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (85, 'Кризисная коммуникация', NULL, 'VIDEO', 'COMMUNICATION', 'ADVANCED', 65, NULL, '# Кризисная коммуникация

## Цель урока
Научиться эффективно коммуницировать в кризисных ситуациях и управлять коммуникационными рисками.

## Типы кризисов
### По источнику:
- **Внутренние** — ошибки управления, сотрудников
- **Внешние** — форс-мажор, атаки конкурентов
- **Смешанные** — взаимодействие факторов

### По скорости развития:
- **Медленные** — постепенное нарастание
- **Быстрые** — внезапное возникновение
- **Периодические** — повторяющиеся проблемы

### По масштабу:
- **Локальные** — отдельное подразделение
- **Корпоративные** — вся организация
- **Отраслевые** — влияние на сектор

## Принципы кризисной коммуникации
### Золотое правило времени:
- **Первый час** — критически важен
- **Первые сутки** — формирование narrative
- **Первая неделя** — закрепление восприятия

### 4 столпа кризисной коммуникации:
1. **Быстрота** — опережение слухов
2. **Честность** — фактическая точность
3. **Эмпатия** — понимание переживаний
4. **Действия** — конкретные шаги

## Модель кризисного реагирования
### Фаза 1: Немедленная реакция (0-6 часов)
- **Сбор фактов** — что произошло?
- **Оценка рисков** — масштаб проблемы?
- **Мобилизация команды** — кто отвечает?
- **Первое заявление** — базовая позиция

### Фаза 2: Углубленная реакция (6-48 часов)
- **Детальное расследование** — глубокий анализ
- **Стратегия коммуникации** — key messages
- **Работа с СМИ** — интервью и брифинги
- **Внутренние коммуникации** — информирование сотрудников

### Фаза 3: Восстановление (48+ часов)
- **План восстановления** — конкретные действия
- **Долгосрочная коммуникация** — регулярные обновления
- **Мониторинг репутации** — отслеживание эффектов
- **Извлечение уроков** — анализ и улучшения

## Техники коммуникации в кризисе
### Структура заявлений:
1. **Выражение озабоченности** — эмпатия
2. **Факты** — что известно на данный момент
3. **Действия** — что предпринимается
4. **Следующие шаги** — план дальнейших действий

### Работа с СМИ:
- **Определить спикера** — один голос организации
- **Подготовить key messages** — 3-5 ключевых сообщений
- **Тренировка интервью** — отработка сложных вопросов
- **Мониторинг освещения** — отслеживание публикаций

## Цифровая кризисная коммуникация
### Особенности социальных медиа:
- **Скорость распространения** — вирусный эффект
- **Эмоциональность** — усиление реакций
- **Фрагментация** — множество версий
- **Постоянство** — следы остаются навсегда

### Стратегии для соцсетей:
1. **Активный мониторинг** — отслеживание упоминаний
2. **Быстрое реагирование** — ответы в течение часа
3. **Единообразие сообщений** — одинаковая позиция везде
4. **Переключение в приват** — сложные вопросы в личные сообщения

## Восстановление после кризиса
### Оценка ущерба:
- **Репутационный** — изменение восприятия
- **Финансовый** — потери в деньгах
- **Операционный** — нарушение процессов
- **Кадровый** — влияние на персонал

### Программа восстановления:
1. **Компенсация** — возмещение ущерба
2. **Изменения** — системные улучшения
3. **Коммуникация** — информирование о прогрессе
4. **Мониторинг** — отслеживание восприятия', 'https://www.youtube.com/watch?v=NQGGXkhCo2M', 'NQGGXkhCo2M', NULL, 0, '2025-06-02 09:31:20', NULL);
INSERT INTO learning_materials (id, title, description, content_type, skill_type, difficulty_level, duration_minutes, author, theory_content, video_url, video_id, source_url, is_published, created_at, updated_at) VALUES (86, 'Лидерская коммуникация и видение', NULL, 'VIDEO', 'COMMUNICATION', 'ADVANCED', 75, NULL, '# Лидерская коммуникация и видение

## Цель урока
Развить навыки вдохновляющей лидерской коммуникации и трансляции видения.

## Анатомия лидерской коммуникации
### Отличия от менеджерской коммуникации:
- **Вдохновение** vs информирование
- **Видение** vs планы
- **Эмоции** vs факты
- **Трансформация** vs управление

### 4 уровня лидерской коммуникации:
1. **Директивная** — что делать
2. **Объяснительная** — почему делать
3. **Вовлекающая** — как участвовать
4. **Трансформирующая** — зачем это важно

## Создание и трансляция видения
### Элементы убедительного видения:
- **Ясность** — понятность для всех
- **Краткость** — запоминаемость
- **Вдохновение** — эмоциональная привлекательность
- **Амбициозность** — дерзкий вызов
- **Конкретность** — измеримые результаты

### Техника "Золотой круг" (Саймон Синек):
- **Why** — зачем мы это делаем?
- **How** — как мы это делаем по-особенному?
- **What** — что мы конкретно делаем?

### Формула видения:
"К [дата] мы [кто] станем [позиция/состояние], чтобы [высшая цель], что позволит [воздействие на мир]"

## Сторителлинг для лидеров
### Типы лидерских историй:
1. **Истории происхождения** — почему мы начали
2. **Истории борьбы** — как преодолевали трудности
3. **Истории успеха** — чего добились вместе
4. **Истории будущего** — куда идем дальше

### Структура hero''s journey:
- **Обычный мир** — исходная ситуация
- **Призыв к приключению** — вызов/возможность
- **Отказ от призыва** — сомнения и страхи
- **Встреча с наставником** — получение помощи
- **Пересечение порога** — начало пути
- **Испытания** — преодоление препятствий
- **Награда** — достижение цели
- **Возвращение** — применение опыта

## Эмоциональное лидерство
### Техники создания эмоциональной связи:
- **Личные истории** — уязвимость и человечность
- **Общие ценности** — то, что нас объединяет
- **Коллективная гордость** — совместные достижения
- **Надежда на будущее** — оптимистичная перспектива

### Управление энергией команды:
1. **Диагностика** — оценка текущего состояния
2. **Настройка** — корректировка под задачи
3. **Поддержание** — сохранение нужного уровня
4. **Восстановление** — работа с выгоранием

## Коммуникация изменений
### Модель ADKAR:
- **A**wareness — осознание необходимости
- **D**esire — желание участвовать
- **K**nowledge — знание как изменяться
- **A**bility — способность внедрить навыки
- **R**einforcement — закрепление изменений

### 8 шагов коммуникации изменений (Коттер):
1. **Создание срочности** — почему сейчас?
2. **Формирование коалиции** — кто поддерживает?
3. **Создание видения** — куда идем?
4. **Трансляция видения** — как донести?
5. **Расширение полномочий** — как включить всех?
6. **Быстрые победы** — как показать прогресс?
7. **Закрепление изменений** — как сохранить?
8. **Институционализация** — как сделать нормой?

## Цифровое лидерство
### Особенности онлайн-лидерства:
- **Асинхронная коммуникация** — отложенные реакции
- **Множественные каналы** — разные платформы
- **Глобальная аудитория** — культурные различия
- **Постоянная видимость** — цифровые следы

### Инструменты цифрового лидера:
- **Видео-послания** — личная связь на расстоянии
- **Социальные сети** — прямая коммуникация
- **Подкасты** — углубленные размышления
- **Виртуальные мероприятия** — массовые выступления

## Измерение эффективности лидерской коммуникации
### Количественные показатели:
- **Вовлеченность сотрудников** — опросы и метрики
- **NPS лидера** — готовность рекомендовать
- **Достижение целей** — выполнение планов
- **Удержание талантов** — текучесть кадров

### Качественные индикаторы:
- **Энтузиазм команды** — энергия и мотивация
- **Инициативность** — самостоятельные действия
- **Лояльность** — поддержка в трудные времена
- **Гордость** — чувство принадлежности', 'https://www.youtube.com/watch?v=lOvEIpVCW0k', 'lOvEIpVCW0k', NULL, 0, '2025-06-02 09:31:20', NULL);

-- Данные для таблицы learning_tasks
DELETE FROM learning_tasks;
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (17, 21, 'Анализ использования времени', 'В течение дня записывайте каждые 30 минут, чем занимались. Вечером проанализируйте и распределите активности по матрице Эйзенхауэра.', 1, '2025-06-02T04:00:44.512513');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (18, 21, 'Создание еженедельного плана', 'Составьте план на неделю, используя принципы приоритизации. Выделите время для важных несрочных задач.', 2, '2025-06-02T04:00:44.512516');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (19, 22, 'Эксперимент с техникой Помодоро', 'Попробуйте технику Помодоро в течение рабочего дня. Отметьте, как изменилась ваша продуктивность и качество концентрации.', 1, '2025-06-02T04:00:44.512529');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (20, 22, 'Аудит отвлечений', 'Составьте список всех отвлечений в вашем рабочем дне. Разработайте стратегии для минимизации каждого из них.', 2, '2025-06-02T04:00:44.512534');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (21, 23, 'Карта автоматизации', 'Создайте список из 20 рутинных задач. Для каждой определите возможность автоматизации или делегирования.', 1, '2025-06-02T04:00:44.512546');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (22, 23, 'Внедрение одной автоматизации', 'Выберите одну задачу и автоматизируйте ее (например, настройте фильтры email или шаблоны ответов). Измерьте экономию времени.', 2, '2025-06-02T04:00:44.512549');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (23, 24, 'Анализ своего стиля общения', 'Проанализируйте, как вы обычно общаетесь с коллегами. Запишите 3 сильные стороны и 3 области для улучшения.', 1, '2025-06-02 08:35:10');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (24, 24, 'Наблюдение за невербальными сигналами', 'В течение дня обращайте внимание на жесты и мимику собеседников. Запишите, как невербальные сигналы влияли на понимание.', 2, '2025-06-02 08:35:10');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (25, 25, 'Практика активного слушания', 'В следующем разговоре с коллегой примените техники активного слушания. Запишите, как изменилось качество общения.', 1, '2025-06-02 08:35:10');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (26, 25, 'Упражнение на эмпатию', 'Выберите конфликтную ситуацию из вашего опыта. Попробуйте описать её с точки зрения всех участников.', 2, '2025-06-02 08:35:10');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (27, 26, 'Анализ собственного языка тела', 'Запишите видео своего выступления (1-2 минуты). Проанализируйте свои жесты, позу и мимику.', 1, '2025-06-02 08:35:10');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (28, 26, 'Упражнение ''Зеркало''', 'С партнером по очереди повторяйте жесты друг друга. Обратите внимание, как это влияет на понимание.', 2, '2025-06-02 08:35:10');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (29, 27, 'Анализ конфликтной ситуации', 'Вспомните недавний конфликт на работе. Определите его тип и проанализируйте, какая стратегия была бы наиболее эффективной.', 1, '2025-06-02 08:35:10');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (30, 27, 'Ролевая игра', 'С коллегой разыграйте конфликтную ситуацию, применяя техники деэскалации. Поменяйтесь ролями.', 2, '2025-06-02 08:35:10');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (31, 28, 'Практика модели SBI', 'Подготовьте обратную связь коллеге, используя модель SBI. Сначала запишите на бумаге, потом проведите разговор.', 1, '2025-06-02 08:35:10');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (32, 28, 'Дневник обратной связи', 'В течение недели записывайте всю полученную обратную связь и свои реакции на неё.', 2, '2025-06-02 08:35:10');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (33, 29, 'Мини-презентация', 'Подготовьте 5-минутную презентацию на рабочую тему. Запишите на видео и проанализируйте свою подачу.', 1, '2025-06-02 08:35:10');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (34, 29, 'Анализ TED-выступления', 'Посмотрите любое TED-выступление. Проанализируйте структуру, приёмы и эффективность подачи.', 2, '2025-06-02 08:35:10');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (35, 30, 'Аудит электронной почты', 'Проанализируйте последние 10 отправленных email. Оцените их по критериям эффективности.', 1, '2025-06-02 08:35:10');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (36, 30, 'Эксперимент с видеозвонками', 'Проведите видеовстречу с коллегой, применяя все правила этикета. Попросите обратную связь.', 2, '2025-06-02 08:35:10');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (37, 31, 'Исследование культуры', 'Выберите страну, с представителями которой вы работаете. Изучите особенности их деловой культуры.', 1, '2025-06-02 08:35:10');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (38, 31, 'Практика адаптации', 'В следующем разговоре с иностранным коллегой адаптируйте свой стиль общения под их культурные особенности.', 2, '2025-06-02 08:35:10');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (39, 32, 'Дневник эмоций', 'Неделю записывайте свои эмоции на работе: что их вызвало, как отреагировали, что можно улучшить.', 1, '2025-06-02 08:35:10');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (40, 32, 'Практика техники STOP', 'При следующей стрессовой ситуации примените технику STOP. Запишите результат.', 2, '2025-06-02 08:35:10');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (41, 33, 'Комплексный кейс: Сложная встреча', 'Проведите встречу с коллегами, где есть конфликтная ситуация. Примените все изученные техники: активное слушание, управление эмоциями, поиск решений. Запишите анализ.', 1, '2025-06-02 08:36:46');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (42, 33, 'Персональный план развития', 'Создайте план развития коммуникативных навыков на следующие 3 месяца. Включите конкретные цели, действия и способы измерения прогресса.', 2, '2025-06-02 08:36:46');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (43, 33, 'Итоговая презентация', 'Подготовьте 10-минутную презентацию о том, что вы изучили в курсе и как планируете применять навыки. Примените все техники презентационного мастерства.', 3, '2025-06-02 08:36:46');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (44, 34, 'Самооценка лидерских качеств', 'Оцените себя по 7 ключевым качествам лидера по шкале 1-10. Выберите 3 качества для развития.', 1, '2025-06-02 08:47:29');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (45, 34, 'Анализ лидера-образца', 'Выберите лидера, которым восхищаетесь. Определите, на каком уровне по Максвеллу он находится и почему.', 2, '2025-06-02 08:47:29');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (46, 35, 'Дневник эмоций лидера', 'Неделю записывайте ситуации, когда ваши эмоции влияли на команду. Анализируйте паттерны.', 1, '2025-06-02 08:47:29');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (47, 35, 'Практика эмпатии', 'В течение дня обращайте внимание на эмоциональное состояние членов команды. Практикуйте активное слушание.', 2, '2025-06-02 08:47:29');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (48, 36, 'Анализ ситуаций лидерства', 'Опишите 4 разные рабочие ситуации и определите, какой стиль лидерства будет наиболее эффективен в каждой.', 1, '2025-06-02 08:47:33');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (49, 36, 'Практика адаптации стиля', 'В течение недели наблюдайте за собой: как вы адаптируете свой стиль в зависимости от ситуации и людей.', 2, '2025-06-02 08:47:33');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (50, 37, 'Карта мотивации команды', 'Создайте профиль мотивации для каждого члена команды: что их вдохновляет, демотивирует, к чему стремятся.', 1, '2025-06-02 08:47:33');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (51, 37, 'Эксперимент с признанием', 'Неделю целенаправленно признавайте достижения команды разными способами. Наблюдайте за изменениями.', 2, '2025-06-02 08:47:33');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (52, 38, 'План делегирования', 'Составьте список из 10 задач, которые можете делегировать. Для каждой определите исполнителя и уровень делегирования.', 1, '2025-06-02 08:47:33');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (53, 38, 'Индивидуальный план развития', 'Выберите сотрудника и создайте план его развития на 3 месяца с использованием модели 70-20-10.', 2, '2025-06-02 08:47:33');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (54, 39, 'Анализ сложного решения', 'Вспомните сложное решение из прошлого. Проанализируйте его с помощью модели DECIDE. Что можно было сделать лучше?', 1, '2025-06-02 08:47:33');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (55, 39, 'Матрица решений', 'Для текущей рабочей проблемы создайте матрицу решений с альтернативами, критериями и оценками.', 2, '2025-06-02 08:47:33');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (56, 40, 'Анализ своего влияния', 'Проанализируйте, какие принципы Чалдини вы используете чаще всего. Выберите 2 принципа для развития.', 1, '2025-06-02 08:47:33');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (57, 40, 'Практика сторителлинга', 'Подготовьте 3 истории из личного опыта для разных ситуаций: мотивации, обучения, убеждения.', 2, '2025-06-02 08:47:33');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (58, 41, 'Анализ изменений в организации', 'Проанализируйте текущие или недавние изменения в организации через призму модели Коттера. Какие шаги выполнены хорошо, какие — нет?', 1, '2025-06-02 08:47:33');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (59, 41, 'План управления сопротивлением', 'Для планируемого изменения создайте карту заинтересованных сторон и план работы с каждой группой.', 2, '2025-06-02 08:47:33');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (60, 42, 'Оценка текущей культуры', 'Проанализируйте культуру вашей команды/организации по модели CVF. Определите доминирующий тип и желаемые изменения.', 1, '2025-06-02 08:47:33');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (61, 42, 'План влияния на культуру', 'Составьте план из 5 конкретных действий, которые помогут вам как лидеру влиять на культуру команды.', 2, '2025-06-02 08:47:33');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (62, 43, 'Комплексный кейс лидерства', 'Проанализируйте сложную лидерскую ситуацию из вашего опыта, применив все изученные модели и концепции. Что бы вы сделали по-другому?', 1, '2025-06-02 08:47:33');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (63, 43, 'Персональный план развития лидера', 'Создайте детальный план развития лидерских навыков на 6 месяцев с конкретными целями, действиями и метриками.', 2, '2025-06-02 08:47:33');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (64, 43, 'Презентация лидерской философии', 'Подготовьте 10-минутную презентацию своей лидерской философии: ценности, принципы, стиль, видение будущего.', 3, '2025-06-02 08:47:33');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (65, 44, 'Тест на эмоциональный интеллект', 'Пройдите онлайн-тест на EQ и проанализируйте результаты. Определите свои сильные стороны и области для развития.', 1, '2025-06-02 08:59:43');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (66, 44, 'Дневник эмоций', 'В течение недели ведите дневник эмоций: записывайте какие эмоции испытывали, в каких ситуациях и как они влияли на ваше поведение.', 2, '2025-06-02 08:59:43');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (67, 45, 'Эмоциональный термометр', 'В течение дня каждые 2 часа записывайте свое эмоциональное состояние, его интенсивность (1-10) и причину. Анализируйте паттерны в конце дня.', 1, '2025-06-02 09:01:14');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (68, 45, 'Практика mindfulness', 'Выполняйте 10-минутную медитацию осознанности ежедневно в течение недели. Отмечайте изменения в осознанности эмоций.', 2, '2025-06-02 09:01:14');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (69, 46, 'Карта триггеров', 'Составьте список ваших эмоциональных триггеров. Для каждого разработайте стратегию саморегуляции используя техники из урока.', 1, '2025-06-02 09:01:14');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (70, 46, 'Практика техники STOP', 'В течение недели применяйте технику STOP в стрессовых ситуациях. Ведите записи о том, как это влияет на ваши реакции.', 2, '2025-06-02 09:01:14');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (71, 47, 'Дневник наблюдений', 'В течение недели ведите дневник наблюдений за невербальными сигналами коллег. Записывайте что заметили и как это соотносилось с их словами.', 1, '2025-06-02 09:01:14');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (72, 47, 'Практика эмпатического слушания', 'Выберите 3 разговора где будете практиковать активное эмпатическое слушание. Запишите свои наблюдения о том, как это повлияло на диалог.', 2, '2025-06-02 09:01:14');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (73, 48, 'Анализ стилей влияния', 'Проанализируйте 3 недавние ситуации где вы пытались на кого-то повлиять. Определите какие стили использовали и насколько они были эффективны.', 1, '2025-06-02 09:01:14');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (74, 48, 'Практика модели SBI', 'Используйте модель SBI для предоставления обратной связи 2-3 коллегам. Запишите их реакции и эффективность подхода.', 2, '2025-06-02 09:01:14');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (75, 49, 'Формулировка SMART-целей', 'Сформулируйте 3 профессиональные цели на ближайшие 3 месяца используя критерии SMART. Запишите для каждой конкретные метрики успеха.', 1, '2025-06-02 09:10:14');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (76, 49, 'Матрица приоритетов', 'Создайте список из 15-20 текущих задач и распределите их по категориям A, B, C. Сосредоточьтесь в первую очередь на задачах категории A.', 2, '2025-06-02 09:10:14');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (77, 50, 'Анализ причин прокрастинации', 'Выберите 2-3 задачи, которые вы откладываете. Проанализируйте причины прокрастинации для каждой и выберите подходящую технику преодоления.', 1, '2025-06-02 09:10:14');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (78, 50, 'Эксперимент с техниками', 'В течение недели попробуйте минимум 3 техники борьбы с прокрастинацией. Ведите дневник эффективности каждой техники.', 2, '2025-06-02 09:10:14');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (79, 51, 'Аудит текущих инструментов', 'Проведите аудит всех приложений и сервисов, которые используете для планирования. Определите дублирование функций и неиспользуемые инструменты.', 1, '2025-06-02 09:10:14');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (80, 51, 'Внедрение нового инструмента', 'Выберите один новый инструмент из урока и используйте его в течение недели. Оцените влияние на вашу продуктивность.', 2, '2025-06-02 09:10:14');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (81, 52, 'Энергетический дневник', 'В течение недели каждые 2 часа отмечайте свой уровень энергии по шкале 1-10. Выявите паттерны и оптимальные времена для разных типов задач.', 1, '2025-06-02 09:10:14');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (82, 52, 'Эксперимент с биоритмами', 'Запланируйте самые важные задачи на время вашего энергетического пика. Сравните результативность с обычным планированием.', 2, '2025-06-02 09:10:14');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (83, 53, 'Аудит совещаний', 'Проанализируйте все совещания за прошлую неделю. Оцените необходимость каждого, эффективность и предложите улучшения.', 1, '2025-06-02 09:10:14');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (84, 53, 'Эксперимент с форматами', 'Попробуйте провести одно совещание в альтернативном формате (stand-up, walking meeting или асинхронное обсуждение). Сравните результативность.', 2, '2025-06-02 09:10:14');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (85, 54, 'Карта стресс-факторов', 'Определите основные источники стресса в работе и личной жизни. Для каждого разработайте стратегию управления используя техники из урока.', 1, '2025-06-02 09:10:14');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (86, 54, 'Эксперимент с границами', 'Выберите одну область для установления более четких границ (время, технологии или эмоции). Внедрите изменения на неделю и оцените результат.', 2, '2025-06-02 09:10:14');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (87, 55, 'Долгосрочное видение', 'Создайте детальное описание своей жизни через 10 лет. Определите 3-5 ключевых навыков, которые нужно развить для достижения этого видения.', 1, '2025-06-02 09:10:14');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (88, 55, 'Персональная система развития', 'Разработайте план развития навыков тайм-менеджмента на следующие 6 месяцев. Включите ведущие показатели для отслеживания прогресса.', 2, '2025-06-02 09:10:14');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (89, 56, 'Анализ командной динамики', 'Проанализируйте эмоциональную динамику в своей команде. Определите эмоциональные роли участников, выявите потенциальные точки напряжения и предложите стратегии улучшения.', 0, '2025-06-02 09:15:38');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (90, 56, 'Создание эмоциональных норм команды', 'Разработайте набор эмоциональных норм для команды: как выражать несогласие, как оказывать поддержку, как отмечать успехи.', 0, '2025-06-02 09:15:38');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (91, 57, 'Персональный план управления стрессом', 'Создайте индивидуальный план управления стрессом. Включите техники профилактики, методы быстрого реагирования и стратегии восстановления.', 0, '2025-06-02 09:15:38');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (92, 57, 'Неделя практики стрессоустойчивости', 'В течение недели ежедневно применяйте одну из изученных техник управления стрессом. Ведите дневник наблюдений и оценивайте эффективность каждой техники.', 0, '2025-06-02 09:15:38');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (93, 58, 'Самооценка эмоционального лидерства', 'Оцените свои текущие навыки эмоционального лидерства. Определите сильные стороны и области для развития. Получите обратную связь от коллег.', 0, '2025-06-02 09:15:38');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (94, 58, 'Проект по улучшению эмоционального климата', 'Разработайте и реализуйте проект по улучшению эмоционального климата в вашей команде или отделе. Измерьте результаты до и после внедрения изменений.', 0, '2025-06-02 09:15:38');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (95, 58, 'Практика эмоционального влияния', 'Выберите сложную рабочую ситуацию и примените техники эмоционального лидерства для ее решения. Проанализируйте эффективность вашего подхода.', 0, '2025-06-02 09:15:38');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (96, 59, 'Аудит цифрового поведения', 'Проведите анализ своего цифрового поведения в течение недели. Отследите эмоциональные реакции на различные онлайн-взаимодействия и выявите паттерны.', 0, '2025-06-02 09:15:38');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (97, 59, 'Улучшение цифровой коммуникации', 'Выберите один канал цифровой коммуникации (email, мессенджер, соцсеть) и улучшите качество своего общения, применяя принципы EQ. Измерьте изменения в обратной связи.', 0, '2025-06-02 09:15:38');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (98, 60, 'Комплексная EQ-диагностика', 'Пройдите полную диагностику эмоционального интеллекта, используя несколько инструментов. Получите обратную связь от 5-7 коллег. Создайте карту своих EQ-компетенций.', 0, '2025-06-02 09:15:38');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (99, 60, 'Персональный план развития EQ', 'Создайте детальный план развития эмоционального интеллекта на 12 месяцев. Включите конкретные цели, методы развития, временные рамки и критерии успеха.', 0, '2025-06-02 09:15:38');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (100, 60, 'Проект внедрения EQ-культуры', 'Разработайте и представите проект по внедрению культуры эмоционального интеллекта в своей организации или команде. Включите обоснование, план реализации и ожидаемые результаты.', 0, '2025-06-02 09:15:38');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (101, 61, 'Анализ новостной статьи', 'Выберите новостную статью и проанализируйте её с помощью модели CLEAR. Определите факты, мнения и возможные искажения.', 0, '2025-06-02 09:25:38');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (102, 61, 'Выявление когнитивных искажений', 'В течение дня отслеживайте примеры своих когнитивных искажений. Запишите 3 случая и проанализируйте их.', 0, '2025-06-02 09:25:38');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (103, 62, 'Применение техники ''5 почему''', 'Выберите рабочую проблему и примените технику ''5 почему'' для выявления корневой причины.', 0, '2025-06-02 09:25:38');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (104, 62, 'Создание диаграммы Исикавы', 'Постройте диаграмму Исикавы для анализа проблемы качества или эффективности в вашей работе.', 0, '2025-06-02 09:25:38');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (105, 63, 'SCAMPER-анализ', 'Выберите продукт или процесс и примените метод SCAMPER для генерации идей улучшения.', 0, '2025-06-02 09:25:38');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (106, 63, 'Сессия латерального мышления', 'Используйте технику ''случайного слова'' для решения актуальной рабочей задачи.', 0, '2025-06-02 09:25:38');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (107, 64, 'Построение матрицы решений', 'Создайте матрицу для принятия важного рабочего решения. Определите критерии, веса и оцените альтернативы.', 0, '2025-06-02 09:25:38');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (108, 64, 'Анализ по правилу 10-10-10', 'Примените правило 10-10-10 к текущему выбору в вашей карьере или проекте.', 0, '2025-06-02 09:25:38');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (109, 65, 'Критическая оценка исследования', 'Найдите бизнес-исследование и оцените его по критериям CRAAP. Выявите возможные проблемы с данными.', 0, '2025-06-02 09:25:38');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (110, 65, 'Анализ визуализации', 'Проанализируйте 3 графика из деловых презентаций. Определите, какие могут вводить в заблуждение и почему.', 0, '2025-06-02 09:25:38');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (111, 66, 'Системная диаграмма', 'Создайте диаграмму петель причинности для проблемы в вашей организации. Выявите усиливающие и балансирующие петли.', 0, '2025-06-02 09:25:38');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (112, 66, 'Анализ рычагов воздействия', 'Определите различные уровни рычагов воздействия для решения системной проблемы в вашей сфере.', 0, '2025-06-02 09:25:38');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (113, 67, 'Диалектический анализ', 'Выберите спорный вопрос в вашей области. Сформулируйте тезис, антитезис и найдите возможный синтез.', 0, '2025-06-02 09:25:38');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (114, 67, 'Практика активного слушания', 'В следующем разногласии используйте техники активного слушания. Запишите, как это повлияло на диалог.', 0, '2025-06-02 09:25:38');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (115, 68, 'ТРИЗ-анализ', 'Примените принципы ТРИЗ для решения технической или процессной проблемы в вашей работе.', 0, '2025-06-02 09:25:38');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (116, 68, 'Design Thinking проект', 'Пройдите все 5 этапов Design Thinking для улучшения пользовательского опыта в вашей области.', 0, '2025-06-02 09:25:38');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (117, 69, 'Комплексный кейс', 'Выберите сложную рабочую проблему и примените интегрированную модель. Используйте минимум 5 различных техник из курса.', 0, '2025-06-02 09:25:38');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (118, 69, 'Персональный план развития', 'Создайте план развития навыков решения проблем на 6 месяцев. Включите регулярные практики и метрики прогресса.', 0, '2025-06-02 09:25:38');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (119, 69, 'Презентация решения', 'Подготовьте презентацию своего подхода к решению важной проблемы для коллег, используя изученные принципы.', 0, '2025-06-02 09:25:38');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (120, 70, 'Анализ команды', 'Оцените свою текущую команду по модели Такмана. На какой стадии вы находитесь? Что нужно для перехода к следующей стадии?', 0, '2025-06-02 09:27:50');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (121, 70, 'Характеристики команды', 'Проанализируйте свою команду по 5 характеристикам эффективности. Поставьте оценки от 1 до 10 и определите приоритеты развития.', 0, '2025-06-02 09:27:50');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (122, 71, 'Самооценка командной роли', 'Пройдите тест Белбина или проанализируйте свое поведение в команде. Определите свою основную и дополнительную роли.', 0, '2025-06-02 09:27:50');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (123, 71, 'Ролевая карта команды', 'Создайте карту ролей вашей команды. Выявите пробелы и дублирование. Предложите план оптимизации.', 0, '2025-06-02 09:27:50');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (124, 72, 'Аудит доверия', 'Оцените уровень доверия в вашей команде по пирамиде Ленсиони. На каком уровне находятся основные проблемы?', 0, '2025-06-02 09:27:50');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (125, 72, 'План построения доверия', 'Разработайте 5 конкретных действий для укрепления доверия в команде. Начните с самого простого.', 0, '2025-06-02 09:27:50');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (126, 73, 'Коммуникационный аудит', 'Проанализируйте коммуникационные процессы в команде. Выявите проблемные зоны и предложите улучшения.', 0, '2025-06-02 09:27:50');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (127, 73, 'Практика обратной связи', 'Дайте конструктивную обратную связь одному из коллег по команде, используя изученные техники.', 0, '2025-06-02 09:27:50');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (128, 74, 'Анализ процесса принятия решений', 'Проанализируйте последнее важное решение в вашей команде. Какой метод использовался? Что можно было улучшить?', 0, '2025-06-02 09:27:50');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (129, 74, 'Практика консенсуса', 'Проведите сессию принятия группового решения с использованием техники ''Кулак - пять пальцев''.', 0, '2025-06-02 09:27:50');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (130, 75, 'Картирование конфликта', 'Проанализируйте текущий или недавний конфликт в команде. Определите тип, причины и предложите стратегию разрешения.', 0, '2025-06-02 09:27:50');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (131, 75, 'Практика медиации', 'Выступите посредником в небольшом рабочем разногласии между коллегами, используя изученные техники.', 0, '2025-06-02 09:27:50');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (132, 76, 'Диагностика мотивации', 'Проведите анкетирование команды по факторам мотивации. Выявите ключевые проблемы и возможности.', 0, '2025-06-02 09:27:50');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (133, 76, 'План повышения вовлеченности', 'Разработайте план действий по повышению мотивации одного из участников команды.', 0, '2025-06-02 09:27:50');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (134, 77, 'Аудит виртуального сотрудничества', 'Оцените эффективность виртуального взаимодействия в вашей команде. Выявите проблемы и предложите улучшения.', 0, '2025-06-02 09:27:50');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (135, 77, 'Дизайн виртуального тимбилдинга', 'Разработайте и проведите онлайн-активность для укрепления командного духа.', 0, '2025-06-02 09:27:50');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (136, 78, 'Карта компетенций команды', 'Создайте карту навыков команды. Выявите сильные стороны и пробелы в компетенциях.', 0, '2025-06-02 09:27:50');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (137, 78, 'Организация внутреннего обучения', 'Организуйте сессию внутреннего обучения, где участник команды поделится своей экспертизой с коллегами.', 0, '2025-06-02 09:27:50');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (138, 78, 'План развития команды', 'Разработайте квартальный план развития команды с конкретными активностями и метриками успеха.', 0, '2025-06-02 09:27:50');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (139, 79, 'Стратегический план коммуникации', 'Разработайте план коммуникации для важной инициативы. Проанализируйте стейкхолдеров, выберите стратегию влияния и принципы убеждения.', 0, '2025-06-02 09:31:20');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (140, 79, 'Анализ сопротивления', 'Определите источники сопротивления в текущем проекте и разработайте стратегию их преодоления.', 0, '2025-06-02 09:31:20');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (141, 80, 'Подготовка к переговорам', 'Подготовьтесь к предстоящим переговорам: определите BATNA, исследуйте интересы сторон, выберите стратегию.', 0, '2025-06-02 09:31:20');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (142, 80, 'Ролевая игра переговоров', 'Проведите переговоры с коллегой по сложному рабочему вопросу, применяя изученные техники.', 0, '2025-06-02 09:31:20');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (143, 81, 'Executive summary презентация', 'Создайте 10-минутную презентацию для руководства по важному вопросу, используя структуру SCRAP и элементы сторителлинга.', 0, '2025-06-02 09:31:20');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (144, 81, 'Работа с возражениями', 'Подготовьте ответы на 5 наиболее вероятных возражений к вашей презентации, используя технику ПИРС.', 0, '2025-06-02 09:31:20');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (145, 82, 'Аудит личного бренда', 'Проведите анализ своего текущего личного бренда: определите экспертизу, ценности, позиционирование. Выявите пробелы.', 0, '2025-06-02 09:31:20');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (146, 82, 'Стратегия повышения видимости', 'Разработайте 3-месячный план повышения профессиональной видимости с конкретными действиями и метриками.', 0, '2025-06-02 09:31:20');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (147, 83, 'Культурный профиль партнеров', 'Создайте культурные профили ваших ключевых международных партнеров или клиентов, используя модель Хофстеде.', 0, '2025-06-02 09:31:20');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (148, 83, 'Адаптация коммуникационного стиля', 'Разработайте план адаптации вашего стиля коммуникации для работы с представителями конкретной культуры.', 0, '2025-06-02 09:31:20');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (149, 84, 'Аудит цифрового присутствия', 'Проведите полный аудит вашего цифрового присутствия: профили, контент, вовлеченность. Определите сильные и слабые стороны.', 0, '2025-06-02 09:31:20');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (150, 84, 'Контент-стратегия', 'Разработайте месячную контент-стратегию для LinkedIn с календарем публикаций и метриками успеха.', 0, '2025-06-02 09:31:20');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (151, 85, 'План кризисной коммуникации', 'Разработайте план кризисной коммуникации для вашей организации: определите потенциальные риски, команду реагирования и key messages.', 0, '2025-06-02 09:31:20');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (152, 85, 'Симуляция кризиса', 'Проведите тренировку кризисной коммуникации: создайте сценарий и отработайте реагирование в течение первых 2 часов.', 0, '2025-06-02 09:31:20');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (153, 86, 'Разработка видения', 'Создайте убедительное видение для вашей команды или проекта, используя технику ''Золотой круг'' и формулу видения.', 0, '2025-06-02 09:31:20');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (154, 86, 'Лидерская история', 'Подготовьте и расскажите личную лидерскую историю, которая вдохновит команду на достижение общих целей.', 0, '2025-06-02 09:31:20');
INSERT INTO learning_tasks (id, material_id, title, description, order_position, created_at) VALUES (155, 86, 'План коммуникации изменений', 'Разработайте план коммуникации для важного изменения в организации, используя модель ADKAR и 8 шагов Коттера.', 0, '2025-06-02 09:31:20');

-- Данные для таблицы achievements
DELETE FROM achievements;
INSERT INTO achievements (id, title, description, badge_image, required_courses, required_lessons, required_score, created_at) VALUES (1, 'Первые шаги', 'Завершите свой первый курс', '🎯', 1, 0, 0.0, '2025-06-02 12:20:17');
INSERT INTO achievements (id, title, description, badge_image, required_courses, required_lessons, required_score, created_at) VALUES (2, 'Студент', 'Завершите 3 курса', '📚', 3, 0, 0.0, '2025-06-02 12:20:17');
INSERT INTO achievements (id, title, description, badge_image, required_courses, required_lessons, required_score, created_at) VALUES (3, 'Эксперт', 'Завершите 5 курсов', '🏆', 5, 0, 0.0, '2025-06-02 12:20:17');
INSERT INTO achievements (id, title, description, badge_image, required_courses, required_lessons, required_score, created_at) VALUES (4, 'Отличник', 'Получите 10 отличных оценок', '⭐', 0, 0, 0.0, '2025-06-02 12:20:17');
INSERT INTO achievements (id, title, description, badge_image, required_courses, required_lessons, required_score, created_at) VALUES (5, 'Марафонец', 'Завершите 20 уроков', '🏃‍♂️', 0, 20, 0.0, '2025-06-02 12:20:17');
INSERT INTO achievements (id, title, description, badge_image, required_courses, required_lessons, required_score, created_at) VALUES (6, 'Первооткрыватель', 'Начните первый урок', '🚀', 0, 1, 0.0, '2025-06-02 12:20:17');
INSERT INTO achievements (id, title, description, badge_image, required_courses, required_lessons, required_score, created_at) VALUES (7, 'Мастер коммуникации', 'Завершите 2 курса по коммуникации', '💬', 2, 0, 0.0, '2025-06-02 12:20:17');
INSERT INTO achievements (id, title, description, badge_image, required_courses, required_lessons, required_score, created_at) VALUES (8, 'Лидер', 'Завершите курс лидерства', '👑', 1, 0, 0.0, '2025-06-02 12:20:17');

-- Данные для таблицы user_game_profiles
DELETE FROM user_game_profiles;
INSERT INTO user_game_profiles (id, user_id, level, experience, total_points, courses_completed, lessons_completed, perfect_scores, login_streak, longest_streak, badges, titles, last_login, last_action, created_at, updated_at, experience_points) VALUES (1, 1, 1, NULL, NULL, 0, 0, 0, 0, 0, '[]', '[]', NULL, NULL, '2025-06-02 12:20:17', NULL, 0);
INSERT INTO user_game_profiles (id, user_id, level, experience, total_points, courses_completed, lessons_completed, perfect_scores, login_streak, longest_streak, badges, titles, last_login, last_action, created_at, updated_at, experience_points) VALUES (2, 3, 3, 0, 0, 3, 0, 0, 0, 0, '[]', '[]', NULL, '2025-06-02 14:03:51.974943', '2025-06-02 13:40:00', '2025-06-02 14:03:51', 350);
INSERT INTO user_game_profiles (id, user_id, level, experience, total_points, courses_completed, lessons_completed, perfect_scores, login_streak, longest_streak, badges, titles, last_login, last_action, created_at, updated_at, experience_points) VALUES (3, 10, 5, 0, 0, 3, 18, 18, 0, 0, '[]', '[]', NULL, '2025-06-03 04:20:11.733065', '2025-06-02 14:34:09', '2025-06-03 04:20:11', 956);
INSERT INTO user_game_profiles (id, user_id, level, experience, total_points, courses_completed, lessons_completed, perfect_scores, login_streak, longest_streak, badges, titles, last_login, last_action, created_at, updated_at, experience_points) VALUES (4, 9, 1, 0, 0, 0, 0, 0, 0, 0, '[]', '[]', NULL, '2025-06-02 15:18:00.484074', '2025-06-02 15:11:51', '2025-06-02 15:18:00', 49);
INSERT INTO user_game_profiles (id, user_id, level, experience, total_points, courses_completed, lessons_completed, perfect_scores, login_streak, longest_streak, badges, titles, last_login, last_action, created_at, updated_at, experience_points) VALUES (5, 11, 2, 0, 0, 1, 0, 0, 0, 0, '[]', '[]', NULL, '2025-06-02 22:59:10.016553', '2025-06-02 22:58:05', '2025-06-02 22:59:10', 150);
INSERT INTO user_game_profiles (id, user_id, level, experience, total_points, courses_completed, lessons_completed, perfect_scores, login_streak, longest_streak, badges, titles, last_login, last_action, created_at, updated_at, experience_points) VALUES (6, 12, 1, 0, 0, 0, 0, 0, 0, 0, '[]', '[]', NULL, NULL, '2025-06-02 23:30:59', NULL, 0);
INSERT INTO user_game_profiles (id, user_id, level, experience, total_points, courses_completed, lessons_completed, perfect_scores, login_streak, longest_streak, badges, titles, last_login, last_action, created_at, updated_at, experience_points) VALUES (7, 13, 4, 0, 0, 1, 13, 13, 0, 0, '[]', '[]', NULL, '2025-06-03 00:31:02.709604', '2025-06-03 00:26:28', '2025-06-03 00:31:02', 829);

-- Данные для таблицы user_achievements
DELETE FROM user_achievements;
INSERT INTO user_achievements (id, user_id, achievement_id, achieved_at) VALUES (1, 3, 1, '2025-06-02 13:40:15.086916');
INSERT INTO user_achievements (id, user_id, achievement_id, achieved_at) VALUES (2, 3, 4, '2025-06-02 13:40:15.087217');
INSERT INTO user_achievements (id, user_id, achievement_id, achieved_at) VALUES (3, 3, 8, '2025-06-02 13:40:15.087553');
INSERT INTO user_achievements (id, user_id, achievement_id, achieved_at) VALUES (4, 3, 7, '2025-06-02 13:40:39.825161');
INSERT INTO user_achievements (id, user_id, achievement_id, achieved_at) VALUES (5, 3, 2, '2025-06-02 13:40:47.030749');
INSERT INTO user_achievements (id, user_id, achievement_id, achieved_at) VALUES (6, 3, 3, '2025-06-02 14:02:13.190739');
INSERT INTO user_achievements (id, user_id, achievement_id, achieved_at) VALUES (7, 10, 1, '2025-06-02 14:34:13.743528');
INSERT INTO user_achievements (id, user_id, achievement_id, achieved_at) VALUES (8, 10, 4, '2025-06-02 14:34:13.744163');
INSERT INTO user_achievements (id, user_id, achievement_id, achieved_at) VALUES (9, 10, 8, '2025-06-02 14:34:13.744878');
INSERT INTO user_achievements (id, user_id, achievement_id, achieved_at) VALUES (10, 10, 6, '2025-06-02 14:34:42.591042');
INSERT INTO user_achievements (id, user_id, achievement_id, achieved_at) VALUES (11, 10, 7, '2025-06-02 14:37:02.323105');
INSERT INTO user_achievements (id, user_id, achievement_id, achieved_at) VALUES (12, 10, 2, '2025-06-02 14:39:13.561627');
INSERT INTO user_achievements (id, user_id, achievement_id, achieved_at) VALUES (13, 11, 1, '2025-06-02 22:59:10.020406');
INSERT INTO user_achievements (id, user_id, achievement_id, achieved_at) VALUES (14, 11, 4, '2025-06-02 22:59:10.020753');
INSERT INTO user_achievements (id, user_id, achievement_id, achieved_at) VALUES (15, 11, 8, '2025-06-02 22:59:10.021085');
INSERT INTO user_achievements (id, user_id, achievement_id, achieved_at) VALUES (16, 13, 4, '2025-06-03 00:27:39.278426');
INSERT INTO user_achievements (id, user_id, achievement_id, achieved_at) VALUES (17, 13, 6, '2025-06-03 00:27:39.278908');
INSERT INTO user_achievements (id, user_id, achievement_id, achieved_at) VALUES (18, 13, 1, '2025-06-03 00:30:19.252824');
INSERT INTO user_achievements (id, user_id, achievement_id, achieved_at) VALUES (19, 13, 8, '2025-06-03 00:30:19.259836');

-- Данные для таблицы courses
DELETE FROM courses;
INSERT INTO courses (id, title, description, skill_type, difficulty_level, duration_hours, price, is_published, author_id, created_at, updated_at) VALUES (1, 'Основы коммуникации', 'Изучите основы эффективного общения', 'COMMUNICATION', 'BEGINNER', 10, 0.0, 1, NULL, '2025-06-02 08:34:30', NULL);
INSERT INTO courses (id, title, description, skill_type, difficulty_level, duration_hours, price, is_published, author_id, created_at, updated_at) VALUES (2, 'Лидерство в команде', 'Развитие лидерских навыков', 'LEADERSHIP', 'INTERMEDIATE', 15, 0.0, 1, NULL, '2025-06-02 08:34:30', NULL);
INSERT INTO courses (id, title, description, skill_type, difficulty_level, duration_hours, price, is_published, author_id, created_at, updated_at) VALUES (3, 'Управление временем', 'Эффективное планирование времени', 'TIME_MANAGEMENT', 'BEGINNER', 8, 0.0, 1, NULL, '2025-06-02 08:34:30', NULL);
INSERT INTO courses (id, title, description, skill_type, difficulty_level, duration_hours, price, is_published, author_id, created_at, updated_at) VALUES (4, 'Эмоциональный интеллект в профессиональной среде', 'Развитие навыков управления эмоциями и эффективного взаимодействия с коллегами', 'EMOTIONAL_INTELLIGENCE', 'INTERMEDIATE', 11, 0.0, 1, NULL, '2025-06-02 08:59:43', '2025-06-02 09:15:38');
INSERT INTO courses (id, title, description, skill_type, difficulty_level, duration_hours, price, is_published, author_id, created_at, updated_at) VALUES (5, 'Решение проблем и критическое мышление', 'Развитие навыков анализа, поиска решений и принятия обоснованных решений', 'PROBLEM_SOLVING', 'INTERMEDIATE', 9, 0.0, 1, NULL, '2025-06-02 09:23:39', NULL);
INSERT INTO courses (id, title, description, skill_type, difficulty_level, duration_hours, price, is_published, author_id, created_at, updated_at) VALUES (6, 'Командная работа и сотрудничество', 'Эффективное взаимодействие в команде, построение доверия и достижение общих целей', 'TEAMWORK', 'BEGINNER', 8, 0.0, 1, NULL, '2025-06-02 09:23:39', NULL);
INSERT INTO courses (id, title, description, skill_type, difficulty_level, duration_hours, price, is_published, author_id, created_at, updated_at) VALUES (7, 'Продвинутая деловая коммуникация', 'Мастерство делового общения: переговоры, презентации и влияние', 'COMMUNICATION', 'ADVANCED', 9, 0.0, 1, NULL, '2025-06-02 09:23:39', '2025-06-02 09:31:20');

-- Данные для таблицы course_lessons
DELETE FROM course_lessons;
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (9, 3, 21, 1, 1, '2025-06-02T04:00:44.512511');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (10, 3, 22, 2, 1, '2025-06-02T04:00:44.512527');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (11, 3, 23, 3, 1, '2025-06-02T04:00:44.512544');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (12, 1, 24, 1, 1, '2025-06-02 08:35:10');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (13, 1, 25, 2, 1, '2025-06-02 08:35:10');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (14, 1, 26, 3, 1, '2025-06-02 08:35:10');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (15, 1, 27, 4, 1, '2025-06-02 08:35:10');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (16, 1, 28, 5, 1, '2025-06-02 08:35:10');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (17, 1, 29, 6, 1, '2025-06-02 08:35:10');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (18, 1, 30, 7, 1, '2025-06-02 08:35:10');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (19, 1, 31, 8, 1, '2025-06-02 08:35:10');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (20, 1, 32, 9, 1, '2025-06-02 08:35:10');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (21, 1, 33, 10, 1, '2025-06-02 08:36:46');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (22, 2, 34, 1, 1, '2025-06-02 08:47:29');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (23, 2, 35, 2, 1, '2025-06-02 08:47:29');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (24, 2, 36, 3, 1, '2025-06-02 08:47:33');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (25, 2, 37, 4, 1, '2025-06-02 08:47:33');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (26, 2, 38, 5, 1, '2025-06-02 08:47:33');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (27, 2, 39, 6, 1, '2025-06-02 08:47:33');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (28, 2, 40, 7, 1, '2025-06-02 08:47:33');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (29, 2, 41, 8, 1, '2025-06-02 08:47:33');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (30, 2, 42, 9, 1, '2025-06-02 08:47:33');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (31, 2, 43, 10, 1, '2025-06-02 08:47:33');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (32, 4, 44, 1, 1, '2025-06-02 08:59:43');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (33, 4, 45, 2, 1, '2025-06-02 09:01:14');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (34, 4, 46, 3, 1, '2025-06-02 09:01:14');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (35, 4, 47, 4, 1, '2025-06-02 09:01:14');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (36, 4, 48, 5, 1, '2025-06-02 09:01:14');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (37, 3, 49, 4, 1, '2025-06-02 09:10:14');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (38, 3, 50, 5, 1, '2025-06-02 09:10:14');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (39, 3, 51, 6, 1, '2025-06-02 09:10:14');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (40, 3, 52, 7, 1, '2025-06-02 09:10:14');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (41, 3, 53, 8, 1, '2025-06-02 09:10:14');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (42, 3, 54, 9, 1, '2025-06-02 09:10:14');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (43, 3, 55, 10, 1, '2025-06-02 09:10:14');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (44, 4, 56, 6, 1, '2025-06-02 09:15:38');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (45, 4, 57, 7, 1, '2025-06-02 09:15:38');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (46, 4, 58, 8, 1, '2025-06-02 09:15:38');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (47, 4, 59, 9, 1, '2025-06-02 09:15:38');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (48, 4, 60, 10, 1, '2025-06-02 09:15:38');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (49, 5, 61, 1, 1, '2025-06-02 09:25:38');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (50, 5, 62, 2, 1, '2025-06-02 09:25:38');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (51, 5, 63, 3, 1, '2025-06-02 09:25:38');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (52, 5, 64, 4, 1, '2025-06-02 09:25:38');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (53, 5, 65, 5, 1, '2025-06-02 09:25:38');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (54, 5, 66, 6, 1, '2025-06-02 09:25:38');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (55, 5, 67, 7, 1, '2025-06-02 09:25:38');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (56, 5, 68, 8, 1, '2025-06-02 09:25:38');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (57, 5, 69, 9, 1, '2025-06-02 09:25:38');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (58, 6, 70, 1, 1, '2025-06-02 09:27:50');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (59, 6, 71, 2, 1, '2025-06-02 09:27:50');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (60, 6, 72, 3, 1, '2025-06-02 09:27:50');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (61, 6, 73, 4, 1, '2025-06-02 09:27:50');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (62, 6, 74, 5, 1, '2025-06-02 09:27:50');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (63, 6, 75, 6, 1, '2025-06-02 09:27:50');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (64, 6, 76, 7, 1, '2025-06-02 09:27:50');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (65, 6, 77, 8, 1, '2025-06-02 09:27:50');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (66, 6, 78, 9, 1, '2025-06-02 09:27:50');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (67, 7, 79, 1, 1, '2025-06-02 09:31:20');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (68, 7, 80, 2, 1, '2025-06-02 09:31:20');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (69, 7, 81, 3, 1, '2025-06-02 09:31:20');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (70, 7, 82, 4, 1, '2025-06-02 09:31:20');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (71, 7, 83, 5, 1, '2025-06-02 09:31:20');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (72, 7, 84, 6, 1, '2025-06-02 09:31:20');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (73, 7, 85, 7, 1, '2025-06-02 09:31:20');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (74, 7, 86, 8, 1, '2025-06-02 09:31:20');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (75, 1, 3, 11, 1, '2025-06-02 09:47:10');
INSERT INTO course_lessons (id, course_id, material_id, order_position, is_required, created_at) VALUES (76, 1, 11, 12, 1, '2025-06-02 09:47:10');

-- Данные для таблицы course_completions
DELETE FROM course_completions;
INSERT INTO course_completions (id, user_id, course_id, completed_at, final_score) VALUES (1, 3, 1, '2025-06-02 14:03:51.950565', NULL);
INSERT INTO course_completions (id, user_id, course_id, completed_at, final_score) VALUES (2, 3, 2, '2025-06-02 14:03:51.964547', NULL);
INSERT INTO course_completions (id, user_id, course_id, completed_at, final_score) VALUES (3, 3, 3, '2025-06-02 14:03:51.974866', NULL);
INSERT INTO course_completions (id, user_id, course_id, completed_at, final_score) VALUES (4, 10, 1, '2025-06-02 14:34:13.732745', NULL);
INSERT INTO course_completions (id, user_id, course_id, completed_at, final_score) VALUES (5, 10, 3, '2025-06-02 14:37:02.310001', NULL);
INSERT INTO course_completions (id, user_id, course_id, completed_at, final_score) VALUES (6, 10, 6, '2025-06-02 14:39:13.550496', NULL);
INSERT INTO course_completions (id, user_id, course_id, completed_at, final_score) VALUES (7, 11, 1, '2025-06-02 22:59:10.016507', NULL);
INSERT INTO course_completions (id, user_id, course_id, completed_at, final_score) VALUES (8, 13, 1, '2025-06-03 00:30:18.891282', NULL);

SET session_replication_role = DEFAULT;

-- Обновление последовательностей
SELECT setval(pg_get_serial_sequence('users', 'id'), COALESCE(max(id), 1)) FROM users;
SELECT setval(pg_get_serial_sequence('soft_skills', 'id'), COALESCE(max(id), 1)) FROM soft_skills;
SELECT setval(pg_get_serial_sequence('skill_questions', 'id'), COALESCE(max(id), 1)) FROM skill_questions;
SELECT setval(pg_get_serial_sequence('skill_assessments', 'id'), COALESCE(max(id), 1)) FROM skill_assessments;
SELECT setval(pg_get_serial_sequence('modules', 'id'), COALESCE(max(id), 1)) FROM modules;
SELECT setval(pg_get_serial_sequence('question_options', 'id'), COALESCE(max(id), 1)) FROM question_options;
SELECT setval(pg_get_serial_sequence('user_skill_assessments', 'id'), COALESCE(max(id), 1)) FROM user_skill_assessments;
SELECT setval(pg_get_serial_sequence('lessons', 'id'), COALESCE(max(id), 1)) FROM lessons;
SELECT setval(pg_get_serial_sequence('user_answers', 'id'), COALESCE(max(id), 1)) FROM user_answers;
SELECT setval(pg_get_serial_sequence('daily_tasks', 'id'), COALESCE(max(id), 1)) FROM daily_tasks;
SELECT setval(pg_get_serial_sequence('user_levels', 'id'), COALESCE(max(id), 1)) FROM user_levels;
SELECT setval(pg_get_serial_sequence('task_completions', 'id'), COALESCE(max(id), 1)) FROM task_completions;
SELECT setval(pg_get_serial_sequence('user_daily_task_assignments', 'id'), COALESCE(max(id), 1)) FROM user_daily_task_assignments;
SELECT setval(pg_get_serial_sequence('learning_materials', 'id'), COALESCE(max(id), 1)) FROM learning_materials;
SELECT setval(pg_get_serial_sequence('learning_tasks', 'id'), COALESCE(max(id), 1)) FROM learning_tasks;
SELECT setval(pg_get_serial_sequence('user_progress', 'id'), COALESCE(max(id), 1)) FROM user_progress;
SELECT setval(pg_get_serial_sequence('material_progress', 'id'), COALESCE(max(id), 1)) FROM material_progress;
SELECT setval(pg_get_serial_sequence('achievements', 'id'), COALESCE(max(id), 1)) FROM achievements;
SELECT setval(pg_get_serial_sequence('user_game_profiles', 'id'), COALESCE(max(id), 1)) FROM user_game_profiles;
SELECT setval(pg_get_serial_sequence('rewards', 'id'), COALESCE(max(id), 1)) FROM rewards;
SELECT setval(pg_get_serial_sequence('leaderboards', 'id'), COALESCE(max(id), 1)) FROM leaderboards;
SELECT setval(pg_get_serial_sequence('lesson_progress', 'id'), COALESCE(max(id), 1)) FROM lesson_progress;
SELECT setval(pg_get_serial_sequence('user_achievements', 'id'), COALESCE(max(id), 1)) FROM user_achievements;
SELECT setval(pg_get_serial_sequence('user_activities', 'id'), COALESCE(max(id), 1)) FROM user_activities;
SELECT setval(pg_get_serial_sequence('user_rewards', 'id'), COALESCE(max(id), 1)) FROM user_rewards;
SELECT setval(pg_get_serial_sequence('quizzes', 'id'), COALESCE(max(id), 1)) FROM quizzes;
SELECT setval(pg_get_serial_sequence('notifications', 'id'), COALESCE(max(id), 1)) FROM notifications;
SELECT setval(pg_get_serial_sequence('notification_preferences', 'id'), COALESCE(max(id), 1)) FROM notification_preferences;
SELECT setval(pg_get_serial_sequence('discussions', 'id'), COALESCE(max(id), 1)) FROM discussions;
SELECT setval(pg_get_serial_sequence('reviews', 'id'), COALESCE(max(id), 1)) FROM reviews;
SELECT setval(pg_get_serial_sequence('questions', 'id'), COALESCE(max(id), 1)) FROM questions;
SELECT setval(pg_get_serial_sequence('quiz_attempts', 'id'), COALESCE(max(id), 1)) FROM quiz_attempts;
SELECT setval(pg_get_serial_sequence('discussion_replies', 'id'), COALESCE(max(id), 1)) FROM discussion_replies;
SELECT setval(pg_get_serial_sequence('discussion_votes', 'id'), COALESCE(max(id), 1)) FROM discussion_votes;
SELECT setval(pg_get_serial_sequence('review_helpful', 'id'), COALESCE(max(id), 1)) FROM review_helpful;
SELECT setval(pg_get_serial_sequence('question_responses', 'id'), COALESCE(max(id), 1)) FROM question_responses;
SELECT setval(pg_get_serial_sequence('reply_votes', 'id'), COALESCE(max(id), 1)) FROM reply_votes;
SELECT setval(pg_get_serial_sequence('courses', 'id'), COALESCE(max(id), 1)) FROM courses;
SELECT setval(pg_get_serial_sequence('course_lessons', 'id'), COALESCE(max(id), 1)) FROM course_lessons;
SELECT setval(pg_get_serial_sequence('course_enrollments', 'id'), COALESCE(max(id), 1)) FROM course_enrollments;
SELECT setval(pg_get_serial_sequence('course_exams', 'id'), COALESCE(max(id), 1)) FROM course_exams;
SELECT setval(pg_get_serial_sequence('course_completions', 'id'), COALESCE(max(id), 1)) FROM course_completions;
SELECT setval(pg_get_serial_sequence('exam_attempts', 'id'), COALESCE(max(id), 1)) FROM exam_attempts;
SELECT setval(pg_get_serial_sequence('certificates', 'id'), COALESCE(max(id), 1)) FROM certificates;
