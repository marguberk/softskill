import { useNavigate, useParams } from "react-router-dom"
import { useState, useEffect } from "react"
import { Card, CardContent, CardHeader, CardTitle } from "../../components/ui/card"
import { Button } from "../../components/ui/button"
import { Badge } from "../../components/ui/badge"
import { toast } from "sonner"
import {
  ChevronRight,
  CheckCircle,
  PlayCircle,
  BookOpen,
  Clock,
  Users,
  Award,
  ArrowLeft,
  Video,
  FileText,
  CheckSquare
} from "lucide-react"
import { generateCertificate } from "../../utils/certificateGenerator"
import { useAuthStore } from "../../stores/auth"
import { userStorage } from "../../utils/userStorage"

// Интерфейс для курса
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

// Интерфейс для урока
interface Lesson {
  lesson_id: number
  order_position: number
  is_required: boolean
  material: {
    id: number
    title: string
    description: string
    content_type: string
    duration_minutes: number
    theory_content: string
    video_url: string
    video_id: string
    author: string | null
  }
  tasks: Array<{
    id: number
    title: string
    description: string
    order_position: number
  }>
}

// Интерфейс для данных уроков курса
interface CourseLessonsData {
  course: {
    id: number
    title: string
  }
  lessons: Lesson[]
  total_lessons: number
}

const SKILLS_MAP_EN = {
  communication: 'Communication',
  leadership: 'Leadership',
  problem_solving: 'Problem Solving',
  time_management: 'Time Management',
  emotional_intelligence: 'Emotional Intelligence',
  teamwork: 'Teamwork'
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

export default function CoursePage() {
  const { courseId } = useParams()
  const navigate = useNavigate()
  const { user } = useAuthStore()
  const [course, setCourse] = useState<Course | null>(null)
  const [lessonsData, setLessonsData] = useState<CourseLessonsData | null>(null)
  const [loading, setLoading] = useState(true)
  const [courseProgress, setCourseProgress] = useState(0)

  useEffect(() => {
    // Мигрируем старые данные при первом использовании
    userStorage.migrateOldData()
    
    if (courseId) {
      loadCourseData(Number(courseId))
    }
  }, [courseId])

  useEffect(() => {
    // Вычисляем прогресс курса когда загружаются уроки
    if (lessonsData && courseId) {
      calculateProgress()
    }
  }, [lessonsData, courseId])

  const calculateProgress = () => {
    if (!lessonsData || !courseId) return

    const completedLessons = userStorage.getCompletedLessons()
    const totalLessons = lessonsData.lessons.length
    let completedCount = 0

    lessonsData.lessons.forEach(lesson => {
      const lessonKey = `${courseId}-${lesson.lesson_id}`
      if (completedLessons[lessonKey]) {
        completedCount++
      }
    })

    const progress = totalLessons > 0 ? Math.round((completedCount / totalLessons) * 100) : 0
    setCourseProgress(progress)
  }

  const isLessonCompleted = (lessonId: number) => {
    const completedLessons = userStorage.getCompletedLessons()
    return !!completedLessons[`${courseId}-${lessonId}`]
  }

  const isAllLessonsCompleted = () => {
    if (!lessonsData || !courseId) return false
    return lessonsData.lessons.every(lesson => isLessonCompleted(lesson.lesson_id))
  }

  const handleGetCertificate = async () => {
    if (!course || !courseId) return
    
    // Получаем имя пользователя из профиля
    const studentName = user?.full_name || 'Student'
    
    if (!studentName || studentName === 'Student') {
      toast.error('Пожалуйста, заполните ваше полное имя в профиле для получения сертификата')
      navigate('/profile')
      return
    }
    
    // Вызываем API геймификации для завершения курса
    try {
      const token = localStorage.getItem('token')
      if (token) {
        const response = await fetch(`http://localhost:8002/api/v1/gamification/complete-course/${courseId}`, {
          method: 'POST',
          headers: {
            'Authorization': `Bearer ${token}`,
            'Content-Type': 'application/json'
          }
        })
        
        if (response.ok) {
          const result = await response.json()
          console.log('Результат завершения курса:', result)
          
          // Показываем подробное уведомление
          if (result.xp_result && result.skill_result) {
            const message = `🎉 Курс завершен!\n\n` +
              `💰 Получено XP: ${result.xp_result.xp_gained}\n` +
              `📊 Общий XP: ${result.xp_result.total_xp}\n` +
              `⬆️ Уровень: ${result.xp_result.new_level}${result.xp_result.level_up ? ' (ПОВЫШЕНИЕ!)' : ''}\n\n` +
              `🎯 Навык "${result.skill_result.skill_name}":\n` +
              `   ${result.skill_result.old_score}% → ${result.skill_result.new_score}%\n` +
              `   ${result.skill_result.old_level} → ${result.skill_result.new_level}${result.skill_result.level_up ? ' (УЛУЧШЕНИЕ!)' : ''}\n\n` +
              `🏆 Достижения: ${result.achievements.length > 0 ? result.achievements.join(', ') : 'Нет новых'}`
            
            toast.success(message)
          }
        } else {
          // Если курс уже завершен, это нормально, просто генерируем сертификат
          const errorData = await response.json()
          if (!errorData.detail?.includes('уже завершен')) {
            console.error('Ошибка завершения курса:', errorData)
          }
        }
      }
    } catch (error) {
      console.error('Ошибка при завершении курса:', error)
    }
    
    // Генерируем сертификат
    generateCertificate({
      studentName,
      courseName: course.title,
      courseType: SKILLS_MAP[course.skill_type as keyof typeof SKILLS_MAP] || course.skill_type,
      completionDate: new Date().toLocaleDateString('ru-RU'),
      duration: course.duration_hours
    })
  }

  const loadCourseData = async (id: number) => {
    try {
      setLoading(true)
      
      // Загружаем информацию о курсе
      const courseResponse = await fetch(`http://localhost:8002/api/v1/courses/${id}`)
      if (!courseResponse.ok) {
        throw new Error('Курс не найден')
      }
      const courseData = await courseResponse.json()
      setCourse(courseData)

      // Загружаем уроки курса
      const lessonsResponse = await fetch(`http://localhost:8002/api/v1/courses/${id}/lessons`)
      if (lessonsResponse.ok) {
        const lessonsData = await lessonsResponse.json()
        setLessonsData(lessonsData)
      }
    } catch (error) {
      console.error('Ошибка загрузки курса:', error)
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

  const getContentTypeIcon = (contentType: string) => {
    switch (contentType.toLowerCase()) {
      case 'video':
        return <Video className="h-4 w-4" />
      case 'article':
        return <FileText className="h-4 w-4" />
      default:
        return <BookOpen className="h-4 w-4" />
    }
  }

  if (loading) {
    return (
      <div className="space-y-8">
        <div className="flex items-center gap-3">
          <Button variant="outline" size="sm" onClick={() => navigate('/learning')}>
            <ArrowLeft className="h-4 w-4 mr-2" />
            Назад
          </Button>
        </div>
        
        <Card>
          <CardContent className="p-8">
            <div className="animate-pulse space-y-4">
              <div className="h-8 bg-gray-200 rounded w-3/4"></div>
              <div className="h-4 bg-gray-200 rounded w-1/2"></div>
              <div className="h-32 bg-gray-200 rounded"></div>
            </div>
          </CardContent>
        </Card>
      </div>
    )
  }

  if (!course) {
    return (
      <div className="space-y-8">
        <div className="flex items-center gap-3">
          <Button variant="outline" size="sm" onClick={() => navigate('/learning')}>
            <ArrowLeft className="h-4 w-4 mr-2" />
            Назад
          </Button>
        </div>
        
        <Card>
          <CardContent className="py-12 text-center">
            <BookOpen className="h-12 w-12 text-muted-foreground mx-auto mb-4" />
            <h3 className="text-lg font-medium mb-2">Курс не найден</h3>
            <p className="text-muted-foreground">
              Возможно, курс был удален или у вас нет доступа к нему
            </p>
          </CardContent>
        </Card>
      </div>
    )
  }

  return (
    <div className="space-y-6 md:space-y-8">
      {/* Навигация */}
      <div className="flex items-center gap-3">
        <Button variant="outline" size="sm" onClick={() => navigate('/learning')}>
          <ArrowLeft className="h-4 w-4 mr-2" />
          <span className="hidden sm:inline">Назад к курсам</span>
          <span className="sm:hidden">Назад</span>
        </Button>
      </div>

      {/* Заголовок курса */}
      <div className="flex flex-col lg:flex-row lg:justify-between lg:items-start gap-4">
        <div className="flex-1 min-w-0">
          <div className="flex flex-col gap-2 mb-4">
            <h1 className="text-xl md:text-2xl lg:text-3xl font-bold tracking-tight break-words">
              {course.title}
            </h1>
            <p className="text-muted-foreground text-sm md:text-base leading-relaxed">
              {course.description}
            </p>
          </div>
        </div>
        <Button 
          size="lg" 
          className="w-full lg:w-auto lg:min-w-[200px]" 
          onClick={() => {
            if (isAllLessonsCompleted()) {
              handleGetCertificate()
            } else if (lessonsData && lessonsData.lessons.length > 0) {
              navigate(`/courses/${courseId}/lessons/${lessonsData.lessons[0].lesson_id}`)
            }
          }}
        >
          {isAllLessonsCompleted() ? (
            <>
              <Award className="h-4 w-4 md:h-5 md:w-5 mr-2" />
              <span className="truncate">Получить сертификат</span>
            </>
          ) : (
            <>
              <PlayCircle className="h-4 w-4 md:h-5 md:w-5 mr-2" />
              <span className="truncate">Начать изучение</span>
            </>
          )}
        </Button>
      </div>

      {/* Прогресс курса */}
      {lessonsData && (
        <Card>
          <CardContent className="p-4 md:p-6">
            <div className="flex items-center justify-between mb-2">
              <span className="text-sm font-medium">
                {isAllLessonsCompleted() ? 'Курс завершен!' : 'Прогресс курса'}
              </span>
              <span className="text-sm text-muted-foreground">{courseProgress}%</span>
            </div>
            <div className="w-full bg-gray-200 rounded-full h-2">
              <div 
                className={`h-2 rounded-full transition-all duration-300 ${
                  isAllLessonsCompleted() ? 'bg-green-500' : 'bg-primary'
                }`}
                style={{ width: `${courseProgress}%` }}
              />
            </div>
            <div className="text-xs text-muted-foreground mt-2">
              {isAllLessonsCompleted() ? (
                <span className="text-green-600 font-medium">
                  🎉 Поздравляем! Все {lessonsData.total_lessons} уроков завершены
                </span>
              ) : (
                `${lessonsData.lessons.filter(lesson => isLessonCompleted(lesson.lesson_id)).length} из ${lessonsData.total_lessons} уроков завершено`
              )}
            </div>
          </CardContent>
        </Card>
      )}

      {/* Информация о курсе */}
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
        <Card>
          <CardContent className="flex items-center gap-3 md:gap-4 py-4 px-4 md:px-6">
            <Clock className="h-5 w-5 md:h-6 md:w-6 text-primary flex-shrink-0" />
            <div className="min-w-0">
              <p className="text-xs md:text-sm font-medium text-muted-foreground">
                Длительность
              </p>
              <p className="text-lg md:text-xl font-bold truncate">{course.duration_hours} часов</p>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardContent className="flex items-center gap-3 md:gap-4 py-4 px-4 md:px-6">
            <Award className="h-5 w-5 md:h-6 md:w-6 text-primary flex-shrink-0" />
            <div className="min-w-0">
              <p className="text-xs md:text-sm font-medium text-muted-foreground">
                Категория
              </p>
              <p className="text-sm md:text-lg font-bold truncate">{SKILLS_MAP[course.skill_type as keyof typeof SKILLS_MAP] || course.skill_type}</p>
            </div>
          </CardContent>
        </Card>

        <Card className="sm:col-span-2 lg:col-span-1">
          <CardContent className="flex items-center gap-3 md:gap-4 py-4 px-4 md:px-6">
            <BookOpen className="h-5 w-5 md:h-6 md:w-6 text-primary flex-shrink-0" />
            <div className="min-w-0">
              <p className="text-xs md:text-sm font-medium text-muted-foreground">
                Уроков
              </p>
              <p className="text-lg md:text-xl font-bold">{lessonsData?.total_lessons || 0}</p>
            </div>
          </CardContent>
        </Card>
      </div>

      {/* Содержание курса */}
      <Card>
        <CardHeader className="p-4 md:p-6">
          <CardTitle className="text-lg md:text-xl">Содержание курса</CardTitle>
        </CardHeader>
        <CardContent className="p-4 md:p-6 pt-0">
          {lessonsData && lessonsData.lessons.length > 0 ? (
            <div className="space-y-3 md:space-y-4">
              {lessonsData.lessons.map((lesson, index) => (
                <Card key={lesson.lesson_id} className="hover:shadow-md transition-shadow">
                  <CardContent className="p-4 md:p-6">
                    <div className="flex flex-col lg:flex-row lg:items-start lg:justify-between gap-4">
                      <div className="flex-1 min-w-0">
                        <div className="flex items-start gap-3 mb-3">
                          <div className={`flex items-center justify-center w-8 h-8 rounded-full font-semibold text-sm flex-shrink-0 ${
                            isLessonCompleted(lesson.lesson_id) 
                              ? 'bg-green-100 text-green-800' 
                              : 'bg-primary/10 text-primary'
                          }`}>
                            {isLessonCompleted(lesson.lesson_id) ? (
                              <CheckCircle className="h-4 w-4" />
                            ) : (
                              index + 1
                            )}
                          </div>
                          <div className="flex-1 min-w-0">
                            <div className="flex flex-wrap items-center gap-2 mb-2">
                              {getContentTypeIcon(lesson.material.content_type)}
                              <h3 className="font-semibold text-base md:text-lg leading-tight break-words">
                                {lesson.material.title}
                              </h3>
                            </div>
                            <div className="flex flex-wrap gap-2 mb-2">
                              {lesson.material.content_type.toLowerCase() === 'video' && (
                                <Badge variant="outline" className="text-xs">
                                  <Video className="h-3 w-3 mr-1" />
                                  Видео
                                </Badge>
                              )}
                              {isLessonCompleted(lesson.lesson_id) && (
                                <Badge variant="default" className="bg-green-100 text-green-800 hover:bg-green-100 text-xs">
                                  <CheckCircle className="h-3 w-3 mr-1" />
                                  Пройдено
                                </Badge>
                              )}
                              {lesson.is_required && (
                                <Badge variant="outline" className="text-xs">
                                  Обязательный
                                </Badge>
                              )}
                            </div>
                          </div>
                        </div>
                        
                        <p className="text-muted-foreground mb-3 text-sm md:text-base leading-relaxed">
                          {lesson.material.description}
                        </p>
                        
                        <div className="flex flex-wrap items-center gap-3 md:gap-4 text-xs md:text-sm text-muted-foreground mb-3">
                          <div className="flex items-center gap-1">
                            <Clock className="h-3 w-3 md:h-4 md:w-4" />
                            {lesson.material.duration_minutes} мин
                          </div>
                          {lesson.tasks.length > 0 && (
                            <div className="flex items-center gap-1">
                              <CheckSquare className="h-3 w-3 md:h-4 md:w-4" />
                              {lesson.tasks.length} заданий
                            </div>
                          )}
                        </div>

                        {/* Задания урока */}
                        {lesson.tasks.length > 0 && (
                          <div className="border-t pt-3 mt-3">
                            <h4 className="text-sm font-medium mb-2">Задания:</h4>
                            <div className="space-y-1">
                              {lesson.tasks.map((task) => (
                                <div key={task.id} className="flex items-start gap-2 text-xs md:text-sm text-muted-foreground">
                                  <CheckSquare className="h-3 w-3 mt-0.5 flex-shrink-0" />
                                  <span className="break-words">{task.title}</span>
                                </div>
                              ))}
                            </div>
                          </div>
                        )}
                      </div>
                      
                      <div className="flex-shrink-0 w-full lg:w-auto">
                        <Button 
                          onClick={() => navigate(`/courses/${courseId}/lessons/${lesson.lesson_id}`)}
                          className="w-full lg:w-auto"
                          size="sm"
                        >
                          <PlayCircle className="h-4 w-4 mr-2" />
                          <span className="truncate">
                            {isLessonCompleted(lesson.lesson_id) ? 'Повторить урок' : 'Начать урок'}
                          </span>
                        </Button>
                      </div>
                    </div>
                  </CardContent>
                </Card>
              ))}
            </div>
          ) : (
            <div className="text-center py-8 md:py-12">
              <BookOpen className="h-12 w-12 md:h-16 md:w-16 text-muted-foreground mx-auto mb-4" />
              <h3 className="text-lg md:text-xl font-semibold mb-2">Содержание готовится</h3>
              <p className="text-muted-foreground mb-4 text-sm md:text-base">
                Уроки для этого курса скоро будут добавлены
              </p>
            </div>
          )}
        </CardContent>
      </Card>
    </div>
  )
}