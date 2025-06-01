import { useEffect, useState } from "react"
import { Card, CardHeader, CardTitle, CardContent } from "../../components/ui/card"
import { Alert, AlertDescription } from "../../components/ui/alert"
import { Button } from "../../components/ui/button"
import {
  Trophy,
  CheckCircle,
  Clock,
  Star,
  Target,
  Zap,
  Calendar,
  Gift,
  Loader2
} from "lucide-react"

interface DailyTask {
  id: number
  title: string
  description: string
  task_type: string
  difficulty: string
  points: number
  is_active: boolean
  created_at: string
}

interface UserDailyTaskAssignment {
  id: number
  task_id: number
  assigned_date: string
  is_completed: boolean
  completed_at?: string
  task: DailyTask
}

interface DailyTasksPageData {
  today_tasks: UserDailyTaskAssignment[]
}

export default function DailyTasksPage() {
  const [pageData, setPageData] = useState<DailyTasksPageData | null>(null)
  const [isLoading, setIsLoading] = useState(true)
  const [completingTaskId, setCompletingTaskId] = useState<number | null>(null)
  const [successMessage, setSuccessMessage] = useState<string | null>(null)

  const API_BASE = 'http://127.0.0.1:8000/api/v1'

  const getAuthHeaders = () => {
    const token = localStorage.getItem('token') || localStorage.getItem('access_token')
    return {
      'Authorization': `Bearer ${token}`,
      'Content-Type': 'application/json'
    }
  }

  const loadPageData = async () => {
    try {
      setIsLoading(true)
      const response = await fetch(`${API_BASE}/tasks/daily`, {
        headers: getAuthHeaders()
      })
      
      if (response.ok) {
        const data = await response.json()
        setPageData({
          today_tasks: data.today_tasks
        })
      }
    } catch (error) {
      console.error('Ошибка при загрузке данных:', error)
    } finally {
      setIsLoading(false)
    }
  }

  const completeTask = async (taskId: number) => {
    try {
      setCompletingTaskId(taskId)
      const response = await fetch(`${API_BASE}/tasks/complete`, {
        method: 'POST',
        headers: getAuthHeaders(),
        body: JSON.stringify({ task_id: taskId })
      })
      
      if (response.ok) {
        const result = await response.json()
        setSuccessMessage(result.message)
        
        // Перезагружаем данные
        await loadPageData()
        
        // Убираем сообщение через 3 секунды
        setTimeout(() => setSuccessMessage(null), 3000)
      }
    } catch (error) {
      console.error('Ошибка при завершении задания:', error)
    } finally {
      setCompletingTaskId(null)
    }
  }

  useEffect(() => {
    loadPageData()
  }, [])

  const getDifficultyBadge = (difficulty: string) => {
    switch (difficulty) {
      case 'легкое':
        return <span className="px-2 py-1 text-xs font-medium rounded-full bg-green-100 text-green-800 hover:bg-green-100">Легкое</span>
      case 'среднее':
        return <span className="px-2 py-1 text-xs font-medium rounded-full bg-yellow-100 text-yellow-800 hover:bg-yellow-100">Среднее</span>
      case 'сложное':
        return <span className="px-2 py-1 text-xs font-medium rounded-full bg-red-100 text-red-800 hover:bg-red-100">Сложное</span>
      default:
        return <span className="px-2 py-1 text-xs font-medium rounded-full bg-gray-100 text-gray-800 hover:bg-gray-100">Неизвестно</span>
    }
  }

  const getTaskTypeIcon = (taskType: string) => {
    switch (taskType) {
      case 'communication': return <Star className="h-5 w-5" />
      case 'leadership': return <Trophy className="h-5 w-5" />
      case 'teamwork': return <Target className="h-5 w-5" />
      case 'problem_solving': return <Zap className="h-5 w-5" />
      case 'time_management': return <Clock className="h-5 w-5" />
      case 'emotional_intelligence': return <Gift className="h-5 w-5" />
      default: return <Star className="h-5 w-5" />
    }
  }

  const getTaskTypeLabel = (taskType: string) => {
    switch (taskType) {
      case 'communication': return 'Коммуникация'
      case 'leadership': return 'Лидерство'
      case 'teamwork': return 'Командная работа'
      case 'problem_solving': return 'Решение проблем'
      case 'time_management': return 'Управление временем'
      case 'emotional_intelligence': return 'Эмоциональный интеллект'
      default: return taskType
    }
  }

  if (isLoading) {
    return (
      <div className="flex items-center justify-center min-h-96">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary"></div>
      </div>
    )
  }

  if (!pageData) {
    return (
      <div className="text-center py-12">
        <p>Не удалось загрузить данные о заданиях</p>
      </div>
    )
  }

  return (
    <div className="space-y-8">
      {/* Заголовок */}
      <div>
        <h2 className="text-3xl font-bold tracking-tight flex items-center gap-3">
          <Calendar className="h-8 w-8 text-primary" />
          Задания
        </h2>
        <p className="text-muted-foreground">
          Выполняйте задания для развития гибких навыков и получения очков
        </p>
      </div>

      {/* Уведомление о выполнении */}
      {successMessage && (
        <Alert className="bg-green-50 border-green-200">
          <CheckCircle className="h-4 w-4 text-green-600" />
          <AlertDescription className="text-green-800">
            {successMessage}
          </AlertDescription>
        </Alert>
      )}

      {/* Задания на сегодня */}
      <Card>
        <CardHeader>
          <CardTitle className="flex items-center gap-2">
            <Calendar className="h-5 w-5" />
            Активные задания
          </CardTitle>
          <p className="text-sm text-muted-foreground">
            Выполните задания, чтобы получить очки и развить навыки. После каждого выполненного задания появится новое!
          </p>
        </CardHeader>
        <CardContent>
          <div className="space-y-3">
            {pageData.today_tasks.map((assignment) => (
              <div
                key={assignment.id}
                className="p-4 border rounded-lg space-y-3 hover:border-primary/50 transition-colors"
              >
                <div className="flex justify-between items-start">
                  <div className="flex items-center gap-2">
                    {getTaskTypeIcon(assignment.task.task_type)}
                    <span className="text-xs text-muted-foreground">
                      {getTaskTypeLabel(assignment.task.task_type)}
                    </span>
                  </div>
                  <div className="flex items-center gap-2">
                    {getDifficultyBadge(assignment.task.difficulty)}
                    <span className="text-sm font-medium text-primary">
                      +{assignment.task.points} очков
                    </span>
                  </div>
                </div>
                
                <div>
                  <h3 className="font-medium text-sm mb-1">{assignment.task.title}</h3>
                  <p className="text-xs text-muted-foreground leading-relaxed">
                    {assignment.task.description}
                  </p>
                </div>
                
                <div className="flex justify-between items-center">
                  {assignment.is_completed ? (
                    <div className="inline-flex items-center gap-1 px-2 py-1 bg-green-100 text-green-800 rounded-md text-xs font-medium hover:bg-green-100">
                      <CheckCircle className="h-3 w-3" />
                      Выполнено
                    </div>
                  ) : (
                    <Button
                      onClick={() => completeTask(assignment.task_id)}
                      disabled={completingTaskId === assignment.task_id}
                      size="sm"
                      variant="outline"
                      className="text-xs"
                    >
                      {completingTaskId === assignment.task_id ? (
                        <>
                          <Loader2 className="h-3 w-3 mr-1 animate-spin" />
                          Отмечается...
                        </>
                      ) : (
                        <>
                          <CheckCircle className="h-3 w-3 mr-1" />
                          Отметить выполненным
                        </>
                      )}
                    </Button>
                  )}
                </div>
              </div>
            ))}
          </div>
        </CardContent>
      </Card>
    </div>
  )
} 