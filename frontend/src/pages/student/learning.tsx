import { useState, useEffect } from "react"
import { Link } from "react-router-dom"
import { Card, CardContent } from "../../components/ui/card"
import { Input } from "../../components/ui/input"
import { Badge } from "../../components/ui/badge"
import {
  BookOpen,
  Search,
  Clock,
  Star,
  Users,
  Play,
  Calendar,
  CheckCircle,
  Award
} from "lucide-react"

// Обновленный интерфейс для курсов
interface Course {
  id: number
  title: string
  description: string
  skill_type: string
  difficulty_level: 'beginner' | 'intermediate' | 'advanced'
  duration_hours: number
  is_published: boolean
  created_at: string
}

const SKILLS_MAP = {
  communication: 'Коммуникация',
  leadership: 'Лидерство',
  problem_solving: 'Решение проблем',
  time_management: 'Управление временем',
  emotional_intelligence: 'Эмоциональный интеллект',
  teamwork: 'Командная работа',
  COMMUNICATION: 'Коммуникация',
  LEADERSHIP: 'Лидерство',
  PROBLEM_SOLVING: 'Решение проблем',
  TIME_MANAGEMENT: 'Управление временем',
  EMOTIONAL_INTELLIGENCE: 'Эмоциональный интеллект',
  TEAMWORK: 'Командная работа'
}

const LEVEL_MAP = {
  beginner: 'Начинающий',
  intermediate: 'Средний',
  advanced: 'Продвинутый',
  BEGINNER: 'Начинающий',
  INTERMEDIATE: 'Средний',
  ADVANCED: 'Продвинутый'
}

export default function LearningPage() {
  const [courses, setCourses] = useState<Course[]>([])
  const [loading, setLoading] = useState(true)
  const [searchQuery, setSearchQuery] = useState("")

  // Функция проверки завершения курса
  const isCourseCompleted = async (courseId: number): Promise<boolean> => {
    try {
      const response = await fetch(`http://localhost:8002/api/v1/courses/${courseId}/lessons`)
      if (!response.ok) return false
      
      const lessonsData = await response.json()
      const completedLessons = JSON.parse(localStorage.getItem('completedLessons') || '{}')
      
      return lessonsData.lessons.every((lesson: any) => {
        const lessonKey = `${courseId}-${lesson.lesson_id}`
        return completedLessons[lessonKey] || false
      })
    } catch (error) {
      console.error('Ошибка проверки завершения курса:', error)
      return false
    }
  }

  // Загружаем курсы из нового API
  useEffect(() => {
    loadCourses()
  }, [])

  const loadCourses = async () => {
    try {
      setLoading(true)
      const response = await fetch('http://localhost:8002/api/v1/courses/')
      
      if (!response.ok) {
        throw new Error('Ошибка загрузки курсов')
      }

      const data = await response.json()
      setCourses(data)
    } catch (error) {
      console.error('Ошибка загрузки курсов:', error)
    } finally {
      setLoading(false)
    }
  }

  const getLevelColor = (level: string) => {
    switch (level) {
      case 'beginner':
        return 'bg-green-100 text-green-800'
      case 'intermediate':
        return 'bg-yellow-100 text-yellow-800'
      case 'advanced':
        return 'bg-red-100 text-red-800'
      default:
        return 'bg-gray-100 text-gray-800'
    }
  }

  const filteredCourses = courses.filter(course => {
    const matchesSearch = course.title.toLowerCase().includes(searchQuery.toLowerCase()) ||
                         course.description.toLowerCase().includes(searchQuery.toLowerCase())
    return matchesSearch
  })

  // Компонент карточки курса с проверкой завершения
  const CourseCard = ({ course }: { course: Course }) => {
    const [isCompleted, setIsCompleted] = useState(false)
    const [checkingCompletion, setCheckingCompletion] = useState(true)

    useEffect(() => {
      const checkCompletion = async () => {
        const completed = await isCourseCompleted(course.id)
        setIsCompleted(completed)
        setCheckingCompletion(false)
      }
      checkCompletion()
    }, [course.id])

    return (
      <Link to={`/courses/${course.id}`}>
        <Card className="overflow-hidden hover:shadow-lg transition-shadow cursor-pointer h-full">
          <CardContent className="p-4 h-full flex flex-col">
            <div className="flex flex-col h-full space-y-3">
              <div className="flex items-start justify-between">
                <div className="flex items-center gap-2 flex-wrap">
                  <Badge variant="secondary">
                    {SKILLS_MAP[course.skill_type as keyof typeof SKILLS_MAP] || course.skill_type}
                  </Badge>
                  {isCompleted && (
                    <Badge variant="default" className="bg-green-100 text-green-800 hover:bg-green-100">
                      ✅ Завершен
                    </Badge>
                  )}
                </div>
                <div className="flex items-center gap-2">
                  {checkingCompletion ? (
                    <div className="w-4 h-4 border-2 border-gray-300 border-t-primary rounded-full animate-spin" />
                  ) : isCompleted ? (
                    <div className="flex items-center gap-1">
                      <CheckCircle className="h-4 w-4 text-green-500" />
                      <Award className="h-4 w-4 text-yellow-500" />
                    </div>
                  ) : (
                    <Play className="h-4 w-4 text-primary" />
                  )}
                </div>
              </div>
              
              <div className="flex-1">
                <h3 className="font-semibold text-lg mb-2 line-clamp-2 min-h-[2.5rem]">
                  {course.title}
                </h3>
                <p className="text-sm text-muted-foreground line-clamp-2 min-h-[2.5rem]">
                  {course.description}
                </p>
              </div>
              
              <div className="space-y-2 mt-auto">
                <div className="flex items-center justify-between text-xs text-muted-foreground">
                  <div className="flex items-center gap-1">
                    <Clock className="h-3 w-3" />
                    {course.duration_hours} часов
                  </div>
                  <div className="flex items-center gap-1">
                    <Calendar className="h-3 w-3" />
                    {new Date(course.created_at).toLocaleDateString('ru-RU')}
                  </div>
                </div>
              </div>
            </div>
          </CardContent>
        </Card>
      </Link>
    )
  }

  if (loading) {
    return (
      <div className="space-y-8">
        <div>
          <h2 className="text-3xl font-bold tracking-tight flex items-center gap-3">
            <BookOpen className="h-8 w-8 text-primary" />
            Обучение
          </h2>
          <p className="text-muted-foreground">
            Загрузка курсов...
          </p>
        </div>
        <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
          {[...Array(6)].map((_, i) => (
            <Card key={i} className="h-full">
              <CardContent className="p-6 h-full flex flex-col">
                <div className="animate-pulse space-y-3 flex flex-col h-full">
                  <div className="h-4 bg-gray-200 rounded w-3/4"></div>
                  <div className="h-3 bg-gray-200 rounded w-1/2"></div>
                  <div className="flex-1"></div>
                  <div className="h-3 bg-gray-200 rounded w-1/4"></div>
                </div>
              </CardContent>
            </Card>
          ))}
        </div>
      </div>
    )
  }

  return (
    <div className="space-y-8">
      {/* Заголовок и описание */}
      <div>
        <h2 className="text-3xl font-bold tracking-tight flex items-center gap-3">
          <BookOpen className="h-8 w-8 text-primary" />
          Обучение
        </h2>
        <p className="text-muted-foreground">
          Бесплатные курсы для развития профессиональных навыков. Начните изучение прямо сейчас!
        </p>
      </div>

      {/* Поиск */}
      <div className="relative">
        <Search className="absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-muted-foreground" />
        <Input
          placeholder="Поиск курсов..."
          className="pl-10"
          value={searchQuery}
          onChange={(e) => setSearchQuery(e.target.value)}
        />
      </div>

      {/* Сетка курсов */}
      <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
        {filteredCourses.map((course) => (
          <CourseCard key={course.id} course={course} />
        ))}
      </div>

      {/* Пустое состояние */}
      {filteredCourses.length === 0 && !loading && (
        <Card>
          <CardContent className="py-12 text-center">
            <BookOpen className="h-12 w-12 text-muted-foreground mx-auto mb-4" />
            <h3 className="text-lg font-medium mb-2">
              {courses.length === 0 ? 'Курсы не найдены' : 'Нет результатов поиска'}
            </h3>
            <p className="text-muted-foreground">
              {courses.length === 0 
                ? 'Пока нет доступных курсов'
                : 'Попробуйте изменить параметры поиска'
              }
            </p>
          </CardContent>
        </Card>
      )}
    </div>
  )
} 