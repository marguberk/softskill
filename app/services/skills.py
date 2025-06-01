from sqlalchemy.orm import Session
from sqlalchemy import func
from datetime import datetime
from typing import List, Optional

from app.models.skills import (
    SoftSkill, SkillQuestion, QuestionOption, SkillAssessment,
    UserAnswer, UserSkillAssessment, SkillCategory, SkillLevel
)
from app.schemas.skills import (
    AssessmentStatus, UserAnswerCreate, AssessmentResult, UserSkillResult
)

class SkillAssessmentService:
    def __init__(self, db: Session):
        self.db = db

    def get_user_assessment_status(self, user_id: int) -> AssessmentStatus:
        """Проверяет статус прохождения теста пользователем"""
        
        # Проверяем, есть ли завершенный тест
        completed_assessment = self.db.query(SkillAssessment).filter(
            SkillAssessment.user_id == user_id,
            SkillAssessment.is_completed == True
        ).order_by(SkillAssessment.completed_at.desc()).first()
        
        # Проверяем, есть ли незавершенный тест
        incomplete_assessment = self.db.query(SkillAssessment).filter(
            SkillAssessment.user_id == user_id,
            SkillAssessment.is_completed == False
        ).first()
        
        if incomplete_assessment:
            return AssessmentStatus(
                needs_assessment=True,
                has_completed_assessment=False,
                message="У вас есть незавершенный тест на гибкие навыки. Продолжите прохождение."
            )
        
        if not completed_assessment:
            return AssessmentStatus(
                needs_assessment=True,
                has_completed_assessment=False,
                message="Пройдите тест на гибкие навыки для персонализации обучения."
            )
        
        return AssessmentStatus(
            needs_assessment=False,
            has_completed_assessment=True,
            last_assessment_date=completed_assessment.completed_at,
            message="Вы уже прошли тест на гибкие навыки."
        )

    def get_incomplete_assessment(self, user_id: int) -> Optional[SkillAssessment]:
        """Получает незавершенный тест пользователя"""
        return self.db.query(SkillAssessment).filter(
            SkillAssessment.user_id == user_id,
            SkillAssessment.is_completed == False
        ).first()

    def create_assessment(self, user_id: int) -> SkillAssessment:
        """Создает новый тест для пользователя"""
        assessment = SkillAssessment(user_id=user_id)
        self.db.add(assessment)
        self.db.commit()
        self.db.refresh(assessment)
        return assessment

    def get_total_questions_count(self) -> int:
        """Получает общее количество активных вопросов"""
        return self.db.query(SkillQuestion).filter(SkillQuestion.is_active == True).count()

    def get_question_by_number(self, question_number: int) -> Optional[SkillQuestion]:
        """Получает вопрос по номеру (начиная с 1)"""
        return self.db.query(SkillQuestion).filter(
            SkillQuestion.is_active == True
        ).order_by(SkillQuestion.order_index).offset(question_number - 1).first()

    def submit_assessment(self, assessment: SkillAssessment, answers: List[UserAnswerCreate]) -> AssessmentResult:
        """Обрабатывает отправку ответов и завершает тест"""
        
        # Сохраняем ответы
        for answer_data in answers:
            # Проверяем, что ответ еще не сохранен
            existing_answer = self.db.query(UserAnswer).filter(
                UserAnswer.assessment_id == assessment.id,
                UserAnswer.question_id == answer_data.question_id
            ).first()
            
            if not existing_answer:
                answer = UserAnswer(
                    assessment_id=assessment.id,
                    question_id=answer_data.question_id,
                    selected_option_id=answer_data.selected_option_id,
                    text_answer=answer_data.text_answer,
                    scale_value=answer_data.scale_value
                )
                self.db.add(answer)
        
        # Коммитим ответы перед расчетом результатов
        self.db.commit()
        
        # Рассчитываем результаты по навыкам
        skill_results = self._calculate_skill_results(assessment)
        
        # Обновляем тест как завершенный
        assessment.is_completed = True
        assessment.completed_at = datetime.utcnow()
        # Общий балл как среднее арифметическое всех навыков
        assessment.total_score = round(sum(result.score for result in skill_results) / len(skill_results)) if skill_results else 0
        
        self.db.commit()
        
        # Формируем результат
        recommendations = self._generate_recommendations(skill_results)
        
        return AssessmentResult(
            assessment_id=assessment.id,
            total_score=assessment.total_score,
            skill_results=[{
                "skill_id": result.skill_id,
                "skill_name": result.skill_name,
                "skill_category": result.skill_category,  # Возвращаем английское название
                "score": result.score,
                "level": result.level.value,  # Возвращаем английское значение enum
                "recommendations": result.recommendations
            } for result in skill_results],
            recommendations=recommendations,
            completion_message="Поздравляем! Вы успешно прошли тест на гибкие навыки."
        )

    def _calculate_skill_results(self, assessment: SkillAssessment) -> List[UserSkillResult]:
        """Рассчитывает результаты по каждому навыку"""
        results = []
        
        # Получаем все навыки
        skills = self.db.query(SoftSkill).all()
        
        for skill in skills:
            # Получаем ответы пользователя на вопросы по этому навыку
            skill_answers = self.db.query(UserAnswer).join(SkillQuestion).filter(
                UserAnswer.assessment_id == assessment.id,
                SkillQuestion.skill_id == skill.id
            ).all()
            
            if not skill_answers:
                continue
            
            # Рассчитываем общий балл
            total_score = 0
            max_possible_score = 0
            
            for answer in skill_answers:
                if answer.selected_option_id:
                    option = self.db.query(QuestionOption).filter(
                        QuestionOption.id == answer.selected_option_id
                    ).first()
                    if option:
                        total_score += option.score_weight
                elif answer.scale_value:
                    total_score += answer.scale_value
                
                # Получаем максимально возможный балл для этого вопроса
                question_max = self.db.query(func.max(QuestionOption.score_weight)).filter(
                    QuestionOption.question_id == answer.question_id
                ).scalar() or 5
                max_possible_score += question_max
            
            # Рассчитываем процент и округляем до целого числа
            if max_possible_score > 0:
                percentage = round((total_score / max_possible_score) * 100)
                level = self._determine_skill_level(percentage)
            else:
                percentage = 0
                level = SkillLevel.BEGINNER
            
            # Создаем запись результата
            skill_result = UserSkillAssessment(
                assessment_id=assessment.id,
                skill_id=skill.id,
                score=percentage,  # Сохраняем процент
                level=level,
                recommendations=self._get_skill_recommendations(skill, level)
            )
            self.db.add(skill_result)
            
            results.append(UserSkillResult(
                skill_id=skill.id,
                skill_name=skill.name,
                skill_category=skill.category,
                score=percentage,  # Возвращаем процент
                level=level,
                recommendations=skill_result.recommendations
            ))
        
        return results

    def _determine_skill_level(self, percentage: float) -> SkillLevel:
        """Определяет уровень навыка на основе процента правильных ответов"""
        if percentage >= 85:
            return SkillLevel.EXPERT
        elif percentage >= 70:
            return SkillLevel.ADVANCED
        elif percentage >= 50:
            return SkillLevel.INTERMEDIATE
        else:
            return SkillLevel.BEGINNER

    def _get_skill_recommendations(self, skill: SoftSkill, level: SkillLevel) -> str:
        """Генерирует рекомендации для навыка на основе уровня"""
        recommendations = {
            SkillLevel.BEGINNER: f"Рекомендуем изучить основы {skill.name.lower()}. Начните с базовых курсов.",
            SkillLevel.INTERMEDIATE: f"У вас средний уровень {skill.name.lower()}. Изучите продвинутые техники.",
            SkillLevel.ADVANCED: f"Отличный уровень {skill.name.lower()}! Можете помогать другим и углублять знания.",
            SkillLevel.EXPERT: f"Экспертный уровень {skill.name.lower()}! Рассмотрите возможность наставничества."
        }
        return recommendations.get(level, "Продолжайте развивать этот навык.")

    def _generate_recommendations(self, skill_results: List[UserSkillResult]) -> List[str]:
        """Генерирует общие рекомендации на основе результатов"""
        recommendations = []
        
        # Находим навыки с самыми низкими баллами
        weak_skills = [result for result in skill_results if result.level == SkillLevel.BEGINNER]
        strong_skills = [result for result in skill_results if result.level in [SkillLevel.ADVANCED, SkillLevel.EXPERT]]
        
        if weak_skills:
            recommendations.append(f"Обратите особое внимание на развитие: {', '.join([skill.skill_name for skill in weak_skills[:3]])}")
        
        if strong_skills:
            recommendations.append(f"Ваши сильные стороны: {', '.join([skill.skill_name for skill in strong_skills[:3]])}")
        
        recommendations.append("Регулярно практикуйте гибкие навыки в повседневной жизни и работе.")
        
        return recommendations

    def get_assessment_results(self, assessment: SkillAssessment) -> AssessmentResult:
        """Получает результаты завершенного теста"""
        skill_results = self.db.query(UserSkillAssessment).filter(
            UserSkillAssessment.assessment_id == assessment.id
        ).all()
        
        user_skill_results = []
        for result in skill_results:
            skill = self.db.query(SoftSkill).filter(SoftSkill.id == result.skill_id).first()
            user_skill_results.append(UserSkillResult(
                skill_id=result.skill_id,
                skill_name=skill.name,
                skill_category=skill.category,  # Английское название
                score=result.score,
                level=result.level,  # Английское значение enum
                recommendations=result.recommendations
            ))
        
        recommendations = self._generate_recommendations(user_skill_results)
        
        return AssessmentResult(
            assessment_id=assessment.id,
            total_score=assessment.total_score,
            skill_results=user_skill_results,
            recommendations=recommendations,
            completion_message="Результаты вашего теста на гибкие навыки."
        )

    def get_user_current_skills(self, user_id: int) -> List[UserSkillResult]:
        """Получает текущие навыки пользователя из последнего завершенного теста"""
        latest_assessment = self.db.query(SkillAssessment).filter(
            SkillAssessment.user_id == user_id,
            SkillAssessment.is_completed == True
        ).order_by(SkillAssessment.completed_at.desc()).first()
        
        if not latest_assessment:
            return []
        
        skill_results = self.db.query(UserSkillAssessment).filter(
            UserSkillAssessment.assessment_id == latest_assessment.id
        ).all()
        
        user_skills = []
        for result in skill_results:
            skill = self.db.query(SoftSkill).filter(SoftSkill.id == result.skill_id).first()
            user_skills.append(UserSkillResult(
                skill_id=result.skill_id,
                skill_name=skill.name,
                skill_category=skill.category,
                score=result.score,
                level=result.level,
                recommendations=result.recommendations
            ))
        
        return user_skills

    def _get_skill_level_russian(self, level: SkillLevel) -> str:
        """Переводит уровень навыка на русский"""
        translations = {
            SkillLevel.BEGINNER: "начальный",
            SkillLevel.INTERMEDIATE: "средний", 
            SkillLevel.ADVANCED: "продвинутый",
            SkillLevel.EXPERT: "эксперт"
        }
        return translations.get(level, "начальный")

    def _get_skill_category_russian(self, category: str) -> str:
        """Переводит категорию навыка на русский"""
        translations = {
            "communication": "коммуникация",
            "leadership": "лидерство",
            "teamwork": "командная работа", 
            "problem_solving": "решение проблем",
            "time_management": "управление временем",
            "emotional_intelligence": "эмоциональный интеллект"
        }
        return translations.get(category, category) 