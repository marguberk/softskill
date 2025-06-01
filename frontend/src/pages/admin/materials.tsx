import { useState, useEffect } from "react"
import { Link } from "react-router-dom"
import { Card, CardHeader, CardTitle, CardContent } from "../../components/ui/card"
import { Button } from "../../components/ui/button"
import { Input } from "../../components/ui/input"
import { Badge } from "../../components/ui/badge"
import {
  BookOpen,
  Plus,
  Search,
  Edit,
  Trash2,
  Eye,
  EyeOff,
  Filter,
  Play,
  FileText
} from "lucide-react"

// Типы для материалов
interface LearningMaterial {
  id: number
  title: string
  description: string
  content_type: 'video' | 'article' | 'tutorial'
  skill_type: string
  difficulty_level: 'beginner' | 'intermediate' | 'advanced'
  duration_minutes: number
  author: string
  is_published: boolean
  created_at: string
}

const SKILLS_MAP = {
  communication: 'Коммуникация',
  leadership: 'Лидерство',
  problem_solving: 'Решение проблем',
  time_management: 'Управление временем',
  emotional_intelligence: 'Эмоциональный интеллект',
  teamwork: 'Командная работа'
}

const LEVEL_MAP = {
  beginner: 'Начинающий',
  intermediate: 'Средний',
  advanced: 'Продвинутый'
}

export default function MaterialsPage() {
  const [materials, setMaterials] = useState<LearningMaterial[]>([])
  const [filteredMaterials, setFilteredMaterials] = useState<LearningMaterial[]>([])
  const [searchQuery, setSearchQuery] = useState("")
  const [filterStatus, setFilterStatus] = useState<'all' | 'published' | 'draft'>('all')
  const [loading, setLoading] = useState(true)

  // Загрузка материалов из API
  useEffect(() => {
    loadMaterials()
  }, [])

  const loadMaterials = async () => {
    try {
      setLoading(true)
      const token = localStorage.getItem('token')
      if (!token) {
        throw new Error('Не авторизован')
      }

      const response = await fetch('http://localhost:8000/api/v1/admin/materials', {
        headers: {
          'Authorization': `Bearer ${token}`
        }
      })

      if (!response.ok) {
        throw new Error('Ошибка загрузки материалов')
      }

      const data = await response.json()
      setMaterials(data)
    } catch (error) {
      console.error('Ошибка загрузки материалов:', error)
      // Если ошибка авторизации, перенаправляем на логин
      if (error instanceof Error && error.message.includes('авторизован')) {
        window.location.href = '/login'
      }
    } finally {
      setLoading(false)
    }
  }

  // Фильтрация материалов
  useEffect(() => {
    let filtered = materials

    // Поиск
    if (searchQuery) {
      filtered = filtered.filter(material =>
        material.title.toLowerCase().includes(searchQuery.toLowerCase()) ||
        material.description.toLowerCase().includes(searchQuery.toLowerCase()) ||
        material.author.toLowerCase().includes(searchQuery.toLowerCase())
      )
    }

    // Фильтр по статусу
    if (filterStatus === 'published') {
      filtered = filtered.filter(material => material.is_published)
    } else if (filterStatus === 'draft') {
      filtered = filtered.filter(material => !material.is_published)
    }

    setFilteredMaterials(filtered)
  }, [materials, searchQuery, filterStatus])

  const getTypeIcon = (type: string) => {
    switch (type) {
      case 'video':
        return <Play className="h-4 w-4" />
      case 'article':
        return <FileText className="h-4 w-4" />
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

  const togglePublish = async (id: number) => {
    try {
      const token = localStorage.getItem('token')
      if (!token) return

      const material = materials.find(m => m.id === id)
      if (!material) return

      const response = await fetch(`http://localhost:8000/api/v1/admin/materials/${id}`, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`
        },
        body: JSON.stringify({
          ...material,
          is_published: !material.is_published
        })
      })

      if (response.ok) {
        setMaterials(prev => prev.map(material =>
          material.id === id ? { ...material, is_published: !material.is_published } : material
        ))
      }
    } catch (error) {
      console.error('Ошибка обновления статуса:', error)
    }
  }

  const deleteMaterial = async (id: number) => {
    if (confirm('Вы уверены, что хотите удалить этот материал?')) {
      try {
        const token = localStorage.getItem('token')
        if (!token) return

        const response = await fetch(`http://localhost:8000/api/v1/admin/materials/${id}`, {
          method: 'DELETE',
          headers: {
            'Authorization': `Bearer ${token}`
          }
        })

        if (response.ok) {
          setMaterials(prev => prev.filter(material => material.id !== id))
        }
      } catch (error) {
        console.error('Ошибка удаления материала:', error)
      }
    }
  }

  if (loading) {
    return (
      <div className="space-y-6">
        <div className="flex items-center justify-between">
          <div>
            <h1 className="text-3xl font-bold tracking-tight">Управление материалами</h1>
            <p className="text-muted-foreground">Загрузка материалов...</p>
          </div>
        </div>
        <div className="grid gap-4">
          {[...Array(3)].map((_, i) => (
            <Card key={i}>
              <CardContent className="pt-6">
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
    <div className="space-y-6">
      {/* Заголовок */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold tracking-tight">Управление материалами</h1>
          <p className="text-muted-foreground">
            Создавайте и редактируйте обучающие материалы
          </p>
        </div>
        <Link to="/admin/materials/new">
          <Button>
            <Plus className="h-4 w-4 mr-2" />
            Создать материал
          </Button>
        </Link>
      </div>

      {/* Фильтры и поиск */}
      <Card>
        <CardContent className="pt-6">
          <div className="flex flex-col sm:flex-row gap-4">
            <div className="relative flex-1">
              <Search className="absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-muted-foreground" />
              <Input
                placeholder="Поиск материалов..."
                className="pl-10"
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
              />
            </div>
            <div className="flex gap-2">
              <Button
                variant={filterStatus === 'all' ? 'default' : 'outline'}
                size="sm"
                onClick={() => setFilterStatus('all')}
              >
                Все ({materials.length})
              </Button>
              <Button
                variant={filterStatus === 'published' ? 'default' : 'outline'}
                size="sm"
                onClick={() => setFilterStatus('published')}
              >
                Опубликованные ({materials.filter(m => m.is_published).length})
              </Button>
              <Button
                variant={filterStatus === 'draft' ? 'default' : 'outline'}
                size="sm"
                onClick={() => setFilterStatus('draft')}
              >
                Черновики ({materials.filter(m => !m.is_published).length})
              </Button>
            </div>
          </div>
        </CardContent>
      </Card>

      {/* Список материалов */}
      <div className="space-y-4">
        {filteredMaterials.map((material) => (
          <Card key={material.id}>
            <CardContent className="pt-6">
              <div className="flex items-start justify-between gap-4">
                <div className="flex-1 space-y-3">
                  <div className="flex items-center gap-3">
                    {getTypeIcon(material.content_type)}
                    <h3 className="text-lg font-semibold">{material.title}</h3>
                    <Badge className={`${getLevelColor(material.difficulty_level)} hover:${getLevelColor(material.difficulty_level)}`}>
                      {LEVEL_MAP[material.difficulty_level]}
                    </Badge>
                    <Badge variant="outline" className="hover:bg-transparent">
                      {SKILLS_MAP[material.skill_type as keyof typeof SKILLS_MAP]}
                    </Badge>
                    {material.is_published ? (
                      <Badge className="bg-green-100 text-green-800 hover:bg-green-100">
                        <Eye className="h-3 w-3 mr-1" />
                        Опубликовано
                      </Badge>
                    ) : (
                      <Badge className="bg-orange-100 text-orange-800 hover:bg-orange-100">
                        <EyeOff className="h-3 w-3 mr-1" />
                        Черновик
                      </Badge>
                    )}
                  </div>
                  
                  <p className="text-muted-foreground">{material.description}</p>
                  
                  <div className="flex items-center gap-4 text-sm text-muted-foreground">
                    <span>{getTypeLabel(material.content_type)}</span>
                    <span>{material.duration_minutes} мин</span>
                    <span>Автор: {material.author}</span>
                    <span>Создан: {new Date(material.created_at).toLocaleDateString('ru-RU')}</span>
                  </div>
                </div>

                <div className="flex items-center gap-2">
                  <Button
                    variant="outline"
                    size="sm"
                    onClick={() => togglePublish(material.id)}
                  >
                    {material.is_published ? (
                      <>
                        <EyeOff className="h-4 w-4 mr-1" />
                        Скрыть
                      </>
                    ) : (
                      <>
                        <Eye className="h-4 w-4 mr-1" />
                        Опубликовать
                      </>
                    )}
                  </Button>
                  
                  <Link to={`/admin/materials/${material.id}/edit`}>
                    <Button variant="outline" size="sm">
                      <Edit className="h-4 w-4 mr-1" />
                      Редактировать
                    </Button>
                  </Link>

                  <Button
                    variant="outline"
                    size="sm"
                    onClick={() => deleteMaterial(material.id)}
                    className="text-red-600 hover:text-red-700"
                  >
                    <Trash2 className="h-4 w-4 mr-1" />
                    Удалить
                  </Button>
                </div>
              </div>
            </CardContent>
          </Card>
        ))}
      </div>

      {/* Пустое состояние */}
      {filteredMaterials.length === 0 && (
        <Card>
          <CardContent className="py-12 text-center">
            <BookOpen className="h-12 w-12 text-muted-foreground mx-auto mb-4" />
            <h3 className="text-lg font-medium mb-2">
              {materials.length === 0 ? 'Материалы не найдены' : 'Нет результатов поиска'}
            </h3>
            <p className="text-muted-foreground mb-4">
              {materials.length === 0 
                ? 'Создайте свой первый обучающий материал'
                : 'Попробуйте изменить параметры поиска'
              }
            </p>
            {materials.length === 0 && (
              <Link to="/admin/materials/new">
                <Button>
                  <Plus className="h-4 w-4 mr-2" />
                  Создать материал
                </Button>
              </Link>
            )}
          </CardContent>
        </Card>
      )}
    </div>
  )
} 