import { useEffect, useState } from "react"
import { Card, CardHeader, CardTitle, CardContent } from "../../components/ui/card"
import { Alert, AlertDescription } from "../../components/ui/alert"
import { Progress } from "../../components/ui/progress"
import {
  Brain,
  TrendingUp,
  Award,
  Target,
  Calendar,
  ChevronRight,
  AlertCircle,
  CheckCircle,
  Star
} from "lucide-react"
import { useAuthStore } from "../../stores/auth"
import { Button } from "../../components/ui/button"
import { useNavigate } from "react-router-dom"

interface AssessmentStatus {
  needs_assessment: boolean
  has_completed_assessment: boolean
  last_assessment_date?: string
  message: string
}

interface SkillResult {
  skill_id: number
  skill_name: string
  skill_category: string
  score: number
  level: string
  recommendations: string
}

interface AssessmentResult {
  assessment_id: number
  total_score: number
  skill_results: SkillResult[]
  recommendations: string[]
  completion_message: string
}

export default function StudentDashboard() {
  const navigate = useNavigate()
  const user = useAuthStore(state => state.user)
  const [assessmentStatus, setAssessmentStatus] = useState<AssessmentStatus | null>(null)
  const [assessmentResults, setAssessmentResults] = useState<AssessmentResult | null>(null)
  const [isLoadingAssessment, setIsLoadingAssessment] = useState(true)
  const [isLoadingResults, setIsLoadingResults] = useState(false)

  const API_BASE = 'http://127.0.0.1:8000/api/v1'

  const getAuthHeaders = () => {
    const token = localStorage.getItem('token') || localStorage.getItem('access_token')
    return {
      'Authorization': `Bearer ${token}`,
      'Content-Type': 'application/json'
    }
  }

  const getSkillCategoryRussian = (category: string) => {
    const translations: { [key: string]: string } = {
      "communication": "коммуникация",
      "leadership": "лидерство", 
      "teamwork": "командная работа",
      "problem_solving": "решение проблем",
      "time_management": "управление временем",
      "emotional_intelligence": "эмоциональный интеллект"
    }
    return translations[category] || category
  }

  const getSkillLevelRussian = (level: string) => {
    const translations: { [key: string]: string } = {
      "beginner": "начальный",
      "intermediate": "средний",
      "advanced": "продвинутый", 
      "expert": "эксперт"
    }
    return translations[level] || level
  }

  const getLevelColor = (level: string) => {
    switch (level.toLowerCase()) {
      case 'expert': return 'text-green-600'
      case 'advanced': return 'text-blue-600'
      case 'intermediate': return 'text-yellow-600'
      case 'beginner': return 'text-red-600'
      default: return 'text-gray-600'
    }
  }

  const getLevelBadge = (level: string) => {
    switch (level.toLowerCase()) {
      case 'expert': return 'bg-emerald-100 text-emerald-800'
      case 'advanced': return 'bg-primary/20 text-primary'
      case 'intermediate': return 'bg-amber-100 text-amber-800'
      case 'beginner': return 'bg-red-100 text-red-800'
      default: return 'bg-gray-100 text-gray-800'
    }
  }

  const checkAssessmentStatus = async () => {
    try {
      const response = await fetch(`${API_BASE}/skills/status`, {
        headers: getAuthHeaders()
      })
      
      if (response.ok) {
        const status = await response.json()
        setAssessmentStatus(status)
        
        // Если тест пройден, загружаем результаты
        if (status.has_completed_assessment) {
          loadAssessmentResults()
        }
      }
    } catch (error) {
      console.error('Ошибка при проверке статуса тестирования:', error)
    } finally {
      setIsLoadingAssessment(false)
    }
  }

  const loadAssessmentResults = async () => {
    try {
      setIsLoadingResults(true)
      const response = await fetch(`${API_BASE}/skills/results`, {
        headers: getAuthHeaders()
      })
      
      if (response.ok) {
        const results = await response.json()
        setAssessmentResults(results)
      }
    } catch (error) {
      console.error('Ошибка при загрузке результатов:', error)
    } finally {
      setIsLoadingResults(false)
    }
  }

  useEffect(() => {
    checkAssessmentStatus()
  }, [])

  const getOverallLevel = (score: number) => {
    if (score >= 85) return { level: 'эксперт', color: 'text-gray-900' }
    if (score >= 70) return { level: 'продвинутый', color: 'text-gray-900' }
    if (score >= 50) return { level: 'средний', color: 'text-gray-900' }
    return { level: 'начальный', color: 'text-gray-900' }
  }

  return (
    <div className="space-y-8">
      {/* Приветствие */}
      <div>
        <h2 className="text-3xl font-bold tracking-tight">
          Добро пожаловать, {user?.full_name}!
        </h2>
        <p className="text-muted-foreground">
          Ваш прогресс в развитии гибких навыков
        </p>
      </div>

      {/* Предложение пройти тест на навыки */}
      {!isLoadingAssessment && assessmentStatus?.needs_assessment && (
        <Alert className="skills-notification">
          <Brain className="h-4 w-4 text-primary" />
          <AlertDescription className="flex items-center justify-between">
            <div>
              <p className="font-medium skills-notification-text mb-1">
                Пройдите тест на гибкие навыки
              </p>
              <p className="skills-notification-text">
                {assessmentStatus.message}
              </p>
            </div>
            <Button 
              onClick={() => navigate('/skills-assessment')}
              className="ml-4 skills-notification-button text-white hover:skills-notification-button/90"
            >
              Пройти тест
            </Button>
          </AlertDescription>
        </Alert>
      )}

      {/* Статистика общих результатов */}
      {assessmentResults && (
        <>
      <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-4">
        <Card className="p-6">
          <div className="flex items-center gap-4">
                <Award className="h-8 w-8 text-primary" />
            <div>
              <p className="text-sm font-medium text-muted-foreground">
                    Общий прогресс
              </p>
              <h3 className="text-2xl font-bold tracking-tight mt-1">
                    {assessmentResults.total_score}%
              </h3>
            </div>
          </div>
        </Card>

        <Card className="p-6">
          <div className="flex items-center gap-4">
                <Target className="h-8 w-8 text-primary" />
            <div>
              <p className="text-sm font-medium text-muted-foreground">
                    Ваш уровень
              </p>
                  <h3 className={`text-2xl font-bold tracking-tight mt-1 ${getOverallLevel(assessmentResults.total_score).color}`}>
                    {getOverallLevel(assessmentResults.total_score).level}
              </h3>
            </div>
          </div>
        </Card>

        <Card className="p-6">
          <div className="flex items-center gap-4">
                <Brain className="h-8 w-8 text-primary" />
            <div>
              <p className="text-sm font-medium text-muted-foreground">
                    Навыков оценено
              </p>
              <h3 className="text-2xl font-bold tracking-tight mt-1">
                    {assessmentResults.skill_results.length}
              </h3>
            </div>
          </div>
        </Card>

        <Card className="p-6">
          <div className="flex items-center gap-4">
            <TrendingUp className="h-8 w-8 text-primary" />
            <div>
              <p className="text-sm font-medium text-muted-foreground">
                    Вопросов пройдено
              </p>
              <h3 className="text-2xl font-bold tracking-tight mt-1">
                    {assessmentResults.skill_results.length * 2}
              </h3>
            </div>
          </div>
        </Card>
      </div>

          {/* Ваши навыки */}
        <Card>
          <CardHeader className="space-y-1">
              <CardTitle className="text-2xl">Ваши навыки</CardTitle>
            <p className="text-sm text-muted-foreground">
                Результаты тестирования по каждому навыку
            </p>
          </CardHeader>
          <CardContent>
              <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
                {assessmentResults.skill_results.map((skill) => (
                <div
                    key={skill.skill_id}
                    className="p-4 border rounded-lg space-y-3"
                >
                    <div className="flex justify-between items-center">
                      <h4 className="font-semibold">{skill.skill_name}</h4>
                      <span className={`px-2 py-1 text-xs font-medium rounded-full ${getLevelBadge(skill.level)}`}>
                        {getSkillLevelRussian(skill.level)}
                      </span>
                    </div>

                    <div className="space-y-2">
                      <div className="flex justify-between text-sm">
                        <span>Ваш результат</span>
                        <span className="font-medium">{skill.score}%</span>
                  </div>
                      <Progress value={skill.score} className="h-2" />
                  </div>

                  <p className="text-sm text-muted-foreground">
                      {skill.recommendations}
                  </p>
                </div>
              ))}
            </div>
          </CardContent>
        </Card>
        </>
      )}

      {/* Действия */}
      <Card>
        <CardHeader className="space-y-1">
          <CardTitle className="text-2xl">Следующие шаги</CardTitle>
          <p className="text-sm text-muted-foreground">
            Что вы можете сделать для развития навыков
          </p>
        </CardHeader>
        <CardContent>
          <div className="grid gap-4 md:grid-cols-3">
            <div className="p-4 border rounded-lg text-center space-y-3 flex flex-col">
              <Brain className="h-8 w-8 text-primary mx-auto" />
              <h4 className="font-semibold">Пройти тест заново</h4>
              <p className="text-sm text-muted-foreground flex-grow">
                Проверьте свой прогресс через некоторое время
              </p>
              <Button 
                variant="outline" 
                onClick={() => navigate('/skills-assessment')}
                className="w-full mt-auto"
              >
                Пройти заново
              </Button>
            </div>

            <div className="p-4 border rounded-lg text-center space-y-3 flex flex-col">
              <Target className="h-8 w-8 text-primary mx-auto" />
              <h4 className="font-semibold">Курсы развития</h4>
              <p className="text-sm text-muted-foreground flex-grow">
                Найдите курсы для улучшения навыков
              </p>
              <Button 
                variant="outline" 
                className="w-full mt-auto"
                onClick={() => navigate('/courses')}
              >
                Изучить курсы
              </Button>
                  </div>

            <div className="p-4 border rounded-lg text-center space-y-3 flex flex-col">
              <Award className="h-8 w-8 text-primary mx-auto" />
              <h4 className="font-semibold">Практические задания</h4>
              <p className="text-sm text-muted-foreground flex-grow">
                Применяйте навыки на практике
              </p>
              <Button 
                variant="outline" 
                className="w-full mt-auto"
                onClick={() => navigate('/practice')}
              >
                Начать практику
              </Button>
              </div>
          </div>
        </CardContent>
      </Card>

      {/* Если тест не пройден */}
      {!isLoadingAssessment && !assessmentStatus?.has_completed_assessment && !assessmentStatus?.needs_assessment && (
        <Card className="text-center py-12">
          <CardContent>
            <Brain className="h-16 w-16 text-muted-foreground mx-auto mb-4" />
            <h3 className="text-xl font-semibold mb-2">Начните с тестирования навыков</h3>
            <p className="text-muted-foreground mb-6">
              Пройдите тест, чтобы узнать свой уровень гибких навыков и получить персональные рекомендации
            </p>
            <Button onClick={() => navigate('/skills-assessment')}>
              Пройти тест
            </Button>
          </CardContent>
        </Card>
      )}

      {/* Загрузка */}
      {(isLoadingAssessment || isLoadingResults) && (
        <Card className="text-center py-12">
          <CardContent>
            <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary mx-auto mb-4"></div>
            <p>Загружаем ваши результаты...</p>
          </CardContent>
        </Card>
      )}
    </div>
  )
}