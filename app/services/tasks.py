from sqlalchemy.orm import Session
from sqlalchemy import func, and_
from datetime import datetime, date, timedelta
from typing import List
import random

from app.models.tasks import DailyTask, TaskCompletion, UserDailyTaskAssignment, UserLevel, TaskType, TaskDifficulty
from app.models.user import User
from app.schemas.tasks import DailyTasksPageResponse, UserLevelResponse, CompleteTaskResponse
from app.services.gamification import GamificationService


class TasksService:
    def __init__(self, db: Session):
        self.db = db

    def get_or_create_user_level(self, user_id: int) -> UserLevel:
        """Получить или создать уровень пользователя"""
        user_level = self.db.query(UserLevel).filter(UserLevel.user_id == user_id).first()
        if not user_level:
            user_level = UserLevel(
                user_id=user_id,
                total_points=0,
                current_level=1,
                points_to_next_level=100
            )
            self.db.add(user_level)
            self.db.commit()
            self.db.refresh(user_level)
        return user_level

    def assign_daily_tasks(self, user_id: int) -> List[UserDailyTaskAssignment]:
        """Назначить ежедневные задания пользователю"""
        today = date.today()
        
        # Проверяем, есть ли уже незавершенные задания на сегодня
        incomplete_assignments = self.db.query(UserDailyTaskAssignment).filter(
            and_(
                UserDailyTaskAssignment.user_id == user_id,
                func.date(UserDailyTaskAssignment.assigned_date) == today,
                UserDailyTaskAssignment.is_completed == False
            )
        ).all()
        
        # Если есть незавершенные задания, возвращаем их
        if incomplete_assignments:
            return incomplete_assignments
        
        # Получаем все задания на сегодня (включая завершенные)
        all_today_assignments = self.db.query(UserDailyTaskAssignment).filter(
            and_(
                UserDailyTaskAssignment.user_id == user_id,
                func.date(UserDailyTaskAssignment.assigned_date) == today
            )
        ).all()
        
        # Получаем уже назначенные задания на сегодня
        assigned_task_ids = [a.task_id for a in all_today_assignments]
        
        # Получаем все активные задания, исключая уже назначенные сегодня
        available_tasks = self.db.query(DailyTask).filter(
            and_(
                DailyTask.is_active == True,
                ~DailyTask.id.in_(assigned_task_ids) if assigned_task_ids else True
            )
        ).all()
        
        if not available_tasks:
            return all_today_assignments
        
        # Выбираем 1 случайное задание для назначения
        selected_task = random.choice(available_tasks)
        
        assignment = UserDailyTaskAssignment(
            user_id=user_id,
            task_id=selected_task.id,
            assigned_date=datetime.now()
        )
        self.db.add(assignment)
        self.db.commit()
        
        # Возвращаем все задания на сегодня (включая новое)
        return self.db.query(UserDailyTaskAssignment).filter(
            and_(
                UserDailyTaskAssignment.user_id == user_id,
                func.date(UserDailyTaskAssignment.assigned_date) == today
            )
        ).all()

    def _select_diverse_tasks(self, tasks: List[DailyTask], count: int) -> List[DailyTask]:
        """Выбрать разнообразные задания"""
        # Группируем задания по типам
        tasks_by_type = {}
        for task in tasks:
            if task.task_type not in tasks_by_type:
                tasks_by_type[task.task_type] = []
            tasks_by_type[task.task_type].append(task)
        
        selected = []
        types_used = set()
        
        # Сначала выбираем по одному заданию каждого типа
        for task_type, type_tasks in tasks_by_type.items():
            if len(selected) < count:
                task = random.choice(type_tasks)
                selected.append(task)
                types_used.add(task_type)
        
        # Если нужно больше заданий, выбираем случайно из оставшихся
        remaining_tasks = [t for t in tasks if t not in selected]
        while len(selected) < count and remaining_tasks:
            task = random.choice(remaining_tasks)
            selected.append(task)
            remaining_tasks.remove(task)
        
        return selected

    def get_today_tasks(self, user_id: int) -> List[UserDailyTaskAssignment]:
        """Получить задания на сегодня"""
        today = date.today()
        
        assignments = self.db.query(UserDailyTaskAssignment).filter(
            and_(
                UserDailyTaskAssignment.user_id == user_id,
                func.date(UserDailyTaskAssignment.assigned_date) == today
            )
        ).all()
        
        if not assignments:
            assignments = self.assign_daily_tasks(user_id)
        
        return assignments

    def complete_task(self, user_id: int, task_id: int) -> CompleteTaskResponse:
        """Отметить задание как выполненное"""
        today = date.today()
        
        # Находим назначение задания
        assignment = self.db.query(UserDailyTaskAssignment).filter(
            and_(
                UserDailyTaskAssignment.user_id == user_id,
                UserDailyTaskAssignment.task_id == task_id,
                func.date(UserDailyTaskAssignment.assigned_date) == today,
                UserDailyTaskAssignment.is_completed == False
            )
        ).first()
        
        if not assignment:
            return CompleteTaskResponse(
                success=False,
                points_earned=0,
                message="Задание не найдено или уже выполнено"
            )
        
        task = self.db.query(DailyTask).filter(DailyTask.id == task_id).first()
        if not task:
            return CompleteTaskResponse(
                success=False,
                points_earned=0,
                message="Задание не найдено"
            )
        
        # Отмечаем как выполненное
        assignment.is_completed = True
        assignment.completed_at = datetime.now()
        
        # Создаем запись о выполнении
        completion = TaskCompletion(
            user_id=user_id,
            task_id=task_id,
            points_earned=task.points
        )
        self.db.add(completion)
        
        # Используем систему геймификации для начисления XP
        gamification_service = GamificationService(self.db)
        
        # Добавляем новый метод для ежедневных заданий в GamificationService
        try:
            xp_result = gamification_service.complete_daily_task(user_id, task_id, task.points)
            
            self.db.commit()
            
            # Проверяем, нужно ли назначить новое задание
            self._assign_new_task_if_needed(user_id)
            
            message = f"🎉 Задание выполнено! Получено {xp_result.xp_gained} XP!"
            if xp_result.level_up:
                message += f" Вы достигли {xp_result.new_level} уровня!"
            
            return CompleteTaskResponse(
                success=True,
                points_earned=xp_result.xp_gained,
                new_level=xp_result.new_level if xp_result.level_up else None,
                message=message
            )
        except Exception as e:
            # Если возникла ошибка с геймификацией, используем старую систему как fallback
            print(f"Ошибка геймификации: {e}")
            
            # Обновляем уровень пользователя (старая система)
            user_level = self.get_or_create_user_level(user_id)
            old_level = user_level.current_level
            user_level.total_points += task.points
            
            # Проверяем повышение уровня
            new_level = self._calculate_level(user_level.total_points)
            level_up = new_level > old_level
            
            if level_up:
                user_level.current_level = new_level
            
            # Обновляем очки до следующего уровня
            points_for_next_level = self._points_for_next_level(user_level.current_level)
            user_level.points_to_next_level = max(0, points_for_next_level - user_level.total_points)
            
            self.db.commit()
            
            # Проверяем, нужно ли назначить новое задание
            self._assign_new_task_if_needed(user_id)
            
            message = f"Поздравляем! Вы получили {task.points} очков!"
            if level_up:
                message += f" Вы достигли {new_level} уровня!"
            
            return CompleteTaskResponse(
                success=True,
                points_earned=task.points,
                new_level=new_level if level_up else None,
                message=message
            )

    def _assign_new_task_if_needed(self, user_id: int) -> None:
        """Назначить новое задание после выполнения предыдущего"""
        today = date.today()
        
        # Получаем все незавершенные задания на сегодня
        incomplete_assignments = self.db.query(UserDailyTaskAssignment).filter(
            and_(
                UserDailyTaskAssignment.user_id == user_id,
                func.date(UserDailyTaskAssignment.assigned_date) == today,
                UserDailyTaskAssignment.is_completed == False
            )
        ).all()
        
        # Если нет незавершенных заданий, назначаем новое
        if len(incomplete_assignments) == 0:
            # Получаем уже назначенные задания на сегодня
            today_assignments = self.db.query(UserDailyTaskAssignment).filter(
                and_(
                    UserDailyTaskAssignment.user_id == user_id,
                    func.date(UserDailyTaskAssignment.assigned_date) == today
                )
            ).all()
            
            assigned_task_ids = [a.task_id for a in today_assignments]
            
            # Получаем все активные задания, исключая уже назначенные сегодня
            available_tasks = self.db.query(DailyTask).filter(
                and_(
                    DailyTask.is_active == True,
                    ~DailyTask.id.in_(assigned_task_ids) if assigned_task_ids else True
                )
            ).all()
            
            if available_tasks:
                # Выбираем случайное задание
                new_task = random.choice(available_tasks)
                
                # Создаем новое назначение
                new_assignment = UserDailyTaskAssignment(
                    user_id=user_id,
                    task_id=new_task.id,
                    assigned_date=datetime.now()
                )
                self.db.add(new_assignment)
                self.db.commit()

    def _calculate_level(self, total_points: int) -> int:
        """Вычислить уровень по общему количеству очков"""
        # Уровень 1: 0-99 очков
        # Уровень 2: 100-249 очков  
        # Уровень 3: 250-449 очков
        # Уровень 4: 450-699 очков
        # И так далее...
        level = 1
        points_needed = 100
        
        while total_points >= points_needed:
            level += 1
            points_needed += level * 50 + (level - 1) * 50
        
        return level

    def _points_for_next_level(self, current_level: int) -> int:
        """Вычислить очки, необходимые для следующего уровня"""
        # Уровень 1 -> 2: 100 очков
        # Уровень 2 -> 3: 250 очков  
        # Уровень 3 -> 4: 450 очков
        # Уровень 4 -> 5: 700 очков
        if current_level == 1:
            return 100
        elif current_level == 2:
            return 250
        elif current_level == 3:
            return 450
        elif current_level == 4:
            return 700
        else:
            # Для высоких уровней: добавляем по 300 очков за каждый уровень после 4-го
            return 700 + (current_level - 4) * 300

    def get_recent_completions(self, user_id: int, limit: int = 5) -> List[TaskCompletion]:
        """Получить недавние выполненные задания"""
        return self.db.query(TaskCompletion).filter(
            TaskCompletion.user_id == user_id
        ).order_by(TaskCompletion.completed_at.desc()).limit(limit).all()

    def get_daily_tasks_page_data(self, user_id: int) -> DailyTasksPageResponse:
        """Получить все данные для страницы ежедневных заданий"""
        today_tasks = self.get_today_tasks(user_id)
        user_level = self.get_or_create_user_level(user_id)
        recent_completions = self.get_recent_completions(user_id)
        
        return DailyTasksPageResponse(
            today_tasks=today_tasks,
            user_level=user_level,
            recent_completions=recent_completions
        ) 