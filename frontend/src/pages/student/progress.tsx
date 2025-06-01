import { useEffect, useState } from "react"
import { Card, CardHeader, CardTitle, CardContent } from "../../components/ui/card"
import { Progress } from "../../components/ui/progress"
import { Badge } from "../../components/ui/badge"
import {
  Trophy,
  CheckCircle,
  Star,
  TrendingUp,
  Target,
  Zap,
  Gift,
  Award,
  Crown,
  Calendar
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

interface UserLevel {
  user_id: number
  total_points: number
  current_level: number
  points_to_next_level: number
}

interface TaskCompletion {
  id: number
  task_id: number
  completed_at: string
  points_earned: number
  task: DailyTask
}

interface ProgressPageData {
  user_level: UserLevel
  recent_completions: TaskCompletion[]
}

export default function StudentProgress() {
  const [pageData, setPageData] = useState<ProgressPageData | null>(null)
  const [isLoading, setIsLoading] = useState(true)

  const API_BASE = 'http://127.0.0.1:8000/api/v1'

  const getAuthHeaders = () => {
    const token = localStorage.getItem('token') || localStorage.getItem('access_token')
    return {
      'Authorization': `Bearer ${token}`,
      'Content-Type': 'application/json'
    }
  }

  const loadProgressData = async () => {
    try {
      setIsLoading(true)
      const response = await fetch(`${API_BASE}/tasks/daily`, {
        headers: getAuthHeaders()
      })
      
      if (response.ok) {
        const data = await response.json()
        setPageData({
          user_level: data.user_level,
          recent_completions: data.recent_completions
        })
      }
    } catch (error) {
      console.error('Ошибка при загрузке данных прогресса:', error)
    } finally {
      setIsLoading(false)
    }
  }

  useEffect(() => {
    loadProgressData()
  }, [])

  // Расчет прогресса и очков для уровня
  const getLevelData = () => {
    if (!pageData) return { currentPoints: 0, totalPointsForLevel: 100, progressPercent: 0, pointsToNext: 100 }
    
    const currentLevel = pageData.user_level.current_level
    const totalPoints = pageData.user_level.total_points
    
    // Вычисляем очки для текущего уровня
    let pointsForCurrentLevel = 0
    let pointsForNextLevel = 0
    
    if (currentLevel === 1) {
      pointsForCurrentLevel = 0
      pointsForNextLevel = 100
    } else if (currentLevel === 2) {
      pointsForCurrentLevel = 100
      pointsForNextLevel = 250
    } else if (currentLevel === 3) {
      pointsForCurrentLevel = 250
      pointsForNextLevel = 450
    } else if (currentLevel === 4) {
      pointsForCurrentLevel = 450
      pointsForNextLevel = 700
    } else {
      pointsForCurrentLevel = 700 + (currentLevel - 5) * 300
      pointsForNextLevel = 700 + (currentLevel - 4) * 300
    }
    
    const pointsInCurrentLevel = totalPoints - pointsForCurrentLevel
    const pointsNeededForLevel = pointsForNextLevel - pointsForCurrentLevel
    const progressPercent = Math.max(0, Math.min(100, (pointsInCurrentLevel / pointsNeededForLevel) * 100))
    
    const pointsToNextLevel = pointsNeededForLevel - pointsInCurrentLevel
    
    return {
      currentPoints: pointsInCurrentLevel,
      totalPointsForLevel: pointsNeededForLevel,
      progressPercent,
      pointsToNext: pointsToNextLevel
    }
  }

  const getTaskTypeIcon = (taskType: string) => {
    switch (taskType) {
      case 'communication': return <Star className="h-4 w-4" />
      case 'leadership': return <Crown className="h-4 w-4" />
      case 'teamwork': return <Target className="h-4 w-4" />
      case 'problem_solving': return <Zap className="h-4 w-4" />
      case 'time_management': return <Calendar className="h-4 w-4" />
      case 'emotional_intelligence': return <Gift className="h-4 w-4" />
      default: return <Star className="h-4 w-4" />
    }
  }

  const getLevelTitle = (level: number) => {
    if (level <= 2) return "Новичок"
    if (level <= 4) return "Ученик"
    if (level <= 6) return "Практик"
    if (level <= 8) return "Эксперт"
    if (level <= 10) return "Мастер"
    return "Гуру"
  }

  const getLevelColor = (level: number) => {
    if (level <= 2) return "text-gray-600"
    if (level <= 4) return "text-blue-600"
    if (level <= 6) return "text-green-600"
    if (level <= 8) return "text-orange-600"
    if (level <= 10) return "text-red-600"
    return "text-purple-600"
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
        <p>Не удалось загрузить данные о прогрессе</p>
      </div>
    )
  }

  const levelData = getLevelData()

  return (
    <div className="space-y-8">
      {/* Заголовок */}
      <div>
        <h2 className="text-3xl font-bold tracking-tight flex items-center gap-3">
          <Trophy className="h-8 w-8 text-primary" />
          Мой прогресс
        </h2>
        <p className="text-muted-foreground">
          Отслеживайте свой уровень, достижения и общий прогресс в изучении
        </p>
      </div>

      {/* Уровень пользователя */}
      <div className="grid gap-6 md:grid-cols-2">
        <Card>
          <CardHeader className="pb-3">
            <div className="flex items-center gap-3">
              <div className={`p-3 rounded-full ${pageData.user_level.current_level <= 2 ? 'bg-gray-100' : 
                pageData.user_level.current_level <= 4 ? 'bg-blue-100' :
                pageData.user_level.current_level <= 6 ? 'bg-green-100' :
                pageData.user_level.current_level <= 8 ? 'bg-orange-100' :
                pageData.user_level.current_level <= 10 ? 'bg-red-100' : 'bg-purple-100'}`}>
                <Crown className={`h-6 w-6 ${getLevelColor(pageData.user_level.current_level)}`} />
              </div>
              <div>
                <h3 className="text-xl font-bold">
                  Уровень {pageData.user_level.current_level}
                </h3>
                <p className={`text-sm font-medium ${getLevelColor(pageData.user_level.current_level)}`}>
                  {getLevelTitle(pageData.user_level.current_level)}
                </p>
              </div>
            </div>
          </CardHeader>
          <CardContent className="pt-0">
            <div className="space-y-3">
              <div className="flex justify-between text-sm">
                <span>XP: {levelData.currentPoints} / {levelData.totalPointsForLevel}</span>
                <span className="text-muted-foreground">
                  {Math.round(levelData.progressPercent)}%
                </span>
              </div>
              <Progress value={levelData.progressPercent} className="h-3" />
              <p className="text-sm text-muted-foreground">
                Нужно еще {levelData.pointsToNext} очков для повышения уровня
              </p>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="pb-3">
            <CardTitle className="flex items-center gap-2">
              <TrendingUp className="h-5 w-5" />
              Общая статистика
            </CardTitle>
          </CardHeader>
          <CardContent className="pt-0">
            <div className="space-y-4">
              <div className="flex justify-between items-center">
                <span className="text-sm text-muted-foreground">Всего очков</span>
                <span className="font-semibold text-lg text-primary">
                  {pageData.user_level.total_points}
                </span>
              </div>
              <div className="flex justify-between items-center">
                <span className="text-sm text-muted-foreground">Выполнено заданий</span>
                <span className="font-semibold text-lg">
                  {pageData.recent_completions.length}
                </span>
              </div>
              <div className="flex justify-between items-center">
                <span className="text-sm text-muted-foreground">Текущий уровень</span>
                <Badge variant="outline" className="font-semibold">
                  {getLevelTitle(pageData.user_level.current_level)}
                </Badge>
              </div>
            </div>
          </CardContent>
        </Card>
      </div>

      {/* Недавние достижения */}
      {pageData.recent_completions.length > 0 && (
        <Card>
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <Award className="h-5 w-5" />
              Недавние достижения
            </CardTitle>
            <p className="text-sm text-muted-foreground">
              Ваши последние выполненные задания и полученные очки
            </p>
          </CardHeader>
          <CardContent>
            <div className="space-y-3">
              {pageData.recent_completions.map((completion) => (
                <div
                  key={completion.id}
                  className="flex items-center justify-between p-4 bg-green-50 border border-green-200 rounded-lg hover:bg-green-100 transition-colors"
                >
                  <div className="flex items-center gap-3">
                    <div className="p-2 bg-green-100 rounded-full">
                      {getTaskTypeIcon(completion.task.task_type)}
                    </div>
                    <div>
                      <p className="font-medium">{completion.task.title}</p>
                      <p className="text-sm text-muted-foreground">
                        {new Date(completion.completed_at).toLocaleDateString('ru-RU', {
                          day: 'numeric',
                          month: 'long',
                          year: 'numeric'
                        })}
                      </p>
                    </div>
                  </div>
                  <div className="text-right">
                    <span className="px-3 py-1 text-sm font-medium bg-green-100 text-green-800 rounded-full hover:bg-green-100">
                      +{completion.points_earned} очков
                    </span>
                  </div>
                </div>
              ))}
            </div>
          </CardContent>
        </Card>
      )}

      {/* Пустое состояние для достижений */}
      {pageData.recent_completions.length === 0 && (
        <Card>
          <CardContent className="py-12 text-center">
            <Trophy className="h-12 w-12 text-muted-foreground mx-auto mb-4" />
            <h3 className="text-lg font-medium mb-2">Пока нет достижений</h3>
            <p className="text-muted-foreground">
              Начните выполнять задания, чтобы получить первые достижения!
            </p>
          </CardContent>
        </Card>
      )}
    </div>
  )
}