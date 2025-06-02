import { useState, useEffect } from "react"
import { Card, CardContent, CardHeader, CardTitle } from "../../components/ui/card"
import { Badge } from "../../components/ui/badge"
import { Button } from "../../components/ui/button"
import { toast } from "sonner"
import { 
  Trophy, 
  TrendingUp, 
  Award, 
  Zap, 
  Star,
  Target,
  BookOpen,
  CheckCircle
} from "lucide-react"

interface ProgressData {
  level: number
  current_xp: number
  xp_to_next_level: number
  overall_progress: number
  courses_completed: number
  lessons_completed: number
  perfect_scores: number
  current_streak: number
  longest_streak: number
}

interface DashboardData {
  level: number
  level_name: string
  current_xp: number
  next_level_xp: number
  progress_percentage: number
  total_courses: number
  completed_courses: number
  skills_summary: Array<{
    name: string
    score: number
    level: string
  }>
  recent_achievements: string[]
}

export default function ProgressPage() {
  const [progress, setProgress] = useState<ProgressData | null>(null)
  const [dashboard, setDashboard] = useState<DashboardData | null>(null)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)

  useEffect(() => {
    loadProgressData()
  }, [])

  const loadProgressData = async () => {
    try {
      setLoading(true)
      setError(null)
      
      const token = localStorage.getItem('token')
      if (!token) {
        setError('Не авторизован')
        return
      }

      const headers = {
        'Authorization': `Bearer ${token}`,
        'Content-Type': 'application/json'
      }

      // Загружаем прогресс
      const progressResponse = await fetch('http://localhost:8002/api/v1/gamification/progress', { headers })
      if (!progressResponse.ok) {
        throw new Error(`Ошибка загрузки прогресса: ${progressResponse.status}`)
      }
      const progressData = await progressResponse.json()
      setProgress(progressData)

      // Загружаем дашборд
      const dashboardResponse = await fetch('http://localhost:8002/api/v1/gamification/dashboard', { headers })
      if (!dashboardResponse.ok) {
        throw new Error(`Ошибка загрузки дашборда: ${dashboardResponse.status}`)
      }
      const dashboardData = await dashboardResponse.json()
      setDashboard(dashboardData)

    } catch (error: any) {
      console.error('Ошибка загрузки данных прогресса:', error)
      setError(error.message)
    } finally {
      setLoading(false)
    }
  }

  if (loading) {
    return (
      <div className="space-y-6">
        <h2 className="text-3xl font-bold tracking-tight">Мой прогресс</h2>
        <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
          {[...Array(6)].map((_, i) => (
            <Card key={i}>
              <CardContent className="p-6">
                <div className="animate-pulse space-y-3">
                  <div className="h-4 bg-gray-200 rounded w-3/4"></div>
                  <div className="h-8 bg-gray-200 rounded w-1/2"></div>
                </div>
              </CardContent>
            </Card>
          ))}
        </div>
      </div>
    )
  }

  if (error) {
    return (
      <div className="space-y-6">
        <h2 className="text-3xl font-bold tracking-tight">Мой прогресс</h2>
        <Card>
          <CardContent className="p-6 text-center">
            <Trophy className="h-12 w-12 text-muted-foreground mx-auto mb-4" />
            <h3 className="text-lg font-medium mb-2">Ошибка загрузки</h3>
            <p className="text-muted-foreground mb-4">{error}</p>
            <Button onClick={loadProgressData}>Попробовать снова</Button>
          </CardContent>
        </Card>
      </div>
    )
  }

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <h2 className="text-3xl font-bold tracking-tight">🎮 Мой прогресс</h2>
        <Button onClick={loadProgressData} variant="outline">
          Обновить
        </Button>
      </div>

      {/* Основная статистика */}
      {dashboard && (
        <div className="grid gap-6 md:grid-cols-3">
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">Уровень</CardTitle>
              <Trophy className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{dashboard.level}</div>
              <p className="text-xs text-muted-foreground">{dashboard.level_name}</p>
              <div className="mt-2 w-full bg-gray-200 rounded-full h-2">
                <div 
                  className="bg-primary h-2 rounded-full transition-all duration-300" 
                  style={{ width: `${dashboard.progress_percentage}%` }}
                />
              </div>
              <p className="text-xs text-muted-foreground mt-1">
                {dashboard.current_xp} / {dashboard.next_level_xp} XP
              </p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">Опыт (XP)</CardTitle>
              <Zap className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{dashboard.current_xp}</div>
              <p className="text-xs text-muted-foreground">
                До следующего уровня: {progress?.xp_to_next_level || 0} XP
              </p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">Курсы</CardTitle>
              <BookOpen className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{dashboard.completed_courses}</div>
              <p className="text-xs text-muted-foreground">
                из {dashboard.total_courses} курсов
              </p>
            </CardContent>
          </Card>
        </div>
      )}

      {/* Детальная статистика */}
      {progress && (
        <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">Уроки</CardTitle>
              <Target className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{progress.lessons_completed}</div>
              <p className="text-xs text-muted-foreground">завершено</p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">Выполнено заданий</CardTitle>
              <CheckCircle className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{progress.perfect_scores}</div>
              <p className="text-xs text-muted-foreground">практических заданий</p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">Текущий стрик</CardTitle>
              <TrendingUp className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{progress.current_streak}</div>
              <p className="text-xs text-muted-foreground">дней подряд</p>
            </CardContent>
          </Card>
        </div>
      )}

      {/* Навыки */}
      {dashboard && dashboard.skills_summary.length > 0 && (
        <Card>
          <CardHeader>
            <CardTitle>Прогресс навыков</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              {dashboard.skills_summary.map((skill, index) => (
                <div key={index} className="flex items-center justify-between">
                  <div className="flex items-center gap-3">
                    <CheckCircle className="h-5 w-5 text-green-500" />
                    <div>
                      <p className="font-medium">{skill.name}</p>
                      <p className="text-sm text-muted-foreground">{skill.level}</p>
                    </div>
                  </div>
                  <div className="text-right">
                    <p className="text-lg font-bold">{skill.score}%</p>
                    <div className="w-24 bg-gray-200 rounded-full h-2 mt-1">
                      <div 
                        className="bg-green-500 h-2 rounded-full transition-all duration-300" 
                        style={{ width: `${skill.score}%` }}
                      />
                    </div>
                  </div>
                </div>
              ))}
            </div>
          </CardContent>
        </Card>
      )}
    </div>
  )
}