import { useState, useEffect } from "react"
import { useParams, useNavigate } from "react-router-dom"
import { Card, CardContent, CardHeader, CardTitle } from "../../components/ui/card"
import { Button } from "../../components/ui/button"
import { Badge } from "../../components/ui/badge"
import { Separator } from "../../components/ui/separator"
import { toast } from "sonner"
import {
  ChevronLeft,
  ChevronRight,
  CheckCircle,
  PlayCircle,
  BookOpen,
  Clock,
  Video,
  CheckSquare,
  ArrowLeft,
  ExternalLink,
  Check
} from "lucide-react"
import ReactMarkdown from 'react-markdown'
import { userStorage } from "../../utils/userStorage"

// Интерфейс для урока
interface LessonData {
  lesson_id: number
  order_position: number
  is_required: boolean
  course_title: string
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
  navigation: {
    prev_lesson: {
      id: number
      title: string
      order_position: number
    } | null
    next_lesson: {
      id: number
      title: string
      order_position: number
    } | null
  }
}

export default function LessonPage() {
  const { courseId, lessonId } = useParams()
  const navigate = useNavigate()
  const [lesson, setLesson] = useState<LessonData | null>(null)
  const [loading, setLoading] = useState(true)
  const [completedTasks, setCompletedTasks] = useState<Set<number>>(new Set())
  const [isLessonCompleted, setIsLessonCompleted] = useState(false)

  useEffect(() => {
    if (courseId && lessonId) {
      // Мигрируем старые данные при первом использовании
      userStorage.migrateOldData()
      
      loadLesson(Number(courseId), Number(lessonId))
      
      // Проверяем, завершен ли урок
      const completedLessons = userStorage.getCompletedLessons()
      const lessonKey = `${courseId}-${lessonId}`
      setIsLessonCompleted(!!completedLessons[lessonKey])
      
      // Загружаем состояние выполненных заданий
      const completedTasksXP = userStorage.getCompletedTasksXP()
      const completedTasksForThisLesson = new Set<number>()
      
      // Находим все задания этого урока, которые уже выполнены
      Object.keys(completedTasksXP).forEach(key => {
        if (key.startsWith(`${courseId}-${lessonId}-`)) {
          const taskId = parseInt(key.split('-')[2])
          completedTasksForThisLesson.add(taskId)
        }
      })
      
      setCompletedTasks(completedTasksForThisLesson)
    }
  }, [courseId, lessonId])

  const loadLesson = async (courseId: number, lessonId: number) => {
    try {
      setLoading(true)
      const response = await fetch(`http://localhost:8002/api/v1/courses/${courseId}/lessons/${lessonId}`)
      
      if (!response.ok) {
        throw new Error('Урок не найден')
      }

      const data = await response.json()
      setLesson(data)
    } catch (error) {
      console.error('Ошибка загрузки урока:', error)
    } finally {
      setLoading(false)
    }
  }

  const toggleTaskCompletion = async (taskId: number) => {
    setCompletedTasks(prev => {
      const newSet = new Set(prev)
      const wasCompleted = newSet.has(taskId)
      
      if (wasCompleted) {
        newSet.delete(taskId)
      } else {
        newSet.add(taskId)
        
        // Если задание только что выполнено, вызываем API для начисления XP
        if (!wasCompleted) {
          handleTaskComplete(taskId)
        }
      }
      return newSet
    })
  }

  const handleTaskComplete = async (taskId: number) => {
    try {
      // Проверяем, не получали ли уже XP за это задание
      const completedTasksXP = userStorage.getCompletedTasksXP()
      const taskKey = `${courseId}-${lessonId}-${taskId}`
      
      if (completedTasksXP[taskKey]) {
        console.log('XP за это задание уже получен')
        return
      }

      const token = localStorage.getItem('token')
      if (token) {
        const response = await fetch(`http://localhost:8002/api/v1/gamification/complete-task/${taskId}?score=100`, {
          method: 'POST',
          headers: {
            'Authorization': `Bearer ${token}`,
            'Content-Type': 'application/json'
          }
        })
        
        if (response.ok) {
          const result = await response.json()
          console.log('Получено XP за задание:', result)
          
          // Сохраняем, что за это задание уже получен XP
          completedTasksXP[taskKey] = true
          userStorage.setCompletedTasksXP(completedTasksXP)
          
          // Показываем уведомление о получении XP
          if (result.xp_gained > 0) {
            toast.success(`🎯 Задание выполнено! +${result.xp_gained} XP`)
            
            // Если был level up, показываем дополнительное уведомление
            if (result.level_up) {
              toast.success(`🎉 Повышение уровня! Теперь вы ${result.new_level} уровня!`)
            }
          }
        }
      }
    } catch (error) {
      console.error('Ошибка при начислении XP за задание:', error)
    }
  }

  const completeLesson = async () => {
    if (!lesson || !courseId || !lessonId) return

    // Проверяем, что все задания выполнены
    if (lesson && lesson.tasks.length > 0) {
      const allTasksCompleted = lesson.tasks.every(task => completedTasks.has(task.id))
      if (!allTasksCompleted) {
        toast.error('Для завершения урока необходимо выполнить все практические задания!')
        return
      }
    }

    // Сохраняем завершение урока
    const completedLessons = userStorage.getCompletedLessons()
    const lessonKey = `${courseId}-${lessonId}`
    completedLessons[lessonKey] = true
    userStorage.setCompletedLessons(completedLessons)
    
    setIsLessonCompleted(true)

    // Вызываем API геймификации для начисления XP за урок
    try {
      const token = localStorage.getItem('token')
      if (token) {
        const response = await fetch(`http://localhost:8002/api/v1/gamification/complete-lesson/${lesson.material.id}?score=95`, {
          method: 'POST',
          headers: {
            'Authorization': `Bearer ${token}`,
            'Content-Type': 'application/json'
          }
        })
        
        if (response.ok) {
          const result = await response.json()
          console.log('Получено XP за урок:', result)
          
          // Показываем уведомление о получении XP
          if (result.xp_result && result.xp_result.xp_gained > 0) {
            toast.success(`🎉 Урок завершен! Получено ${result.xp_result.xp_gained} XP!`)
          }
        }
      }
    } catch (error) {
      console.error('Ошибка при начислении XP:', error)
    }

    // Переходим к следующему уроку или курсу
    if (lesson?.navigation.next_lesson) {
      navigate(`/courses/${courseId}/lessons/${lesson.navigation.next_lesson.id}`)
    } else {
      navigate(`/courses/${courseId}`)
    }
  }

  const areAllTasksCompleted = () => {
    if (!lesson || lesson.tasks.length === 0) return true
    return lesson.tasks.every(task => completedTasks.has(task.id))
  }

  const getYouTubeEmbedUrl = (videoUrl: string) => {
    if (videoUrl.includes('youtube.com/watch?v=')) {
      const videoId = videoUrl.split('v=')[1]?.split('&')[0]
      return `https://www.youtube.com/embed/${videoId}`
    }
    if (videoUrl.includes('youtu.be/')) {
      const videoId = videoUrl.split('youtu.be/')[1]?.split('?')[0]
      return `https://www.youtube.com/embed/${videoId}`
    }
    return videoUrl
  }

  if (loading) {
    return (
      <div className="w-full max-w-none px-4 md:px-6 lg:max-w-4xl lg:mx-auto py-6">
        <div className="animate-pulse space-y-4">
          <div className="h-6 md:h-8 bg-gray-200 rounded w-3/4"></div>
          <div className="h-48 md:h-64 bg-gray-200 rounded"></div>
          <div className="h-24 md:h-32 bg-gray-200 rounded"></div>
        </div>
      </div>
    )
  }

  if (!lesson) {
    return (
      <div className="w-full max-w-none px-4 md:px-6 lg:max-w-4xl lg:mx-auto py-6">
        <Card>
          <CardContent className="py-8 md:py-12 text-center p-4 md:p-6">
            <BookOpen className="h-12 w-12 md:h-16 md:w-16 text-muted-foreground mx-auto mb-4" />
            <h3 className="text-lg md:text-xl font-semibold mb-2">Урок не найден</h3>
            <p className="text-muted-foreground mb-4 text-sm md:text-base">
              Возможно, урок был удален или у вас нет доступа к нему
            </p>
            <Button variant="outline" onClick={() => navigate(`/courses/${courseId}`)} className="w-full sm:w-auto">
              <ArrowLeft className="h-4 w-4 mr-2" />
              Вернуться к курсу
            </Button>
          </CardContent>
        </Card>
      </div>
    )
  }

  return (
    <div className="w-full max-w-none px-4 md:px-6 lg:max-w-4xl lg:mx-auto py-6 space-y-6">
      {/* Навигация */}
      <div className="flex flex-col sm:flex-row sm:items-center gap-3">
        <Button variant="outline" size="sm" onClick={() => navigate(`/courses/${courseId}`)}>
          <ArrowLeft className="h-4 w-4 mr-2" />
          <span className="hidden sm:inline">К курсу</span>
          <span className="sm:hidden">Назад</span>
        </Button>
        <div className="text-xs md:text-sm text-muted-foreground break-words">
          {lesson.course_title} / Урок {lesson.order_position}
        </div>
      </div>

      {/* Заголовок урока */}
      <div className="space-y-4">
        <div className="flex flex-col gap-3">
          <div className="flex items-start gap-3">
            <div className="flex items-center justify-center w-8 h-8 md:w-10 md:h-10 rounded-full bg-primary/10 text-primary font-bold text-sm md:text-base flex-shrink-0">
              {lesson.order_position}
            </div>
            <div className="flex-1 min-w-0">
              <h1 className="text-xl md:text-2xl lg:text-3xl font-bold tracking-tight break-words mb-2">
                {lesson.material.title}
              </h1>
              <div className="flex flex-wrap gap-2 mb-3">
                {lesson.material.content_type.toLowerCase() === 'video' && (
                  <Badge variant="outline" className="text-xs">
                    <Video className="h-3 w-3 mr-1" />
                    Видео
                  </Badge>
                )}
                {isLessonCompleted && (
                  <Badge variant="default" className="bg-green-100 text-green-800 hover:bg-green-100 text-xs">
                    <CheckCircle className="h-3 w-3 mr-1" />
                    Пройдено
                  </Badge>
                )}
                {lesson.is_required && (
                  <Badge variant="outline" className="text-xs">
                    Обязательный урок
                  </Badge>
                )}
              </div>
            </div>
          </div>
        </div>
        
        <p className="text-muted-foreground text-sm md:text-base leading-relaxed">
          {lesson.material.description}
        </p>
        
        <div className="flex flex-wrap items-center gap-3 md:gap-4 text-xs md:text-sm text-muted-foreground">
          <div className="flex items-center gap-1">
            <Clock className="h-3 w-3 md:h-4 md:w-4" />
            {lesson.material.duration_minutes} минут
          </div>
          {lesson.tasks.length > 0 && (
            <div className="flex items-center gap-1">
              <CheckSquare className="h-3 w-3 md:h-4 md:w-4" />
              {lesson.tasks.length} заданий
            </div>
          )}
        </div>
      </div>

      {/* Видео плеер */}
      {lesson.material.content_type.toLowerCase() === 'video' && lesson.material.video_url && (
        <Card>
          <CardContent className="p-0">
            <div className="aspect-video">
              <iframe
                src={getYouTubeEmbedUrl(lesson.material.video_url)}
                className="w-full h-full rounded-lg"
                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                allowFullScreen
                title={lesson.material.title}
              />
            </div>
          </CardContent>
        </Card>
      )}

      {/* Теоретический материал */}
      {lesson.material.theory_content && (
        <Card>
          <CardHeader className="p-4 md:p-6">
            <CardTitle className="flex items-center gap-2 text-lg md:text-xl">
              <BookOpen className="h-4 w-4 md:h-5 md:w-5" />
              Теория
            </CardTitle>
          </CardHeader>
          <CardContent className="p-4 md:p-6 pt-0">
            <div className="prose max-w-none text-sm md:text-base">
              <ReactMarkdown>{lesson.material.theory_content}</ReactMarkdown>
            </div>
          </CardContent>
        </Card>
      )}

      {/* Задания */}
      {lesson.tasks.length > 0 && (
        <Card>
          <CardHeader className="p-4 md:p-6">
            <CardTitle className="flex items-center gap-2 text-lg md:text-xl">
              <CheckSquare className="h-4 w-4 md:h-5 md:w-5" />
              Практические задания
            </CardTitle>
          </CardHeader>
          <CardContent className="p-4 md:p-6 pt-0">
            <div className="space-y-3 md:space-y-4">
              {lesson.tasks.map((task) => (
                <Card key={task.id} className="border-l-4 border-l-primary/20">
                  <CardContent className="p-4">
                    <div className="flex items-start gap-2 md:gap-3">
                      <button
                        onClick={() => toggleTaskCompletion(task.id)}
                        className={`mt-0.5 md:mt-1 w-1 h-1 sm:w-1.5 sm:h-1.5 md:w-2 md:h-2 lg:w-3 lg:h-3 rounded border-2 flex items-center justify-center transition-colors flex-shrink-0 ${
                          completedTasks.has(task.id)
                            ? 'bg-green-500 border-green-500 text-white'
                            : 'border-gray-300 hover:border-gray-400'
                        }`}
                      >
                        {completedTasks.has(task.id) && <Check className="h-3 w-3 sm:h-4 sm:w-4 md:h-5 md:w-5 lg:h-6 lg:w-6" />}
                      </button>
                      <div className="flex-1 min-w-0">
                        <h4 className={`font-semibold mb-2 text-sm md:text-base break-words ${
                          completedTasks.has(task.id) ? 'line-through text-muted-foreground' : ''
                        }`}>
                          {task.title}
                        </h4>
                        <p className="text-muted-foreground leading-relaxed text-xs md:text-sm break-words">
                          {task.description}
                        </p>
                      </div>
                    </div>
                  </CardContent>
                </Card>
              ))}
            </div>
            
            <Separator className="my-4 md:my-6" />
            
            <div className="text-center">
              <p className="text-xs md:text-sm text-muted-foreground">
                {areAllTasksCompleted() 
                  ? "Все задания выполнены! Переходите к следующему уроку." 
                  : "Выполните все задания для перехода к следующему уроку."
                }
              </p>
            </div>
          </CardContent>
        </Card>
      )}

      {/* Навигация между уроками */}
      <Card>
        <CardContent className="p-4 md:p-6">
          <div className="flex flex-col md:flex-row justify-between items-stretch md:items-center gap-4">
            {lesson.navigation.prev_lesson ? (
              <Button
                variant="outline"
                onClick={() => navigate(`/courses/${courseId}/lessons/${lesson.navigation.prev_lesson?.id}`)}
                className="flex items-center gap-2 h-auto p-4 flex-1 md:flex-initial"
              >
                <ChevronLeft className="h-4 w-4 flex-shrink-0" />
                <div className="text-left min-w-0">
                  <div className="text-xs text-muted-foreground">Предыдущий урок</div>
                  <div className="font-medium text-sm md:text-base truncate">
                    {lesson.navigation.prev_lesson.title}
                  </div>
                </div>
              </Button>
            ) : (
              <div className="hidden md:block" />
            )}

            {areAllTasksCompleted() ? (
              <Button
                onClick={completeLesson}
                className="flex items-center gap-2 h-auto p-4 flex-1 md:flex-initial"
              >
                <div className="text-right min-w-0">
                  <div className="text-xs opacity-80">Следующий урок</div>
                  <div className="font-medium text-sm md:text-base truncate">
                    {lesson.navigation.next_lesson ? lesson.navigation.next_lesson.title : 'Завершить курс'}
                  </div>
                </div>
                <ChevronRight className="h-4 w-4 flex-shrink-0" />
              </Button>
            ) : (
              <Button
                disabled
                className="flex items-center gap-2 h-auto p-4 flex-1 md:flex-initial"
              >
                <div className="text-right min-w-0">
                  <div className="text-xs opacity-80">Следующий урок</div>
                  <div className="font-medium text-sm md:text-base">Выполните задания</div>
                </div>
                <ChevronRight className="h-4 w-4 flex-shrink-0" />
              </Button>
            )}
          </div>
        </CardContent>
      </Card>
    </div>
  )
}