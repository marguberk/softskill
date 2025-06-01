import { useState, useEffect } from "react"
import { useParams, useNavigate } from "react-router-dom"
import { Card, CardContent, CardHeader, CardTitle } from "../../components/ui/card"
import { Button } from "../../components/ui/button"
import { Badge } from "../../components/ui/badge"
import { Separator } from "../../components/ui/separator"
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
      loadLesson(parseInt(courseId), parseInt(lessonId))
      // Загружаем состояние завершения урока из localStorage
      const completedLessons = JSON.parse(localStorage.getItem('completedLessons') || '{}')
      const lessonKey = `${courseId}-${lessonId}`
      setIsLessonCompleted(completedLessons[lessonKey] || false)
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

  const toggleTaskCompletion = (taskId: number) => {
    setCompletedTasks(prev => {
      const newSet = new Set(prev)
      if (newSet.has(taskId)) {
        newSet.delete(taskId)
      } else {
        newSet.add(taskId)
      }
      return newSet
    })
  }

  const completeLesson = () => {
    if (!courseId || !lessonId) return

    // Проверяем, что все задания выполнены
    if (lesson && lesson.tasks.length > 0) {
      const allTasksCompleted = lesson.tasks.every(task => completedTasks.has(task.id))
      if (!allTasksCompleted) {
        alert('Для завершения урока необходимо выполнить все практические задания!')
        return
      }
    }

    // Сохраняем завершение урока в localStorage
    const completedLessons = JSON.parse(localStorage.getItem('completedLessons') || '{}')
    const lessonKey = `${courseId}-${lessonId}`
    completedLessons[lessonKey] = true
    localStorage.setItem('completedLessons', JSON.stringify(completedLessons))
    
    setIsLessonCompleted(true)

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
      <div className="max-w-4xl mx-auto p-6">
        <div className="animate-pulse space-y-4">
          <div className="h-8 bg-gray-200 rounded w-3/4"></div>
          <div className="h-64 bg-gray-200 rounded"></div>
          <div className="h-32 bg-gray-200 rounded"></div>
        </div>
      </div>
    )
  }

  if (!lesson) {
    return (
      <div className="max-w-4xl mx-auto p-6">
        <Card>
          <CardContent className="py-12 text-center">
            <BookOpen className="h-12 w-12 text-muted-foreground mx-auto mb-4" />
            <h3 className="text-lg font-medium mb-2">Урок не найден</h3>
            <p className="text-muted-foreground mb-4">
              Возможно, урок был удален или у вас нет доступа к нему
            </p>
            <Button variant="outline" onClick={() => navigate(`/courses/${courseId}`)}>
              <ArrowLeft className="h-4 w-4 mr-2" />
              Вернуться к курсу
            </Button>
          </CardContent>
        </Card>
      </div>
    )
  }

  return (
    <div className="max-w-4xl mx-auto p-6 space-y-6">
      {/* Навигация */}
      <div className="flex items-center gap-3">
        <Button variant="outline" size="sm" onClick={() => navigate(`/courses/${courseId}`)}>
          <ArrowLeft className="h-4 w-4 mr-2" />
          К курсу
        </Button>
        <div className="text-sm text-muted-foreground">
          {lesson.course_title} / Урок {lesson.order_position}
        </div>
      </div>

      {/* Заголовок урока */}
      <div>
        <div className="flex items-center gap-3 mb-2">
          <div className="flex items-center justify-center w-10 h-10 rounded-full bg-primary/10 text-primary font-bold">
            {lesson.order_position}
          </div>
          <h1 className="text-3xl font-bold tracking-tight">{lesson.material.title}</h1>
          {lesson.material.content_type === 'video' && (
            <Badge variant="outline">
              <Video className="h-3 w-3 mr-1" />
              Видео
            </Badge>
          )}
          {isLessonCompleted && (
            <Badge variant="default" className="bg-green-100 text-green-800 hover:bg-green-100">
              <CheckCircle className="h-3 w-3 mr-1" />
              Пройдено
            </Badge>
          )}
        </div>
        <p className="text-muted-foreground mb-4">{lesson.material.description}</p>
        <div className="flex items-center gap-4 text-sm text-muted-foreground">
          <div className="flex items-center gap-1">
            <Clock className="h-4 w-4" />
            {lesson.material.duration_minutes} минут
          </div>
          {lesson.tasks.length > 0 && (
            <div className="flex items-center gap-1">
              <CheckSquare className="h-4 w-4" />
              {lesson.tasks.length} заданий
            </div>
          )}
          {lesson.is_required && (
            <Badge variant="outline" className="text-xs">
              Обязательный урок
            </Badge>
          )}
        </div>
      </div>

      {/* Видео */}
      {lesson.material.content_type === 'video' && lesson.material.video_url && (
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
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <BookOpen className="h-5 w-5" />
              Теория
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="prose max-w-none">
              <ReactMarkdown>{lesson.material.theory_content}</ReactMarkdown>
            </div>
          </CardContent>
        </Card>
      )}

      {/* Задания */}
      {lesson.tasks.length > 0 && (
        <Card>
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <CheckSquare className="h-5 w-5" />
              Практические задания
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              {lesson.tasks.map((task) => (
                <Card key={task.id} className="border-l-4 border-l-primary/20">
                  <CardContent className="p-4">
                    <div className="flex items-start gap-3">
                      <button
                        onClick={() => toggleTaskCompletion(task.id)}
                        className={`mt-1 w-5 h-5 rounded border-2 flex items-center justify-center transition-colors ${
                          completedTasks.has(task.id)
                            ? 'bg-green-500 border-green-500 text-white'
                            : 'border-gray-300 hover:border-gray-400'
                        }`}
                      >
                        {completedTasks.has(task.id) && <Check className="h-3 w-3" />}
                      </button>
                      <div className="flex-1">
                        <h4 className={`font-semibold mb-2 ${
                          completedTasks.has(task.id) ? 'line-through text-muted-foreground' : ''
                        }`}>
                          {task.title}
                        </h4>
                        <p className="text-muted-foreground leading-relaxed">
                          {task.description}
                        </p>
                      </div>
                    </div>
                  </CardContent>
                </Card>
              ))}
            </div>
            
            <Separator className="my-6" />
            
            <div className="text-center">
              <p className="text-sm text-muted-foreground">
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
        <CardContent className="p-6">
          <div className="flex justify-between items-center">
            {lesson.navigation.prev_lesson ? (
              <Button
                variant="outline"
                size="lg"
                onClick={() => navigate(`/courses/${courseId}/lessons/${lesson.navigation.prev_lesson?.id}`)}
                className="flex items-center gap-2 h-16 px-6"
              >
                <ChevronLeft className="h-4 w-4" />
                <div className="text-left">
                  <div className="text-xs text-muted-foreground">Предыдущий урок</div>
                  <div className="font-medium">{lesson.navigation.prev_lesson.title}</div>
                </div>
              </Button>
            ) : (
              <div />
            )}

            {areAllTasksCompleted() ? (
              <Button
                size="lg"
                onClick={completeLesson}
                className="flex items-center gap-2 h-16 px-6"
              >
                <div className="text-right">
                  <div className="text-xs opacity-80">Следующий урок</div>
                  <div className="font-medium">
                    {lesson.navigation.next_lesson ? lesson.navigation.next_lesson.title : 'Завершить курс'}
                  </div>
                </div>
                <ChevronRight className="h-4 w-4" />
              </Button>
            ) : (
              <Button
                size="lg"
                disabled
                className="flex items-center gap-2 h-16 px-6"
              >
                <div className="text-right">
                  <div className="text-xs opacity-80">Следующий урок</div>
                  <div className="font-medium">Выполните задания</div>
                </div>
                <ChevronRight className="h-4 w-4" />
              </Button>
            )}
          </div>
        </CardContent>
      </Card>
    </div>
  )
}