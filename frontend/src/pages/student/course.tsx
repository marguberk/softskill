import { useNavigate, useParams } from "react-router-dom"
import { useState, useEffect } from "react"
import { Card, CardContent, CardHeader, CardTitle } from "../../components/ui/card"
import { Button } from "../../components/ui/button"
import {
  ChevronRight,
  CheckCircle,
  PlayCircle,
  BookOpen,
  Clock,  // Добавляем импорт Clock
  Users,  // Добавляем остальные необходимые иконки
  Award
} from "lucide-react"

// Временные данные для примера
const MOCK_COURSE = {
  id: 1,
  title: "Python для начинающих",
  description: "Полный курс по программированию на Python с нуля до профессионального уровня. Изучите основы программирования, работу с данными, ООП и создание реальных проектов.",
  author: "Иван Иванов",
  duration: "20 часов",
  studentsCount: 1234,
  rating: 4.8,
  reviewsCount: 256,
  price: 29900,
  progress: 35,
  modules: [
    {
      id: 1,
      title: "Введение в Python",
      description: "Основы языка и среда разработки",
      progress: 100,
      lessons: [
        {
          id: 1,
          title: "Установка Python и PyCharm",
          duration: "15 минут",
          type: "video",
          completed: true
        },
        {
          id: 2,
          title: "Первая программа",
          duration: "20 минут",
          type: "video",
          completed: true
        }
      ]
    },
    {
      id: 2,
      title: "Основы программирования",
      description: "Переменные, типы данных и операторы",
      progress: 50,
      lessons: [
        {
          id: 3,
          title: "Переменные и типы данных",
          duration: "30 минут",
          type: "video",
          completed: true
        },
        {
          id: 4,
          title: "Операторы и выражения",
          duration: "25 минут",
          type: "video",
          completed: false
        },
        {
          id: 5,
          title: "Практическое задание",
          duration: "45 минут",
          type: "practice",
          completed: false
        }
      ]
    }
  ]
}

export default function CoursePage() {
  const { courseId } = useParams()
  const navigate = useNavigate()
  const [course, setCourse] = useState(MOCK_COURSE)

  // TODO: Загрузка данных курса с API
  useEffect(() => {
    // Здесь будет запрос к API
  }, [courseId])

  return (
    <div className="space-y-8">
      {/* Заголовок курса */}
      <div className="flex justify-between items-start">
        <div>
          <h1 className="text-3xl font-bold tracking-tight">{course.title}</h1>
          <p className="text-muted-foreground mt-2">{course.description}</p>
        </div>
        <Button size="lg" className="min-w-[200px]">
          Продолжить обучение
        </Button>
      </div>

      {/* Статистика курса */}
      <div className="grid grid-cols-4 gap-4">
        <Card>
          <CardContent className="flex items-center gap-4 pt-6">
            <Clock className="h-8 w-8 text-primary" />
            <div>
              <p className="text-sm font-medium text-muted-foreground">
                Длительность
              </p>
              <p className="text-2xl font-bold">{course.duration}</p>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardContent className="flex items-center gap-4 pt-6">
            <Users className="h-8 w-8 text-primary" />
            <div>
              <p className="text-sm font-medium text-muted-foreground">
                Студентов
              </p>
              <p className="text-2xl font-bold">{course.studentsCount}</p>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardContent className="flex items-center gap-4 pt-6">
            <Award className="h-8 w-8 text-primary" />
            <div>
              <p className="text-sm font-medium text-muted-foreground">
                Рейтинг
              </p>
              <p className="text-2xl font-bold">{course.rating}</p>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardContent className="flex items-center gap-4 pt-6">
            <CheckCircle className="h-8 w-8 text-primary" />
            <div>
              <p className="text-sm font-medium text-muted-foreground">
                Прогресс
              </p>
              <p className="text-2xl font-bold">{course.progress}%</p>
            </div>
          </CardContent>
        </Card>
      </div>

      {/* Содержание курса */}
      <Card>
        <CardHeader>
          <CardTitle>Содержание курса</CardTitle>
          <CardDescription>
            Изучите материалы курса в удобном для вас темпе
          </CardDescription>
        </CardHeader>
        <CardContent>
          <div className="space-y-6">
            {course.modules.map((module) => (
              <div key={module.id} className="space-y-4">
                {/* Заголовок модуля */}
                <div className="flex items-center justify-between">
                  <div>
                    <h3 className="text-lg font-semibold">{module.title}</h3>
                    <p className="text-sm text-muted-foreground">
                      {module.description}
                    </p>
                  </div>
                  <div className="text-sm text-muted-foreground">
                    {module.progress}% завершено
                  </div>
                </div>

                {/* Список уроков */}
                <div className="pl-4 space-y-2">
                  {module.lessons.map((lesson) => (
                    <div
                      key={lesson.id}
                      className="flex items-center justify-between p-3 rounded-lg border hover:bg-muted/50 transition-colors cursor-pointer"
                      onClick={() => navigate(`/courses/${courseId}/lessons/${lesson.id}`)} // Добавляем навигацию
                    >
                      <div className="flex items-center gap-3">
                        {lesson.completed ? (
                          <CheckCircle className="h-5 w-5 text-primary" />
                        ) : (
                          lesson.type === 'video' ? (
                            <PlayCircle className="h-5 w-5 text-muted-foreground" />
                          ) : (
                            <BookOpen className="h-5 w-5 text-muted-foreground" />
                          )
                        )}
                        <span className="font-medium">{lesson.title}</span>
                      </div>
                      <div className="flex items-center gap-3 text-sm text-muted-foreground">
                        <span>{lesson.duration}</span>
                        <ChevronRight className="h-4 w-4" />
                      </div>
                    </div>
                  ))}
                </div>
              </div>
            ))}
          </div>
        </CardContent>
      </Card>
    </div>
  )
}