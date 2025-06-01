from sqlalchemy.orm import Session
from app.models.skills import SoftSkill, SkillQuestion, QuestionOption, SkillCategory

def seed_skills_data(db: Session):
    """Заполняет базу данных навыками и вопросами для тестирования"""
    
    # Создаем основные навыки
    skills_data = [
        {
            "name": "Коммуникация",
            "category": SkillCategory.COMMUNICATION,
            "description": "Способность эффективно общаться с другими людьми"
        },
        {
            "name": "Лидерство",
            "category": SkillCategory.LEADERSHIP,
            "description": "Умение вести за собой и мотивировать команду"
        },
        {
            "name": "Командная работа",
            "category": SkillCategory.TEAMWORK,
            "description": "Способность работать в команде и сотрудничать"
        },
        {
            "name": "Решение проблем",
            "category": SkillCategory.PROBLEM_SOLVING,
            "description": "Умение находить решения сложных задач"
        },
        {
            "name": "Управление временем",
            "category": SkillCategory.TIME_MANAGEMENT,
            "description": "Способность эффективно планировать и распределять время"
        },
        {
            "name": "Эмоциональный интеллект",
            "category": SkillCategory.EMOTIONAL_INTELLIGENCE,
            "description": "Понимание и управление эмоциями"
        }
    ]
    
    # Создаем навыки
    skills = {}
    for skill_data in skills_data:
        skill = SoftSkill(**skill_data)
        db.add(skill)
        db.flush()
        skills[skill_data["category"]] = skill
    
    # Вопросы для каждого навыка
    questions_data = [
        # Коммуникация
        {
            "skill": SkillCategory.COMMUNICATION,
            "questions": [
                {
                    "text": "Как часто вы активно слушаете собеседника в разговоре?",
                    "options": [
                        {"text": "Всегда внимательно слушаю", "weight": 5},
                        {"text": "Часто слушаю", "weight": 4},
                        {"text": "Иногда отвлекаюсь", "weight": 3},
                        {"text": "Редко слушаю внимательно", "weight": 2},
                        {"text": "Почти никогда", "weight": 1}
                    ]
                },
                {
                    "text": "Насколько легко вам объяснить сложную идею простыми словами?",
                    "options": [
                        {"text": "Очень легко", "weight": 5},
                        {"text": "Довольно легко", "weight": 4},
                        {"text": "Средне", "weight": 3},
                        {"text": "Довольно сложно", "weight": 2},
                        {"text": "Очень сложно", "weight": 1}
                    ]
                },
                {
                    "text": "Как вы обычно реагируете на критику?",
                    "options": [
                        {"text": "Принимаю конструктивно и использую для улучшения", "weight": 5},
                        {"text": "Выслушиваю и анализирую", "weight": 4},
                        {"text": "Иногда защищаюсь", "weight": 3},
                        {"text": "Часто воспринимаю негативно", "weight": 2},
                        {"text": "Всегда защищаюсь", "weight": 1}
                    ]
                }
            ]
        },
        # Лидерство
        {
            "skill": SkillCategory.LEADERSHIP,
            "questions": [
                {
                    "text": "Как часто другие обращаются к вам за советом или руководством?",
                    "options": [
                        {"text": "Очень часто", "weight": 5},
                        {"text": "Часто", "weight": 4},
                        {"text": "Иногда", "weight": 3},
                        {"text": "Редко", "weight": 2},
                        {"text": "Никогда", "weight": 1}
                    ]
                },
                {
                    "text": "Насколько легко вам мотивировать других людей?",
                    "options": [
                        {"text": "Очень легко", "weight": 5},
                        {"text": "Довольно легко", "weight": 4},
                        {"text": "Средне", "weight": 3},
                        {"text": "Довольно сложно", "weight": 2},
                        {"text": "Очень сложно", "weight": 1}
                    ]
                }
            ]
        },
        # Командная работа
        {
            "skill": SkillCategory.TEAMWORK,
            "questions": [
                {
                    "text": "Как вы относитесь к работе в команде?",
                    "options": [
                        {"text": "Очень нравится, работаю эффективно", "weight": 5},
                        {"text": "Нравится, хорошо сотрудничаю", "weight": 4},
                        {"text": "Нормально, могу работать", "weight": 3},
                        {"text": "Не очень нравится", "weight": 2},
                        {"text": "Предпочитаю работать один", "weight": 1}
                    ]
                },
                {
                    "text": "Как часто вы помогаете коллегам с их задачами?",
                    "options": [
                        {"text": "Всегда готов помочь", "weight": 5},
                        {"text": "Часто помогаю", "weight": 4},
                        {"text": "Иногда помогаю", "weight": 3},
                        {"text": "Редко помогаю", "weight": 2},
                        {"text": "Сосредоточен только на своих задачах", "weight": 1}
                    ]
                }
            ]
        },
        # Решение проблем
        {
            "skill": SkillCategory.PROBLEM_SOLVING,
            "questions": [
                {
                    "text": "Как вы подходите к решению сложных проблем?",
                    "options": [
                        {"text": "Анализирую систематически и рассматриваю все варианты", "weight": 5},
                        {"text": "Обдумываю несколько подходов", "weight": 4},
                        {"text": "Пробую разные способы", "weight": 3},
                        {"text": "Использую первый пришедший в голову способ", "weight": 2},
                        {"text": "Откладываю или избегаю", "weight": 1}
                    ]
                },
                {
                    "text": "Насколько творчески вы подходите к решению задач?",
                    "options": [
                        {"text": "Всегда ищу нестандартные решения", "weight": 5},
                        {"text": "Часто проявляю креативность", "weight": 4},
                        {"text": "Иногда думаю творчески", "weight": 3},
                        {"text": "Редко использую креативный подход", "weight": 2},
                        {"text": "Всегда использую стандартные методы", "weight": 1}
                    ]
                }
            ]
        },
        # Управление временем
        {
            "skill": SkillCategory.TIME_MANAGEMENT,
            "questions": [
                {
                    "text": "Как часто вы сдаете работу в срок?",
                    "options": [
                        {"text": "Всегда", "weight": 5},
                        {"text": "Почти всегда", "weight": 4},
                        {"text": "Обычно", "weight": 3},
                        {"text": "Иногда опаздываю", "weight": 2},
                        {"text": "Часто опаздываю", "weight": 1}
                    ]
                },
                {
                    "text": "Насколько хорошо вы планируете свой день?",
                    "options": [
                        {"text": "Всегда составляю детальный план", "weight": 5},
                        {"text": "Обычно планирую основные задачи", "weight": 4},
                        {"text": "Иногда планирую", "weight": 3},
                        {"text": "Редко планирую заранее", "weight": 2},
                        {"text": "Никогда не планирую", "weight": 1}
                    ]
                }
            ]
        },
        # Эмоциональный интеллект
        {
            "skill": SkillCategory.EMOTIONAL_INTELLIGENCE,
            "questions": [
                {
                    "text": "Насколько хорошо вы понимаете эмоции других людей?",
                    "options": [
                        {"text": "Очень хорошо чувствую настроение окружающих", "weight": 5},
                        {"text": "Довольно хорошо понимаю", "weight": 4},
                        {"text": "Иногда улавливаю", "weight": 3},
                        {"text": "Редко замечаю", "weight": 2},
                        {"text": "Почти не обращаю внимания", "weight": 1}
                    ]
                },
                {
                    "text": "Как вы управляете своими эмоциями в стрессовых ситуациях?",
                    "options": [
                        {"text": "Всегда сохраняю спокойствие", "weight": 5},
                        {"text": "Обычно контролирую эмоции", "weight": 4},
                        {"text": "Иногда теряю контроль", "weight": 3},
                        {"text": "Часто эмоционально реагирую", "weight": 2},
                        {"text": "Почти всегда теряю контроль", "weight": 1}
                    ]
                }
            ]
        }
    ]
    
    # Создаем вопросы и варианты ответов
    question_order = 1
    for category_data in questions_data:
        skill = skills[category_data["skill"]]
        
        for q_data in category_data["questions"]:
            question = SkillQuestion(
                skill_id=skill.id,
                question_text=q_data["text"],
                question_type="multiple_choice",
                is_active=True,
                order_index=question_order
            )
            db.add(question)
            db.flush()
            
            # Создаем варианты ответов
            for i, option_data in enumerate(q_data["options"]):
                option = QuestionOption(
                    question_id=question.id,
                    option_text=option_data["text"],
                    score_weight=option_data["weight"],
                    order_index=i + 1
                )
                db.add(option)
            
            question_order += 1
    
    db.commit()
    print(f"Создано {len(skills_data)} навыков и {question_order - 1} вопросов") 