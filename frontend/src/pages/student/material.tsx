import { useState, useEffect } from "react"
import { useParams, Link } from "react-router-dom"
import { marked } from "marked"
import { Card, CardContent } from "../../components/ui/card"
import { Button } from "../../components/ui/button"
import { Badge } from "../../components/ui/badge"
import { toast } from "sonner"
import {
  ArrowLeft,
  BookOpen,
  Play,
  Clock,
  User,
  Calendar
} from "lucide-react"

interface LearningMaterial {
  id: number
  title: string
  description: string
  content_type: 'video' | 'article' | 'tutorial'
  skill_type: string
  difficulty_level: 'beginner' | 'intermediate' | 'advanced'
  duration_minutes: number
  author: string
  theory_content?: string
  video_url?: string
  video_id?: string
  source_url?: string
  is_published: boolean
  created_at: string
}

const LEVEL_MAP = {
  beginner: 'Начинающий',
  intermediate: 'Средний',
  advanced: 'Продвинутый'
}

export default function MaterialPage() {
  const { id } = useParams<{ id: string }>()
  const [material, setMaterial] = useState<LearningMaterial | null>(null)
  const [loading, setLoading] = useState(true)
  const [completing, setCompleting] = useState(false)
  const [completed, setCompleted] = useState(false)

  useEffect(() => {
    if (id) {
      loadMaterial(parseInt(id))
    }
  }, [id])

  const loadMaterial = async (materialId: number) => {
    try {
      setLoading(true)
      const response = await fetch(`http://localhost:8000/api/v1/materials/${materialId}`)
      
      if (!response.ok) {
        throw new Error('Материал не найден')
      }

      const data = await response.json()
      setMaterial(data)
    } catch (error) {
      console.error('Ошибка загрузки материала:', error)
    } finally {
      setLoading(false)
    }
  }

  const getTypeIcon = (type: string) => {
    switch (type) {
      case 'video':
        return <Play className="h-5 w-5" />
      case 'article':
        return <BookOpen className="h-5 w-5" />
      case 'tutorial':
        return <BookOpen className="h-5 w-5" />
      default:
        return <BookOpen className="h-5 w-5" />
    }
  }

  const getTypeLabel = (type: string) => {
    switch (type) {
      case 'video':
        return 'Видео'
      case 'article':
        return 'Статья'
      case 'tutorial':
        return 'Урок'
      default:
        return 'Материал'
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

  // Функция для конвертации YouTube ссылки в embed формат
  const getEmbedUrl = (url: string) => {
    if (!url) return ''
    
    // Если уже embed ссылка, возвращаем как есть
    if (url.includes('youtube.com/embed/')) {
      return url
    }
    
    // Конвертируем обычную YouTube ссылку в embed
    const videoIdMatch = url.match(/(?:youtube\.com\/watch\?v=|youtu\.be\/|youtube\.com\/embed\/)([^&\n?#]+)/)
    if (videoIdMatch && videoIdMatch[1]) {
      return `https://www.youtube.com/embed/${videoIdMatch[1]}?rel=0&modestbranding=1`
    }
    
    // Если не YouTube ссылка, возвращаем как есть
    return url
  }

  const handleIframeError = () => {
    console.warn('Ошибка загрузки видео')
  }

  const handleComplete = async () => {
    if (!material || completed) return
    
    setCompleting(true)
    try {
      const token = localStorage.getItem('token')
      if (!token) {
        toast.error('Необходимо войти в систему')
        return
      }

      const response = await fetch(`http://localhost:8000/api/v1/materials/${material.id}/complete`, {
        method: 'POST',
        headers: {
          'Authorization': `Bearer ${token}`,
          'Content-Type': 'application/json'
        }
      })

      if (!response.ok) {
        const error = await response.json()
        throw new Error(error.detail || 'Ошибка при отметке материала')
      }

      const result = await response.json()
      setCompleted(true)
      
      // Показываем уведомление с результатами
      if (result.level_up) {
        toast.success(`🎉 Поздравляем! Вы повысились до ${result.level} уровня!`, {
          description: `Получено: +${result.points_earned} баллов, +${result.exp_earned} опыта`,
          duration: 5000
        })
      } else {
        toast.success(`✅ Материал изучен!`, {
          description: `Получено: +${result.points_earned} баллов, +${result.exp_earned} опыта`,
          duration: 3000
        })
      }
    } catch (error: any) {
      console.error('Ошибка при завершении материала:', error)
      toast.error(error.message || 'Не удалось отметить материал как изученный')
    } finally {
      setCompleting(false)
    }
  }

  if (loading) {
    return (
      <div className="space-y-6">
        <div className="flex items-center gap-3">
          <Link to="/learning">
            <Button variant="outline" size="sm">
              <ArrowLeft className="h-4 w-4 mr-2" />
              Назад
            </Button>
          </Link>
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

  if (!material) {
    return (
      <div className="space-y-6">
        <div className="flex items-center gap-3">
          <Link to="/learning">
            <Button variant="outline" size="sm">
              <ArrowLeft className="h-4 w-4 mr-2" />
              Назад
            </Button>
          </Link>
        </div>
        
        <Card>
          <CardContent className="py-12 text-center">
            <BookOpen className="h-12 w-12 text-muted-foreground mx-auto mb-4" />
            <h3 className="text-lg font-medium mb-2">Материал не найден</h3>
            <p className="text-muted-foreground">
              Возможно, материал был удален или у вас нет доступа к нему
            </p>
          </CardContent>
        </Card>
      </div>
    )
  }

  return (
    <div className="space-y-6">
      {/* Навигация */}
      <div className="flex items-center gap-3">
        <Link to="/learning">
          <Button variant="outline" size="sm">
            <ArrowLeft className="h-4 w-4 mr-2" />
            Назад к материалам
          </Button>
        </Link>
      </div>

      {/* Заголовок материала */}
      <Card>
        <CardContent className="p-8">
          <div className="space-y-6">
            {/* Метаданные */}
            <div className="flex items-center gap-3 flex-wrap">
              <div className="flex items-center gap-2">
                {getTypeIcon(material.content_type)}
                <Badge variant="outline">
                  {getTypeLabel(material.content_type)}
                </Badge>
              </div>
              <Badge className={`${getLevelColor(material.difficulty_level)} hover:${getLevelColor(material.difficulty_level)}`}>
                {LEVEL_MAP[material.difficulty_level]}
              </Badge>
              <div className="flex items-center gap-1 text-sm text-muted-foreground">
                <Clock className="h-4 w-4" />
                {material.duration_minutes} мин
              </div>
            </div>

            {/* Заголовок */}
            <div>
              <h1 className="text-3xl font-bold mb-4">{material.title}</h1>
              <p className="text-lg text-muted-foreground leading-relaxed">
                {material.description}
              </p>
            </div>

            {/* Информация об авторе */}
            <div className="flex items-center gap-4 text-sm text-muted-foreground border-t pt-4">
              <div className="flex items-center gap-1">
                <User className="h-4 w-4" />
                Автор: {material.author}
              </div>
              <div className="flex items-center gap-1">
                <Calendar className="h-4 w-4" />
                Создано: {new Date(material.created_at).toLocaleDateString('ru-RU')}
              </div>
            </div>
          </div>
        </CardContent>
      </Card>

      {/* Контент материала */}
      <Card>
        <CardContent className="p-8">
          <div className="space-y-6">
            <h2 className="text-xl font-semibold">Содержание материала</h2>
            
            {/* Отображение теоретического контента */}
            {material.theory_content && (
              <div className="prose max-w-none">
                <div 
                  dangerouslySetInnerHTML={{ 
                    __html: marked(material.theory_content) 
                  }} 
                />
              </div>
            )}
            
            {/* Видео контент */}
            {material.content_type === 'video' && material.video_url && (
              <div className="space-y-4">
                <iframe
                  width="100%"
                  height="400"
                  src={getEmbedUrl(material.video_url)}
                  title={material.title}
                  frameBorder="0"
                  allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                  allowFullScreen
                  className="rounded-lg"
                  onError={handleIframeError}
                />
              </div>
            )}
            
            {/* Ссылка на источник */}
            {material.source_url && (
              <div className="pt-4 border-t">
                <a 
                  href={material.source_url}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="text-blue-600 hover:text-blue-800 underline"
                >
                  Перейти к источнику материала
                </a>
              </div>
            )}
            
            {/* Заглушки если нет контента */}
            {!material.theory_content && !material.video_url && !material.source_url && (
              <div className="bg-gray-100 rounded-lg p-8 text-center">
                {material.content_type === 'video' && (
                  <>
                    <Play className="h-16 w-16 text-muted-foreground mx-auto mb-4" />
                    <p className="text-muted-foreground">
                      Видео-контент временно недоступен
                    </p>
                  </>
                )}
                {material.content_type === 'article' && (
                  <>
                    <BookOpen className="h-16 w-16 text-muted-foreground mx-auto mb-4" />
                    <p className="text-muted-foreground">
                      Содержание статьи временно недоступно
                    </p>
                  </>
                )}
                {material.content_type === 'tutorial' && (
                  <>
                    <BookOpen className="h-16 w-16 text-muted-foreground mx-auto mb-4" />
                    <p className="text-muted-foreground">
                      Содержание урока временно недоступно
                    </p>
                  </>
                )}
              </div>
            )}
          </div>
        </CardContent>
      </Card>

      {/* Действия */}
      <Card>
        <CardContent className="p-6">
          <div className="flex items-center justify-between">
            <div>
              <h3 className="font-semibold mb-1">Завершили изучение?</h3>
              <p className="text-sm text-muted-foreground">
                Отметьте материал как изученный и получите баллы
              </p>
            </div>
            <Button 
              onClick={handleComplete}
              disabled={completing || completed}
              className={completed ? "bg-green-600 hover:bg-green-600" : ""}
            >
              {completing ? (
                <>
                  <div className="animate-spin rounded-full h-4 w-4 border-b-2 border-white mr-2"></div>
                  Сохранение...
                </>
              ) : completed ? (
                "✅ Изучено"
              ) : (
                "Отметить как изученное"
              )}
            </Button>
          </div>
        </CardContent>
      </Card>
    </div>
  )
} 