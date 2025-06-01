import { useEffect, useState } from "react"
import { Card } from "../../components/ui/card"
import { BookOpen, Users, Award, Clock } from "lucide-react"
import { useAuthStore } from "../../stores/auth"

interface TeacherStats {
  totalStudents: number
  activeCourses: number
  totalLessons: number
  averageRating: number
}

export default function TeacherDashboard() {
  const user = useAuthStore(state => state.user)
  const [stats, setStats] = useState<TeacherStats>({
    totalStudents: 0,
    activeCourses: 0,
    totalLessons: 0,
    averageRating: 0
  })

  useEffect(() => {
    // TODO: Fetch real data from API
    setStats({
      totalStudents: 150,
      activeCourses: 5,
      totalLessons: 48,
      averageRating: 4.8
    })
  }, [])

  const statCards = [
    {
      name: "Всего студентов",
      value: stats.totalStudents,
      description: "Активных учеников",
      icon: Users,
    },
    {
      name: "Активные курсы",
      value: stats.activeCourses,
      description: `${stats.totalLessons} уроков создано`,
      icon: BookOpen,
    },
    {
      name: "Средний рейтинг",
      value: stats.averageRating,
      description: "На основе отзывов",
      icon: Award,
    },
    {
      name: "Время обучения",
      value: "120ч",
      description: "За последний месяц",
      icon: Clock,
    },
  ]

  return (
    <div className="space-y-8">
      <div>
        <h2 className="text-3xl font-bold tracking-tight">
          Добро пожаловать, {user?.full_name}!
        </h2>
        <p className="text-muted-foreground">
          Панель управления преподавателя
        </p>
      </div>

      <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-4">
        {statCards.map((stat) => (
          <Card key={stat.name} className="p-6">
            <div className="flex items-center gap-4">
              <stat.icon className="h-8 w-8 text-muted-foreground" />
              <div>
                <p className="text-sm font-medium text-muted-foreground">
                  {stat.name}
                </p>
                <h3 className="text-2xl font-bold tracking-tight mt-1">
                  {stat.value}
                </h3>
                <p className="text-sm text-muted-foreground mt-1">
                  {stat.description}
                </p>
              </div>
            </div>
          </Card>
        ))}
      </div>

      {/* Здесь будут дополнительные секции панели преподавателя */}
    </div>
  )
}