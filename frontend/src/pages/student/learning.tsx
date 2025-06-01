import { useState, useEffect } from "react"
import { Link } from "react-router-dom"
import { Card, CardHeader, CardTitle, CardContent } from "../../components/ui/card"
import { Button } from "../../components/ui/button"
import { Input } from "../../components/ui/input"
import { Badge } from "../../components/ui/badge"
import {
  BookOpen,
  Play,
  Clock,
  Search,
  ExternalLink
} from "lucide-react"

// Типы контента для обучения
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

export default function LearningPage() {
  const [materials, setMaterials] = useState<LearningMaterial[]>([])
  const [loading, setLoading] = useState(true)
  const [searchQuery, setSearchQuery] = useState("")

  // Загружаем материалы из API
  useEffect(() => {
    loadMaterials()
  }, [])

  const loadMaterials = async () => {
    try {
      setLoading(true)
      const response = await fetch('http://localhost:8000/api/v1/materials')
      
      if (!response.ok) {
        throw new Error('Ошибка загрузки материалов')
      }

      const data = await response.json()
      setMaterials(data)
    } catch (error) {
      console.error('Ошибка загрузки материалов:', error)
    } finally {
      setLoading(false)
    }
  }

  const getTypeIcon = (type: string) => {
    switch (type) {
      case 'video':
        return <Play className="h-4 w-4" />
      case 'article':
        return <BookOpen className="h-4 w-4" />
      case 'tutorial':
        return <BookOpen className="h-4 w-4" />
      default:
        return <BookOpen className="h-4 w-4" />
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

  const filteredMaterials = materials.filter(material => {
    const matchesSearch = material.title.toLowerCase().includes(searchQuery.toLowerCase()) ||
                         material.description.toLowerCase().includes(searchQuery.toLowerCase())
    return matchesSearch
  })

  if (loading) {
    return (
      <div className="space-y-8">
        <div>
          <h2 className="text-3xl font-bold tracking-tight flex items-center gap-3">
            <BookOpen className="h-8 w-8 text-primary" />
            Обучение
          </h2>
          <p className="text-muted-foreground">
            Загрузка материалов...
          </p>
        </div>
        <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
          {[...Array(6)].map((_, i) => (
            <Card key={i}>
              <CardContent className="p-6">
                <div className="animate-pulse space-y-3">
                  <div className="h-4 bg-gray-200 rounded w-3/4"></div>
                  <div className="h-3 bg-gray-200 rounded w-1/2"></div>
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
      {/* Заголовок */}
      <div>
        <h2 className="text-3xl font-bold tracking-tight flex items-center gap-3">
          <BookOpen className="h-8 w-8 text-primary" />
          Обучение
        </h2>
        <p className="text-muted-foreground">
          Теоретические материалы, видео и уроки для развития гибких навыков
        </p>
      </div>

      {/* Поиск */}
      <div className="relative max-w-md">
        <Search className="absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-muted-foreground" />
        <Input
          placeholder="Поиск материалов..."
          className="pl-10"
          value={searchQuery}
          onChange={(e) => setSearchQuery(e.target.value)}
        />
      </div>

      {/* Сетка материалов */}
      <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
        {filteredMaterials.map((material) => (
          <Link key={material.id} to={`/learning/${material.id}`}>
            <Card className="overflow-hidden hover:shadow-lg transition-shadow cursor-pointer">
              <CardContent className="p-6">
                <div className="space-y-4">
                  <div className="flex items-start justify-between">
                    <div className="flex items-center gap-2">
                      {getTypeIcon(material.content_type)}
                      <Badge variant="outline">
                        {getTypeLabel(material.content_type)}
                      </Badge>
                    </div>
                    <Badge className={getLevelColor(material.difficulty_level)}>
                      {LEVEL_MAP[material.difficulty_level]}
                    </Badge>
                  </div>
                  
                  <div>
                    <h3 className="font-semibold text-lg mb-2 line-clamp-2">
                      {material.title}
                    </h3>
                    <p className="text-sm text-muted-foreground line-clamp-3">
                      {material.description}
                    </p>
                  </div>
                  
                  <div className="space-y-3">
                    <div className="flex items-center justify-between text-sm text-muted-foreground">
                      <div className="flex items-center gap-1">
                        <Clock className="h-4 w-4" />
                        {material.duration_minutes} мин
                      </div>
                    </div>
                    
                    <div className="flex items-center justify-between text-xs text-muted-foreground">
                      <span>Автор: {material.author}</span>
                    </div>
                  </div>
                </div>
              </CardContent>
            </Card>
          </Link>
        ))}
      </div>

      {/* Пустое состояние */}
      {filteredMaterials.length === 0 && !loading && (
        <Card>
          <CardContent className="py-12 text-center">
            <BookOpen className="h-12 w-12 text-muted-foreground mx-auto mb-4" />
            <h3 className="text-lg font-medium mb-2">
              {materials.length === 0 ? 'Материалы не найдены' : 'Нет результатов поиска'}
            </h3>
            <p className="text-muted-foreground">
              {materials.length === 0 
                ? 'Пока нет доступных обучающих материалов'
                : 'Попробуйте изменить параметры поиска'
              }
            </p>
          </CardContent>
        </Card>
      )}
    </div>
  )
} 