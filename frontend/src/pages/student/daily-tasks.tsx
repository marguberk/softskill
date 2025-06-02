import { useEffect, useState } from "react"
import { Card, CardHeader, CardTitle, CardContent } from "../../components/ui/card"
import { Alert, AlertDescription } from "../../components/ui/alert"
import { Button } from "../../components/ui/button"
import { toast } from "sonner"
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

  const API_BASE = 'http://127.0.0.1:8002/api/v1'

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
        
        // Используем toast уведомления вместо setSuccessMessage
        if (result.success) {
          toast.success(result.message)
          
          // Если был level up, показываем дополнительное уведомление
          if (result.new_level) {
            toast.success(`🎉 Повышение уровня! Теперь вы ${result.new_level} уровня!`)
          }
        } else {
          toast.error(result.message)
        }
        
        // Перезагружаем данные
        await loadPageData()
      } else {
        toast.error('Ошибка при выполнении задания')
      }
    } catch (error) {
      console.error('Ошибка при завершении задания:', error)
      toast.error('Ошибка при выполнении задания')
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
        return null
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
    <div className="space-y-6 md:space-y-8">
      {/* Заголовок */}
      <div className="space-y-2">
        <h2 className="text-2xl md:text-3xl font-bold tracking-tight flex items-center gap-3">
          <Calendar className="h-6 w-6 md:h-8 md:w-8 text-primary" />
          Задания
        </h2>
        <p className="text-muted-foreground text-sm md:text-base">
          Выполняйте задания для развития гибких навыков и получения очков
        </p>
      </div>

      {/* Карточки заданий напрямую */}
      <div className="space-y-3 md:space-y-4">
        {pageData.today_tasks.length > 0 ? (
          pageData.today_tasks
            .sort((a, b) => {
              // Сначала показываем незавершенные задания
              if (!a.is_completed && b.is_completed) return -1
              if (a.is_completed && !b.is_completed) return 1
              // Затем сортируем по дате назначения (новые сверху)
              return new Date(b.assigned_date).getTime() - new Date(a.assigned_date).getTime()
            })
            .map((assignment) => (
              <Card key={assignment.id} className="hover:shadow-md transition-shadow">
                <CardContent className="p-4 md:p-6">
                  <div className="space-y-3 md:space-y-4">
                    <div className="flex flex-col sm:flex-row sm:justify-between sm:items-start gap-3">
                      <div className="flex items-center gap-2">
                        {getTaskTypeIcon(assignment.task.task_type)}
                        <span className="text-xs md:text-sm text-muted-foreground">
                          {getTaskTypeLabel(assignment.task.task_type)}
                        </span>
                      </div>
                      <div className="flex items-center gap-2 justify-between sm:justify-end">
                        <span className="text-sm font-medium text-primary">
                          +{assignment.task.points} очков
                        </span>
                        {(() => {
                          const difficultyBadge = getDifficultyBadge(assignment.task.difficulty)
                          return difficultyBadge ? difficultyBadge : null
                        })()}
                      </div>
                    </div>

                    <div className="space-y-2">
                      <h3 className="text-lg md:text-xl font-semibold leading-tight">
                        {assignment.task.title}
                      </h3>
                      <p className="text-muted-foreground text-sm md:text-base leading-relaxed">
                        {assignment.task.description}
                      </p>
                    </div>

                    <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-3 pt-2">
                      <div className="text-xs md:text-sm text-muted-foreground">
                        {assignment.is_completed ? (
                          <div className="flex items-center gap-2 text-green-600">
                            <CheckCircle className="h-4 w-4" />
                            <span>Выполнено {assignment.completed_at ? new Date(assignment.completed_at).toLocaleDateString() : ''}</span>
                          </div>
                        ) : (
                          <div className="flex items-center gap-2">
                            <Clock className="h-4 w-4" />
                            <span>Назначено {new Date(assignment.assigned_date).toLocaleDateString()}</span>
                          </div>
                        )}
                      </div>

                      {!assignment.is_completed && (
                        <Button
                          onClick={() => completeTask(assignment.task_id)}
                          disabled={completingTaskId === assignment.task_id}
                          className="w-full sm:w-auto"
                          size="sm"
                        >
                          {completingTaskId === assignment.task_id ? (
                            <>
                              <Loader2 className="h-4 w-4 mr-2 animate-spin" />
                              Выполняется...
                            </>
                          ) : (
                            <>
                              <CheckCircle className="h-4 w-4 mr-2" />
                              Выполнить
                            </>
                          )}
                        </Button>
                      )}
                    </div>
                  </div>
                </CardContent>
              </Card>
            ))
        ) : (
          <Card className="text-center py-8 md:py-12">
            <CardContent className="p-4 md:p-6">
              <Calendar className="h-12 w-12 md:h-16 md:w-16 text-muted-foreground mx-auto mb-4" />
              <h3 className="text-lg md:text-xl font-semibold mb-2">На сегодня заданий нет</h3>
              <p className="text-muted-foreground text-sm md:text-base">
                Новые задания будут назначены завтра
              </p>
            </CardContent>
          </Card>
        )}
      </div>
    </div>
  )
}