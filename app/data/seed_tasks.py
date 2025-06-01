from sqlalchemy.orm import Session
from app.models.tasks import DailyTask, TaskType, TaskDifficulty


def seed_daily_tasks(db: Session):
    """Заполняет базу данных ежедневными заданиями"""
    
    tasks_data = [
        # ======= КОММУНИКАЦИЯ =======
        {
            "title": "Поговорите с незнакомым человеком",
            "description": "Начните разговор с кем-то новым сегодня. Это может быть коллега из другого отдела, сосед или человек в очереди.",
            "task_type": TaskType.COMMUNICATION,
            "difficulty": TaskDifficulty.EASY,
            "points": 15
        },
        {
            "title": "Попросите обратную связь",
            "description": "Попросите коллегу или руководителя дать вам обратную связь по недавней работе или проекту.",
            "task_type": TaskType.COMMUNICATION,
            "difficulty": TaskDifficulty.MEDIUM,
            "points": 20
        },
        {
            "title": "Проведите презентацию",
            "description": "Представьте свою идею или проект перед группой людей, даже если это всего лишь 5-минутная презентация.",
            "task_type": TaskType.COMMUNICATION,
            "difficulty": TaskDifficulty.HARD,
            "points": 30
        },
        {
            "title": "Активно слушайте собеседника",
            "description": "В следующем разговоре сосредоточьтесь на активном слушании - задавайте уточняющие вопросы и перефразируйте сказанное.",
            "task_type": TaskType.COMMUNICATION,
            "difficulty": TaskDifficulty.EASY,
            "points": 10
        },
        {
            "title": "Проведите видеозвонок вместо переписки",
            "description": "Вместо длинной переписки предложите решить вопрос в видеозвонке или личной встрече.",
            "task_type": TaskType.COMMUNICATION,
            "difficulty": TaskDifficulty.MEDIUM,
            "points": 15
        },
        {
            "title": "Объясните сложную концепцию простыми словами",
            "description": "Возьмите сложную тему из вашей области и объясните её человеку, не знакомому с предметом.",
            "task_type": TaskType.COMMUNICATION,
            "difficulty": TaskDifficulty.HARD,
            "points": 25
        },
        {
            "title": "Проведите мозговой штурм",
            "description": "Организуйте и проведите сессию мозгового штурма с коллегами по любой рабочей задаче.",
            "task_type": TaskType.COMMUNICATION,
            "difficulty": TaskDifficulty.MEDIUM,
            "points": 20
        },
        {
            "title": "Напишите понятное техническое письмо",
            "description": "Напишите подробное техническое письмо или инструкцию, которую легко понять любому получателю.",
            "task_type": TaskType.COMMUNICATION,
            "difficulty": TaskDifficulty.MEDIUM,
            "points": 15
        },
        
        # ======= ЛИДЕРСТВО =======
        {
            "title": "Возьмите инициативу в команде",
            "description": "Предложите новую идею или возьмите на себя организацию небольшого проекта или встречи.",
            "task_type": TaskType.LEADERSHIP,
            "difficulty": TaskDifficulty.MEDIUM,
            "points": 25
        },
        {
            "title": "Помогите коллеге решить проблему",
            "description": "Найдите коллегу, у которого есть сложности, и предложите свою помощь в решении проблемы.",
            "task_type": TaskType.LEADERSHIP,
            "difficulty": TaskDifficulty.EASY,
            "points": 15
        },
        {
            "title": "Дайте конструктивную обратную связь",
            "description": "Предоставьте полезную и конструктивную обратную связь коллеге или подчиненному.",
            "task_type": TaskType.LEADERSHIP,
            "difficulty": TaskDifficulty.MEDIUM,
            "points": 20
        },
        {
            "title": "Организуйте командную встречу",
            "description": "Инициируйте и проведите короткую командную встречу для обсуждения текущих задач или планов.",
            "task_type": TaskType.LEADERSHIP,
            "difficulty": TaskDifficulty.HARD,
            "points": 30
        },
        {
            "title": "Наставничество новичка",
            "description": "Потратьте время на обучение или наставничество нового сотрудника или менее опытного коллеги.",
            "task_type": TaskType.LEADERSHIP,
            "difficulty": TaskDifficulty.MEDIUM,
            "points": 25
        },
        {
            "title": "Примите сложное решение",
            "description": "Возьмите на себя ответственность за принятие сложного или неочевидного решения в рабочей ситуации.",
            "task_type": TaskType.LEADERSHIP,
            "difficulty": TaskDifficulty.HARD,
            "points": 35
        },
        {
            "title": "Мотивируйте команду",
            "description": "Найдите способ мотивировать команду или коллег для достижения общей цели.",
            "task_type": TaskType.LEADERSHIP,
            "difficulty": TaskDifficulty.MEDIUM,
            "points": 20
        },
        {
            "title": "Возглавьте инициативу по улучшению",
            "description": "Предложите и возглавьте инициативу по улучшению какого-либо рабочего процесса.",
            "task_type": TaskType.LEADERSHIP,
            "difficulty": TaskDifficulty.HARD,
            "points": 30
        },
        
        # ======= КОМАНДНАЯ РАБОТА =======
        {
            "title": "Предложите помощь коллеге",
            "description": "Активно предложите помощь коллеге с его задачей или проектом.",
            "task_type": TaskType.TEAMWORK,
            "difficulty": TaskDifficulty.EASY,
            "points": 10
        },
        {
            "title": "Организуйте совместный обед",
            "description": "Пригласите коллег на совместный обед или кофе-брейк для неформального общения.",
            "task_type": TaskType.TEAMWORK,
            "difficulty": TaskDifficulty.EASY,
            "points": 15
        },
        {
            "title": "Поделитесь знаниями с командой",
            "description": "Проведите небольшую сессию знакомства с новым инструментом или методом работы для коллег.",
            "task_type": TaskType.TEAMWORK,
            "difficulty": TaskDifficulty.MEDIUM,
            "points": 25
        },
        {
            "title": "Разрешите конфликт в команде",
            "description": "Если есть разногласия в команде, помогите найти компромисс и решение, которое устроит всех.",
            "task_type": TaskType.TEAMWORK,
            "difficulty": TaskDifficulty.HARD,
            "points": 35
        },
        {
            "title": "Организуйте командное мероприятие",
            "description": "Спланируйте и организуйте небольшое командное мероприятие или тимбилдинг.",
            "task_type": TaskType.TEAMWORK,
            "difficulty": TaskDifficulty.MEDIUM,
            "points": 20
        },
        {
            "title": "Создайте общий документ для команды",
            "description": "Создайте полезный общий документ, который поможет всей команде в работе.",
            "task_type": TaskType.TEAMWORK,
            "difficulty": TaskDifficulty.EASY,
            "points": 15
        },
        {
            "title": "Выступите посредником в споре",
            "description": "Помогите двум коллегам найти общий язык и решить рабочий спор.",
            "task_type": TaskType.TEAMWORK,
            "difficulty": TaskDifficulty.MEDIUM,
            "points": 25
        },
        {
            "title": "Поддержите идею коллеги",
            "description": "Активно поддержите и помогите развить хорошую идею, предложенную коллегой.",
            "task_type": TaskType.TEAMWORK,
            "difficulty": TaskDifficulty.EASY,
            "points": 10
        },
        
        # ======= РЕШЕНИЕ ПРОБЛЕМ =======
        {
            "title": "Найдите альтернативное решение",
            "description": "Для любой задачи, с которой вы столкнетесь сегодня, найдите как минимум два разных способа ее решения.",
            "task_type": TaskType.PROBLEM_SOLVING,
            "difficulty": TaskDifficulty.EASY,
            "points": 15
        },
        {
            "title": "Проанализируйте сложную проблему",
            "description": "Разбейте сложную проблему на более мелкие части и составьте план решения каждой из них.",
            "task_type": TaskType.PROBLEM_SOLVING,
            "difficulty": TaskDifficulty.MEDIUM,
            "points": 20
        },
        {
            "title": "Используйте метод 'Пять почему'",
            "description": "Примените технику '5 почему' к любой проблеме, чтобы добраться до ее корня.",
            "task_type": TaskType.PROBLEM_SOLVING,
            "difficulty": TaskDifficulty.MEDIUM,
            "points": 25
        },
        {
            "title": "Предложите инновационное решение",
            "description": "Найдите творческий и нестандартный подход к решению рабочей задачи.",
            "task_type": TaskType.PROBLEM_SOLVING,
            "difficulty": TaskDifficulty.HARD,
            "points": 30
        },
        {
            "title": "Проведите анализ причин и следствий",
            "description": "Создайте диаграмму 'рыбья кость' для анализа проблемы и её возможных причин.",
            "task_type": TaskType.PROBLEM_SOLVING,
            "difficulty": TaskDifficulty.MEDIUM,
            "points": 20
        },
        {
            "title": "Решите проблему методом мозгового штурма",
            "description": "Соберите команду и решите сложную проблему с помощью коллективного мозгового штурма.",
            "task_type": TaskType.PROBLEM_SOLVING,
            "difficulty": TaskDifficulty.HARD,
            "points": 35
        },
        {
            "title": "Найдите неочевидную связь",
            "description": "Найдите неочевидную связь между двумя, казалось бы, не связанными проблемами.",
            "task_type": TaskType.PROBLEM_SOLVING,
            "difficulty": TaskDifficulty.HARD,
            "points": 25
        },
        {
            "title": "Оптимизируйте существующий процесс",
            "description": "Найдите и предложите способ оптимизации существующего рабочего процесса.",
            "task_type": TaskType.PROBLEM_SOLVING,
            "difficulty": TaskDifficulty.MEDIUM,
            "points": 20
        },
        
        # ======= УПРАВЛЕНИЕ ВРЕМЕНЕМ =======
        {
            "title": "Составьте детальный план дня",
            "description": "Распланируйте свой день по часам, включая время на задачи, перерывы и неожиданности.",
            "task_type": TaskType.TIME_MANAGEMENT,
            "difficulty": TaskDifficulty.EASY,
            "points": 10
        },
        {
            "title": "Используйте технику Помодоро",
            "description": "Поработайте минимум 2 часа, используя технику Помодоро (25 минут работы, 5 минут перерыв).",
            "task_type": TaskType.TIME_MANAGEMENT,
            "difficulty": TaskDifficulty.EASY,
            "points": 15
        },
        {
            "title": "Устраните одного пожирателя времени",
            "description": "Определите одну вещь, которая тратит ваше время попусту, и исключите ее сегодня.",
            "task_type": TaskType.TIME_MANAGEMENT,
            "difficulty": TaskDifficulty.MEDIUM,
            "points": 20
        },
        {
            "title": "Делегируйте задачу",
            "description": "Найдите задачу, которую можно делегировать, и передайте ее подходящему человеку с четкими инструкциями.",
            "task_type": TaskType.TIME_MANAGEMENT,
            "difficulty": TaskDifficulty.HARD,
            "points": 25
        },
        {
            "title": "Установите четкие временные рамки",
            "description": "Для каждой задачи сегодня установите четкие временные рамки и придерживайтесь их.",
            "task_type": TaskType.TIME_MANAGEMENT,
            "difficulty": TaskDifficulty.MEDIUM,
            "points": 15
        },
        {
            "title": "Примените матрицу Эйзенхауэра",
            "description": "Распределите все задачи дня по матрице важность-срочность и действуйте согласно приоритетам.",
            "task_type": TaskType.TIME_MANAGEMENT,
            "difficulty": TaskDifficulty.MEDIUM,
            "points": 20
        },
        {
            "title": "Проведите аудит времени",
            "description": "Ведите точный учет времени в течение дня, записывая на что и сколько времени тратите.",
            "task_type": TaskType.TIME_MANAGEMENT,
            "difficulty": TaskDifficulty.EASY,
            "points": 15
        },
        {
            "title": "Скажите 'нет' ненужному",
            "description": "Откажитесь от одного неважного дела или встречи, чтобы сосредоточиться на приоритетах.",
            "task_type": TaskType.TIME_MANAGEMENT,
            "difficulty": TaskDifficulty.HARD,
            "points": 25
        },
        
        # ======= ЭМОЦИОНАЛЬНЫЙ ИНТЕЛЛЕКТ =======
        {
            "title": "Проанализируйте свои эмоции",
            "description": "В течение дня 3 раза остановитесь и запишите, что вы чувствуете и почему.",
            "task_type": TaskType.EMOTIONAL_INTELLIGENCE,
            "difficulty": TaskDifficulty.EASY,
            "points": 10
        },
        {
            "title": "Проявите эмпатию к коллеге",
            "description": "Попытайтесь понять точку зрения коллеги, с которым у вас есть разногласия.",
            "task_type": TaskType.EMOTIONAL_INTELLIGENCE,
            "difficulty": TaskDifficulty.MEDIUM,
            "points": 20
        },
        {
            "title": "Управляйте стрессом",
            "description": "Когда почувствуете стресс, примените технику дыхания или медитации для успокоения.",
            "task_type": TaskType.EMOTIONAL_INTELLIGENCE,
            "difficulty": TaskDifficulty.MEDIUM,
            "points": 25
        },
        {
            "title": "Поддержите коллегу",
            "description": "Найдите коллегу, который выглядит расстроенным или подавленным, и предложите поддержку.",
            "task_type": TaskType.EMOTIONAL_INTELLIGENCE,
            "difficulty": TaskDifficulty.EASY,
            "points": 15
        },
        {
            "title": "Практикуйте благодарность",
            "description": "Выразите искреннюю благодарность трем разным людям за их помощь или вклад.",
            "task_type": TaskType.EMOTIONAL_INTELLIGENCE,
            "difficulty": TaskDifficulty.EASY,
            "points": 10
        },
        {
            "title": "Разрешите внутренний конфликт",
            "description": "Определите внутренний конфликт или противоречие в себе и найдите способы его разрешения.",
            "task_type": TaskType.EMOTIONAL_INTELLIGENCE,
            "difficulty": TaskDifficulty.HARD,
            "points": 30
        },
        {
            "title": "Проведите самооценку",
            "description": "Честно оцените свое поведение в недавней сложной ситуации и подумайте, как можно было поступить лучше.",
            "task_type": TaskType.EMOTIONAL_INTELLIGENCE,
            "difficulty": TaskDifficulty.MEDIUM,
            "points": 20
        },
        {
            "title": "Измените негативную установку",
            "description": "Найдите одну негативную установку о работе или коллегах и замените её позитивной.",
            "task_type": TaskType.EMOTIONAL_INTELLIGENCE,
            "difficulty": TaskDifficulty.MEDIUM,
            "points": 25
        }
    ]
    
    # Создаем задания
    created_count = 0
    for task_data in tasks_data:
        # Проверяем, существует ли уже такое задание
        existing_task = db.query(DailyTask).filter(
            DailyTask.title == task_data["title"]
        ).first()
        
        if not existing_task:
            task = DailyTask(**task_data)
            db.add(task)
            created_count += 1
    
    db.commit()
    print(f"Создано {created_count} новых ежедневных заданий")
    
    return created_count 