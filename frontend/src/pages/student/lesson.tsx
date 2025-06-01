import { useState, useEffect } from "react"
import { useParams, useNavigate } from "react-router-dom"
import { Card, CardContent, CardHeader, CardTitle } from "../../components/ui/card"
import { Button } from "../../components/ui/button"
import {
  ChevronLeft,
  ChevronRight,
  CheckCircle,
  MessageCircle,
  ThumbsUp,
  ThumbsDown,
  BookOpen
} from "lucide-react"
import { Separator } from "../../components/ui/separator"
import ReactPlayer from 'react-player'

// Временные данные для примера
const MOCK_LESSON = {
  id: 1,
  title: "Установка Python и PyCharm",
  content: `<div class="prose max-w-none">
    <h2>Введение</h2>
    <p>В этом уроке мы научимся устанавливать Python и IDE PyCharm на ваш компьютер.</p>
    <h3>Шаги установки Python:</h3>
    <ol>
      <li>Скачайте Python с официального сайта</li>
      <li>Запустите установщик</li>
      <li>Не забудьте отметить "Add Python to PATH"</li>
      <li>Завершите установку</li>
    </ol>
    <h3>Установка PyCharm:</h3>
    <p>PyCharm - это мощная среда разработки для Python...</p>
  </div>`,
  videoUrl: "https://www.youtube.com/watch?v=dQw4w9WgXcQ", // Тестовое видео
  duration: "15 минут",
  completed: false,
  moduleTitle: "Введение в Python",
  courseTitle: "Python для начинающих",
  nextLesson: {
    id: 2,
    title: "Первая программа"
  },
  prevLesson: null,
  attachments: [
    {
      id: 1,
      name: "Python_Installation_Guide.pdf",
      size: "2.4 MB",
      type: "pdf"
    },
    {
      id: 2,
      name: "PyCharm_Setup.pdf",
      size: "1.8 MB",
      type: "pdf"
    }
  ],
  comments: [
    {
      id: 1,
      author: "Иван Петров",
      content: "Отличный урок! Все очень понятно объяснено.",
      createdAt: "2024-01-15T10:30:00",
      likes: 12
    },
    {
      id: 2,
      author: "Мария Сидорова",
      content: "У меня возникла проблема с установкой на Windows 11...",
      createdAt: "2024-01-15T11:15:00",
      likes: 5,
      replies: [
        {
          id: 3,
          author: "Александр Иванов",
          content: "Попробуйте запустить установщик от имени администратора",
          createdAt: "2024-01-15T11:20:00",
          likes: 8
        }
      ]
    }
  ]
}

export default function LessonPage() {
  const { courseId, lessonId } = useParams()
  const navigate = useNavigate()
  const [lesson, setLesson] = useState(MOCK_LESSON)
  const [isVideoPlaying, setIsVideoPlaying] = useState(false)
  const [showComments, setShowComments] = useState(false)
  const [progress, setProgress] = useState(0)

  // TODO: Загрузка данных урока с API
  useEffect(() => {
    // Здесь будет запрос к API
  }, [courseId, lessonId])

  return (
    <div className="space-y-8">
      {/* Навигация */}
      <div className="flex items-center justify-between">
        <div>
          <p className="text-sm text-muted-foreground">
            {lesson.courseTitle} / {lesson.moduleTitle}
          </p>
          <h1 className="text-3xl font-bold tracking-tight mt-1">
            {lesson.title}
          </h1>
        </div>
        <div className="flex items-center gap-4">
          {!lesson.completed && (
            <Button
              variant="outline"
              className="gap-2"
              onClick={() => {/* TODO: Отметить урок как завершенный */}}
            >
              <CheckCircle className="h-4 w-4" />
              Завершить урок
            </Button>
          )}
          <Button
            variant="outline"
            className="gap-2"
            onClick={() => setShowComments(!showComments)}
          >
            <MessageCircle className="h-4 w-4" />
            Обсуждение
          </Button>
        </div>
      </div>

      {/* Основной контент и сайдбар */}
      <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
        {/* Основной контент */}
        <div className="lg:col-span-2 space-y-8">
          {/* Видео плеер */}
            <Card className="aspect-video relative overflow-hidden">
              <ReactPlayer
                url={lesson.videoUrl}
                width="100%"
                height="100%"
                controls
                playing={false}
                onProgress={({ played }) => {
                  setProgress(played * 100)
                  // Если видео просмотрено более чем на 90%, можно отметить урок как просмотренный
                  if (played > 0.9 && !lesson.completed) {
                    // TODO: Отправить запрос на API для отметки урока как просмотренного
                  }
                }}
                config={{
                  youtube: {
                    playerVars: { modestbranding: 1 }
                  },
                  file: {
                    attributes: {
                      controlsList: 'nodownload'  // Запрещаем скачивание видео
                    }
                  }
                }}
              />
              {progress > 0 && progress < 100 && (
                <div className="absolute bottom-0 left-0 right-0 h-1 bg-muted">
                  <div
                    className="h-full bg-primary transition-all"
                    style={{ width: `${progress}%` }}
                  />
                </div>
              )}
            </Card>

          {/* Контент урока */}
          <Card>
            <CardContent className="p-6">
              <div
                className="prose max-w-none dark:prose-invert"
                dangerouslySetInnerHTML={{ __html: lesson.content }}
              />
            </CardContent>
          </Card>
        </div>

        {/* Сайдбар */}
        <div className="space-y-8">
          {/* Материалы */}
          <Card>
            <CardHeader>
              <CardTitle>Материалы урока</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-2">
                {lesson.attachments.map((attachment) => (
                  <div
                    key={attachment.id}
                    className="flex items-center justify-between p-2 rounded-lg hover:bg-muted/50 transition-colors cursor-pointer"
                  >
                    <div className="flex items-center gap-2">
                      <BookOpen className="h-4 w-4 text-muted-foreground" />
                      <span>{attachment.name}</span>
                    </div>
                    <span className="text-sm text-muted-foreground">
                      {attachment.size}
                    </span>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>

          {/* Навигация по урокам */}
          <Card>
            <CardContent className="p-6">
              <div className="space-y-4">
                {lesson.prevLesson && (
                  <Button
                    variant="outline"
                    className="w-full justify-between"
                    onClick={() => navigate(`/courses/${courseId}/lessons/${lesson.prevLesson.id}`)}
                  >
                    <ChevronLeft className="h-4 w-4" />
                    <span>{lesson.prevLesson.title}</span>
                  </Button>
                )}
                {lesson.nextLesson && (
                  <Button
                    className="w-full justify-between"
                    onClick={() => navigate(`/courses/${courseId}/lessons/${lesson.nextLesson.id}`)}
                  >
                    <span>{lesson.nextLesson.title}</span>
                    <ChevronRight className="h-4 w-4" />
                  </Button>
                )}
              </div>
            </CardContent>
          </Card>
        </div>
      </div>

      {/* Комментарии */}
      {showComments && (
        <Card>
          <CardHeader>
            <CardTitle>Обсуждение</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="space-y-6">
              {lesson.comments.map((comment) => (
                <div key={comment.id} className="space-y-4">
                  <div className="flex items-start justify-between">
                    <div>
                      <p className="font-medium">{comment.author}</p>
                      <p className="text-sm text-muted-foreground">
                        {new Date(comment.createdAt).toLocaleDateString()}
                      </p>
                    </div>
                    <div className="flex items-center gap-2">
                      <Button variant="ghost" size="icon">
                        <ThumbsUp className="h-4 w-4" />
                      </Button>
                      <span className="text-sm text-muted-foreground">
                        {comment.likes}
                      </span>
                    </div>
                  </div>
                  <p>{comment.content}</p>

                  {/* Ответы на комментарий */}
                  {comment.replies && comment.replies.length > 0 && (
                    <div className="pl-6 pt-4 space-y-4 border-l">
                      {comment.replies.map((reply) => (
                        <div key={reply.id} className="space-y-2">
                          <div className="flex items-start justify-between">
                            <div>
                              <p className="font-medium">{reply.author}</p>
                              <p className="text-sm text-muted-foreground">
                                {new Date(reply.createdAt).toLocaleDateString()}
                              </p>
                            </div>
                            <div className="flex items-center gap-2">
                              <Button variant="ghost" size="icon">
                                <ThumbsUp className="h-4 w-4" />
                              </Button>
                              <span className="text-sm text-muted-foreground">
                                {reply.likes}
                              </span>
                            </div>
                          </div>
                          <p>{reply.content}</p>
                        </div>
                      ))}
                    </div>
                  )}

                  <Separator />
                </div>
              ))}
            </div>
          </CardContent>
        </Card>
      )}
    </div>
  )
}