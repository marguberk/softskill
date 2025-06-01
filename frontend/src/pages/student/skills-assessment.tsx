import React, { useState, useEffect } from 'react'
import { useNavigate } from 'react-router-dom'
import { Button } from '../../components/ui/button'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '../../components/ui/card'
import { Progress } from '../../components/ui/progress'
import { Alert, AlertDescription } from '../../components/ui/alert'
import { CheckCircle, Clock, TrendingUp, Brain } from 'lucide-react'

interface Question {
  id: number
  question_text: string
  question_type: string
  skill_category: string
  options: Array<{
    id: number
    option_text: string
    score_weight: number
    order_index: number
  }>
  current_question: number
  total_questions: number
}

interface Answer {
  question_id: number
  selected_option_id?: number
  text_answer?: string
  scale_value?: number
}

interface AssessmentResult {
  assessment_id: number
  total_score: number
  skill_results: Array<{
    skill_id: number
    skill_name: string
    skill_category: string
    score: number
    level: string
    recommendations: string
  }>
  recommendations: string[]
  completion_message: string
}

const SkillsAssessment: React.FC = () => {
  const navigate = useNavigate()
  const [assessmentId, setAssessmentId] = useState<number | null>(null)
  const [currentQuestion, setCurrentQuestion] = useState<Question | null>(null)
  const [answers, setAnswers] = useState<Answer[]>([])
  const [currentQuestionNumber, setCurrentQuestionNumber] = useState(1)
  const [selectedOption, setSelectedOption] = useState<number | null>(null)
  const [isLoading, setIsLoading] = useState(false)
  const [isCompleted, setIsCompleted] = useState(false)
  const [results, setResults] = useState<AssessmentResult | null>(null)
  const [error, setError] = useState<string | null>(null)

  const API_BASE = 'http://127.0.0.1:8000/api/v1'

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

  useEffect(() => {
    startAssessment()
  }, [])

  const getAuthHeaders = () => {
    const token = localStorage.getItem('token') || localStorage.getItem('access_token')
    return {
      'Authorization': `Bearer ${token}`,
      'Content-Type': 'application/json'
    }
  }

  const startAssessment = async () => {
    try {
      setIsLoading(true)
      const response = await fetch(`${API_BASE}/skills/start`, {
        method: 'POST',
        headers: getAuthHeaders()
      })

      if (response.status === 401) {
        localStorage.removeItem('token')
        localStorage.removeItem('access_token')
        navigate('/login')
        return
      }

      if (!response.ok) {
        throw new Error('Не удалось начать тест')
      }

      const data = await response.json()
      setAssessmentId(data.assessment_id)
      await loadQuestion(1)
    } catch (err: any) {
      setError(err.message)
    } finally {
      setIsLoading(false)
    }
  }

  const loadQuestion = async (questionNumber: number) => {
    try {
      const response = await fetch(`${API_BASE}/skills/question/${questionNumber}`, {
        headers: getAuthHeaders()
      })

      if (response.status === 401) {
        localStorage.removeItem('token')
        localStorage.removeItem('access_token')
        navigate('/login')
        return
      }

      if (!response.ok) {
        throw new Error('Не удалось загрузить вопрос')
      }

      const question = await response.json()
      setCurrentQuestion(question)
      setCurrentQuestionNumber(questionNumber)
      setSelectedOption(null)
    } catch (err: any) {
      setError(err.message)
    }
  }

  const handleAnswer = (optionId: number) => {
    if (!currentQuestion) return

    setSelectedOption(optionId)
    
    // Обновляем ответы
    const newAnswer: Answer = {
      question_id: currentQuestion.id,
      selected_option_id: optionId
    }

    setAnswers(prev => {
      const filtered = prev.filter(a => a.question_id !== currentQuestion.id)
      return [...filtered, newAnswer]
    })

    // Автоматический переход к следующему вопросу через небольшую задержку
    setTimeout(() => {
      if (currentQuestionNumber < currentQuestion.total_questions) {
        loadQuestion(currentQuestionNumber + 1)
      } else {
        submitAssessment()
      }
    }, 500) // Небольшая задержка для визуального подтверждения выбора
  }

  const handleNext = async () => {
    if (!currentQuestion || selectedOption === null) return

    if (currentQuestionNumber < currentQuestion.total_questions) {
      await loadQuestion(currentQuestionNumber + 1)
    } else {
      await submitAssessment()
    }
  }

  const submitAssessment = async () => {
    if (!assessmentId || answers.length === 0) return

    try {
      setIsLoading(true)
      console.log('Отправляю результаты:', {
        assessment_id: assessmentId,
        answers: answers
      })
      
      const response = await fetch(`${API_BASE}/skills/submit`, {
        method: 'POST',
        headers: getAuthHeaders(),
        body: JSON.stringify({
          assessment_id: assessmentId,
          answers: answers
        })
      })

      if (response.status === 401) {
        // Если токен истек, перенаправляем на логин
        localStorage.removeItem('token')
        localStorage.removeItem('access_token')
        navigate('/login')
        return
      }

      if (!response.ok) {
        const errorText = await response.text()
        console.error('Ошибка ответа:', response.status, errorText)
        throw new Error(`Не удалось отправить ответы: ${response.status}`)
      }

      const result = await response.json()
      console.log('Полученные результаты:', result)
      
      if (!result.skill_results || result.skill_results.length === 0) {
        console.warn('Результаты по навыкам отсутствуют:', result)
      }
      
      setResults(result)
      setIsCompleted(true)
    } catch (err: any) {
      console.error('Полная ошибка:', err)
      if (err.message.includes('Failed to fetch')) {
        setError('Проблема с подключением к серверу. Проверьте интернет-соединение.')
      } else {
        setError(err.message)
      }
    } finally {
      setIsLoading(false)
    }
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

  if (error) {
    return (
      <div className="container mx-auto px-4 py-8">
        <Alert variant="destructive">
          <AlertDescription>{error}</AlertDescription>
        </Alert>
        <Button 
          onClick={() => navigate('/dashboard')} 
          className="mt-4"
        >
          Вернуться к дашборду
        </Button>
      </div>
    )
  }

  if (isCompleted && results) {
    return (
      <div className="container mx-auto px-4 py-6 max-w-5xl">
        {/* Заголовок и общий результат */}
        <div className="grid gap-4 md:grid-cols-3 mb-6">
          <div className="md:col-span-2">
            <h2 className="text-3xl font-bold tracking-tight mb-2">
              Тест завершен
            </h2>
            <p className="text-muted-foreground">
              {results.completion_message}
            </p>
          </div>
          <Card className="p-4">
            <div className="flex items-center gap-3">
              <CheckCircle className="h-6 w-6 text-primary" />
              <div>
                <p className="text-sm font-medium text-muted-foreground">
                  Общий результат
                </p>
                <h3 className="text-xl font-bold tracking-tight">
                  {results.total_score}%
                </h3>
              </div>
            </div>
          </Card>
        </div>

        {/* Результаты по навыкам */}
        {results.skill_results && results.skill_results.length > 0 ? (
          <Card className="mb-6">
            <CardHeader className="pb-4">
              <CardTitle className="text-xl">Ваши навыки</CardTitle>
              <CardDescription>
                Результаты по всем областям
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="grid gap-3 md:grid-cols-2 lg:grid-cols-3">
                {results.skill_results.map((skill) => (
                  <div
                    key={skill.skill_id}
                    className="p-3 border rounded-lg space-y-2"
                  >
                    <div className="flex justify-between items-center">
                      <h4 className="font-medium text-sm">{skill.skill_name}</h4>
                    </div>

                    <div className="w-full bg-secondary rounded-full h-1.5">
                      <div
                        className="bg-primary rounded-full h-1.5 transition-all"
                        style={{ width: `${Math.min(skill.score, 100)}%` }}
                      />
                    </div>

                    <p className="text-xs text-muted-foreground line-clamp-2">
                      {skill.recommendations}
                    </p>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        ) : (
          <Card className="mb-6">
            <CardContent className="text-center py-8">
              <p className="text-muted-foreground">
                Результаты обрабатываются...
              </p>
            </CardContent>
          </Card>
        )}

        {/* Рекомендации */}
        <Card className="mb-6">
          <CardHeader className="pb-3">
            <CardTitle className="text-xl">Рекомендации</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="space-y-2">
              {results.recommendations.map((rec, index) => (
                <div key={index} className="flex items-start gap-2">
                  <div className="flex-shrink-0 w-1.5 h-1.5 bg-primary rounded-full mt-2" />
                  <p className="text-sm">{rec}</p>
                </div>
              ))}
            </div>
          </CardContent>
        </Card>

        {/* Действия */}
        <div className="text-center">
          <Button onClick={() => navigate('/dashboard')}>
            Перейти к обучению
          </Button>
        </div>
      </div>
    )
  }

  if (isLoading) {
    return (
      <div className="container mx-auto px-4 py-8 text-center">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary mx-auto mb-4"></div>
        <p>Загружаем тест...</p>
      </div>
    )
  }

  if (!currentQuestion) {
    return (
      <div className="container mx-auto px-4 py-8 text-center">
        <p>Загрузка вопроса...</p>
      </div>
    )
  }

  const progress = (currentQuestionNumber / currentQuestion.total_questions) * 100

  return (
    <div className="container mx-auto px-4 py-8 max-w-3xl">
      <div className="mb-6">
        <div className="flex justify-between items-center mb-2">
          <h1 className="text-2xl font-bold">Тест на гибкие навыки</h1>
          <div className="flex items-center gap-2 text-sm text-gray-600">
            <Clock className="h-4 w-4" />
            Вопрос {currentQuestionNumber} из {currentQuestion.total_questions}
          </div>
        </div>
        <Progress value={progress} className="w-full" />
      </div>

      <Card>
        <CardHeader>
          <CardTitle className="text-lg">
            {currentQuestion.question_text}
          </CardTitle>
          <CardDescription>
            Навык: {getSkillCategoryRussian(currentQuestion.skill_category)}
          </CardDescription>
        </CardHeader>
        <CardContent>
          <div className="space-y-3">
            {currentQuestion.options.map((option) => (
              <label
                key={option.id}
                className={`flex items-center p-4 border rounded-lg cursor-pointer transition-colors ${
                  selectedOption === option.id
                    ? 'border-primary bg-primary/10'
                    : 'border-gray-200 hover:bg-gray-50'
                }`}
              >
                <input
                  type="radio"
                  name="answer"
                  value={option.id}
                  checked={selectedOption === option.id}
                  onChange={() => handleAnswer(option.id)}
                  className="sr-only"
                />
                <div className={`w-4 h-4 rounded-full border-2 mr-3 ${
                  selectedOption === option.id
                    ? 'border-primary bg-primary'
                    : 'border-gray-300'
                }`}>
                  {selectedOption === option.id && (
                    <div className="w-2 h-2 rounded-full bg-white m-0.5"></div>
                  )}
                </div>
                <span className="text-gray-900">{option.option_text}</span>
              </label>
            ))}
          </div>

          <div className="flex justify-between mt-6">
            <Button
              variant="outline"
              onClick={() => navigate('/dashboard')}
            >
              Отменить
            </Button>
            <div className="text-sm text-muted-foreground">
              {selectedOption ? 'Переход к следующему вопросу...' : 'Выберите ответ для продолжения'}
            </div>
          </div>
        </CardContent>
      </Card>
    </div>
  )
}

export default SkillsAssessment 