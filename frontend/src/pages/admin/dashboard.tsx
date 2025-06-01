import { useState, useEffect } from "react"
import { Card, CardHeader, CardTitle, CardContent } from "../../components/ui/card"
import { Button } from "../../components/ui/button"
import { Link } from "react-router-dom"
import {
  BookOpen,
  Users,
  FileText,
  BarChart,
  Plus,
  Eye,
  Edit
} from "lucide-react"

// Типы для статистики
interface AdminStats {
  total_materials: number
  published_materials: number
  draft_materials: number
  total_users: number
}

export default function AdminDashboard() {
  const [stats, setStats] = useState<AdminStats | null>(null)
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    // Здесь будет загрузка статистики из API
    // Пока используем мок данные
    setTimeout(() => {
      setStats({
        total_materials: 6,
        published_materials: 3,
        draft_materials: 3,
        total_users: 42
      })
      setLoading(false)
    }, 500)
  }, [])

  if (loading) {
    return (
      <div className="space-y-8">
        <div className="animate-pulse">
          <div className="h-8 bg-gray-200 rounded w-64 mb-4"></div>
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
            {[1, 2, 3, 4].map((i) => (
              <div key={i} className="h-32 bg-gray-200 rounded"></div>
            ))}
          </div>
        </div>
      </div>
    )
  }

  return (
    <div className="space-y-8">
      {/* Заголовок */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold tracking-tight">Панель управления</h1>
          <p className="text-muted-foreground">
            Добро пожаловать в административную панель MaroAI
          </p>
        </div>
        <Link to="/admin/materials/new">
          <Button>
            <Plus className="h-4 w-4 mr-2" />
            Создать материал
          </Button>
        </Link>
      </div>

      {/* Статистические карточки */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Всего материалов</CardTitle>
            <BookOpen className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{stats?.total_materials}</div>
            <p className="text-xs text-muted-foreground">
              Включая черновики
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Опубликовано</CardTitle>
            <Eye className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-green-600">{stats?.published_materials}</div>
            <p className="text-xs text-muted-foreground">
              Доступны студентам
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Черновики</CardTitle>
            <Edit className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-orange-600">{stats?.draft_materials}</div>
            <p className="text-xs text-muted-foreground">
              Требуют доработки
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Пользователи</CardTitle>
            <Users className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{stats?.total_users}</div>
            <p className="text-xs text-muted-foreground">
              Зарегистрированных
            </p>
          </CardContent>
        </Card>
      </div>

      {/* Быстрые действия */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        <Card>
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <BookOpen className="h-5 w-5" />
              Управление материалами
            </CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <p className="text-sm text-muted-foreground">
              Создавайте, редактируйте и публикуйте обучающие материалы
            </p>
            <div className="flex gap-2">
              <Link to="/admin/materials">
                <Button variant="outline" size="sm">
                  Все материалы
                </Button>
              </Link>
              <Link to="/admin/materials/new">
                <Button size="sm">
                  Создать новый
                </Button>
              </Link>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <Users className="h-5 w-5" />
              Пользователи
            </CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <p className="text-sm text-muted-foreground">
              Управление учетными записями и правами доступа
            </p>
            <Link to="/admin/users">
              <Button variant="outline" size="sm">
                Управлять пользователями
              </Button>
            </Link>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <BarChart className="h-5 w-5" />
              Аналитика
            </CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <p className="text-sm text-muted-foreground">
              Статистика использования и прогресс обучения
            </p>
            <Link to="/admin/analytics">
              <Button variant="outline" size="sm">
                Посмотреть отчеты
              </Button>
            </Link>
          </CardContent>
        </Card>
      </div>

      {/* Последние активности */}
      <Card>
        <CardHeader>
          <CardTitle>Последние активности</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="space-y-4">
            <div className="flex items-center gap-4 text-sm">
              <div className="w-2 h-2 bg-green-500 rounded-full"></div>
              <span className="text-muted-foreground">2 часа назад</span>
              <span>Материал "Эффективная коммуникация" был опубликован</span>
            </div>
            <div className="flex items-center gap-4 text-sm">
              <div className="w-2 h-2 bg-blue-500 rounded-full"></div>
              <span className="text-muted-foreground">5 часов назад</span>
              <span>Новый пользователь зарегистрировался в системе</span>
            </div>
            <div className="flex items-center gap-4 text-sm">
              <div className="w-2 h-2 bg-orange-500 rounded-full"></div>
              <span className="text-muted-foreground">1 день назад</span>
              <span>Создан черновик материала "Лидерство в команде"</span>
            </div>
          </div>
        </CardContent>
      </Card>
    </div>
  )
} 