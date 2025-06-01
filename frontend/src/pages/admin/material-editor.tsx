import { useState, useEffect } from "react"
import { useParams, useNavigate, Link } from "react-router-dom"
import { Card, CardHeader, CardTitle, CardContent } from "../../components/ui/card"
import { Button } from "../../components/ui/button"
import { Input } from "../../components/ui/input"
import { Badge } from "../../components/ui/badge"
import { Label } from "../../components/ui/label"
import MDEditor from '@uiw/react-md-editor'
import {
  ArrowLeft,
  Save,
  Eye,
  Plus,
  Trash2,
  Play,
  FileText,
  BookOpen
} from "lucide-react"

// Типы данных
interface Task {
  id: string
  title: string
  description: string
  order: number
}

interface MaterialFormData {
  title: string
  description: string
  content_type: 'video' | 'article' | 'tutorial'
  skill_type: string
  difficulty_level: 'beginner' | 'intermediate' | 'advanced'
  duration_minutes: number
  author: string
  theory_content: string
  video_url: string
  video_id: string
  source_url: string
  is_published: boolean
  tasks: Task[]
}

const INITIAL_FORM_DATA: MaterialFormData = {
  title: '',
  description: '',
  content_type: 'article',
  skill_type: 'communication',
  difficulty_level: 'beginner',
  duration_minutes: 10,
  author: '',
  theory_content: `## Введение\n\nОпишите основные концепции и цели обучения.\n\n### Ключевые понятия\n\n- **Понятие 1** — краткое описание\n- **Понятие 2** — краткое описание\n\n### Практические навыки\n\n1. Навык 1\n2. Навык 2\n3. Навык 3\n\n## Заключение\n\nПодведите итоги и дайте рекомендации для дальнейшего изучения.`,
  video_url: '',
  video_id: '',
  source_url: '',
  is_published: false,
  tasks: []
}

const SKILLS_OPTIONS = [
  { value: 'communication', label: 'Коммуникация' },
  { value: 'leadership', label: 'Лидерство' },
  { value: 'problem_solving', label: 'Решение проблем' },
  { value: 'time_management', label: 'Управление временем' },
  { value: 'emotional_intelligence', label: 'Эмоциональный интеллект' },
  { value: 'teamwork', label: 'Командная работа' }
]

const DIFFICULTY_OPTIONS = [
  { value: 'beginner', label: 'Начинающий', color: 'bg-green-100 text-green-800' },
  { value: 'intermediate', label: 'Средний', color: 'bg-yellow-100 text-yellow-800' },
  { value: 'advanced', label: 'Продвинутый', color: 'bg-red-100 text-red-800' }
]

const CONTENT_TYPE_OPTIONS = [
  { value: 'video', label: 'Видео', icon: Play },
  { value: 'article', label: 'Статья', icon: FileText },
  { value: 'tutorial', label: 'Урок', icon: BookOpen }
]

export default function MaterialEditor() {
  const { materialId } = useParams()
  const navigate = useNavigate()
  const [formData, setFormData] = useState<MaterialFormData>(INITIAL_FORM_DATA)
  const [loading, setLoading] = useState(false)
  const [saving, setSaving] = useState(false)
  const [activeTab, setActiveTab] = useState<'edit' | 'preview'>('edit')

  const isEditing = materialId && materialId !== 'new'

  // Загрузка материала для редактирования
  useEffect(() => {
    if (isEditing && materialId) {
      loadMaterial()
    }
  }, [isEditing, materialId])

  const loadMaterial = async () => {
    setLoading(true)
    try {
      const token = localStorage.getItem('token')
      if (!token) {
        throw new Error('Не авторизован')
      }

      const response = await fetch(`http://localhost:8000/api/v1/admin/materials/${materialId}`, {
        headers: {
          'Authorization': `Bearer ${token}`
        }
      })

      if (!response.ok) {
        throw new Error('Ошибка загрузки материала')
      }

      const material = await response.json()
      console.log('Загруженный материал:', material)

      setFormData({
        title: material.title || '',
        description: material.description || '',
        content_type: material.content_type || 'article',
        skill_type: material.skill_type || '',
        difficulty_level: material.difficulty_level || 'beginner',
        duration_minutes: material.duration_minutes || 0,
        author: material.author || '',
        theory_content: material.theory_content || '',
        video_url: material.video_url || '',
        video_id: material.video_id || '',
        source_url: material.source_url || '',
        is_published: material.is_published || false,
        tasks: material.tasks || []
      })
    } catch (error: any) {
      console.error('Ошибка загрузки материала:', error)
      const toast = await import('sonner')
      toast.toast.error('Не удалось загрузить материал')
      navigate('/admin/materials')
    } finally {
      setLoading(false)
    }
  }

  const handleSave = async () => {
    setSaving(true)
    try {
      const token = localStorage.getItem('token')
      if (!token) {
        throw new Error('Не авторизован')
      }

      // Подготавливаем данные для отправки
      const payload = {
        title: formData.title,
        description: formData.description,
        content_type: formData.content_type,
        skill_type: formData.skill_type,
        difficulty_level: formData.difficulty_level,
        duration_minutes: formData.duration_minutes,
        author: formData.author,
        theory_content: formData.theory_content,
        video_url: formData.video_url,
        video_id: formData.video_id,
        source_url: formData.source_url,
        is_published: formData.is_published,
        tasks: formData.tasks.map(task => ({
          title: task.title,
          description: task.description,
          order: task.order
        }))
      }

      console.log('Отправляемые данные:', payload)

      let response
      if (isEditing && materialId) {
        // Обновление существующего материала
        response = await fetch(`http://localhost:8000/api/v1/admin/materials/${materialId}`, {
          method: 'PUT',
          headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${token}`
          },
          body: JSON.stringify(payload)
        })
      } else {
        // Создание нового материала
        response = await fetch('http://localhost:8000/api/v1/admin/materials', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${token}`
          },
          body: JSON.stringify(payload)
        })
      }

      if (!response.ok) {
        const errorData = await response.json()
        throw new Error(errorData.detail || 'Ошибка сохранения')
      }

      const result = await response.json()
      console.log('Материал сохранен:', result)
      
      // Показываем уведомление об успехе
      const toast = await import('sonner')
      toast.toast.success(isEditing ? 'Материал обновлен!' : 'Материал создан!')
      
      navigate('/admin/materials')
    } catch (error: any) {
      console.error('Ошибка сохранения:', error)
      const toast = await import('sonner')
      toast.toast.error(error.message || 'Ошибка сохранения материала')
    } finally {
      setSaving(false)
    }
  }

  const addTask = () => {
    const newTask: Task = {
      id: Date.now().toString(),
      title: '',
      description: '',
      order: formData.tasks.length
    }
    setFormData(prev => ({
      ...prev,
      tasks: [...prev.tasks, newTask]
    }))
  }

  const updateTask = (id: string, field: keyof Task, value: string | number) => {
    setFormData(prev => ({
      ...prev,
      tasks: prev.tasks.map(task =>
        task.id === id ? { ...task, [field]: value } : task
      )
    }))
  }

  const removeTask = (id: string) => {
    setFormData(prev => ({
      ...prev,
      tasks: prev.tasks.filter(task => task.id !== id)
    }))
  }

  const extractYouTubeId = (url: string) => {
    const match = url.match(/(?:youtube\.com\/watch\?v=|youtu\.be\/|youtube\.com\/embed\/)([^&\n?#]+)/)
    return match ? match[1] : ''
  }

  const handleVideoUrlChange = (url: string) => {
    setFormData(prev => ({
      ...prev,
      video_url: url,
      video_id: extractYouTubeId(url)
    }))
  }

  if (loading) {
    return (
      <div className="p-6">
        <div className="animate-pulse space-y-4">
          <div className="h-8 bg-gray-200 rounded w-1/4"></div>
          <div className="h-10 bg-gray-200 rounded"></div>
          <div className="space-y-3">
            <div className="h-32 bg-gray-200 rounded"></div>
            <div className="h-64 bg-gray-200 rounded"></div>
            <div className="h-32 bg-gray-200 rounded"></div>
          </div>
        </div>
      </div>
    )
  }

  return (
    <div className="space-y-6">
      {/* Заголовок */}
      <div className="flex items-center justify-between">
        <div className="flex items-center gap-4">
          <Link to="/admin/materials">
            <Button variant="outline" size="sm">
              <ArrowLeft className="h-4 w-4 mr-2" />
              Назад
            </Button>
          </Link>
          <div>
            <h1 className="text-3xl font-bold tracking-tight">
              {isEditing ? 'Редактировать материал' : 'Создать материал'}
            </h1>
            <p className="text-muted-foreground">
              {isEditing ? 'Изменяйте содержимое материала' : 'Создайте новый обучающий материал'}
            </p>
          </div>
        </div>
        <div className="flex items-center gap-2">
          <Button variant="outline" onClick={() => setFormData(prev => ({ ...prev, is_published: !prev.is_published }))}>
            <Eye className="h-4 w-4 mr-2" />
            {formData.is_published ? 'Скрыть' : 'Опубликовать'}
          </Button>
          <Button onClick={handleSave} disabled={saving}>
            <Save className="h-4 w-4 mr-2" />
            {saving ? 'Сохранение...' : 'Сохранить'}
          </Button>
        </div>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        {/* Основная форма */}
        <div className="lg:col-span-2 space-y-6">
          {/* Основная информация */}
          <Card>
            <CardHeader>
              <CardTitle>Основная информация</CardTitle>
            </CardHeader>
            <CardContent className="space-y-4">
              <div>
                <Label htmlFor="title">Название материала</Label>
                <Input
                  id="title"
                  value={formData.title}
                  onChange={(e) => setFormData(prev => ({ ...prev, title: e.target.value }))}
                  placeholder="Введите название материала"
                />
              </div>

              <div>
                <Label htmlFor="description">Описание</Label>
                <textarea
                  id="description"
                  className="w-full min-h-[100px] p-3 border rounded-md resize-none"
                  value={formData.description}
                  onChange={(e) => setFormData(prev => ({ ...prev, description: e.target.value }))}
                  placeholder="Краткое описание материала"
                />
              </div>

              <div>
                <Label htmlFor="author">Автор</Label>
                <Input
                  id="author"
                  value={formData.author}
                  onChange={(e) => setFormData(prev => ({ ...prev, author: e.target.value }))}
                  placeholder="Имя автора"
                />
              </div>

              <div className="grid grid-cols-2 gap-4">
                <div>
                  <Label htmlFor="duration">Длительность (мин)</Label>
                  <Input
                    id="duration"
                    type="number"
                    min="1"
                    value={formData.duration_minutes}
                    onChange={(e) => setFormData(prev => ({ ...prev, duration_minutes: parseInt(e.target.value) || 0 }))}
                  />
                </div>
                <div>
                  <Label htmlFor="source_url">Ссылка на источник</Label>
                  <Input
                    id="source_url"
                    value={formData.source_url}
                    onChange={(e) => setFormData(prev => ({ ...prev, source_url: e.target.value }))}
                    placeholder="https://example.com"
                  />
                </div>
              </div>
            </CardContent>
          </Card>

          {/* Видео */}
          {formData.content_type === 'video' && (
            <Card>
              <CardHeader>
                <CardTitle>Видео</CardTitle>
              </CardHeader>
              <CardContent className="space-y-4">
                <div>
                  <Label htmlFor="video_url">YouTube ссылка</Label>
                  <Input
                    id="video_url"
                    value={formData.video_url}
                    onChange={(e) => handleVideoUrlChange(e.target.value)}
                    placeholder="https://youtube.com/watch?v=..."
                  />
                </div>
                {formData.video_id && (
                  <div className="aspect-video">
                    <iframe
                      width="100%"
                      height="100%"
                      src={`https://www.youtube.com/embed/${formData.video_id}`}
                      title="Preview"
                      frameBorder="0"
                      allowFullScreen
                      className="rounded-lg"
                    />
                  </div>
                )}
              </CardContent>
            </Card>
          )}

          {/* Теоретическая часть */}
          <Card>
            <CardHeader>
              <CardTitle className="flex items-center justify-between">
                Теоретическая часть
                <div className="flex gap-2">
                  <Button
                    variant={activeTab === 'edit' ? 'default' : 'outline'}
                    size="sm"
                    onClick={() => setActiveTab('edit')}
                  >
                    Редактор
                  </Button>
                  <Button
                    variant={activeTab === 'preview' ? 'default' : 'outline'}
                    size="sm"
                    onClick={() => setActiveTab('preview')}
                  >
                    Предпросмотр
                  </Button>
                </div>
              </CardTitle>
            </CardHeader>
            <CardContent>
              <MDEditor
                value={formData.theory_content}
                onChange={(value) => setFormData(prev => ({ ...prev, theory_content: value || '' }))}
                preview={activeTab === 'preview' ? 'preview' : 'edit'}
                height={400}
                data-color-mode="light"
              />
            </CardContent>
          </Card>

          {/* Практические задания */}
          <Card>
            <CardHeader>
              <CardTitle className="flex items-center justify-between">
                Практические задания
                <Button size="sm" onClick={addTask}>
                  <Plus className="h-4 w-4 mr-2" />
                  Добавить задание
                </Button>
              </CardTitle>
            </CardHeader>
            <CardContent className="space-y-4">
              {formData.tasks.map((task, index) => (
                <div key={task.id} className="border rounded-lg p-4 space-y-3">
                  <div className="flex items-center justify-between">
                    <span className="text-sm font-medium">Задание {index + 1}</span>
                    <Button
                      variant="outline"
                      size="sm"
                      onClick={() => removeTask(task.id)}
                      className="text-red-600 hover:text-red-700"
                    >
                      <Trash2 className="h-4 w-4" />
                    </Button>
                  </div>
                  <div>
                    <Label>Название задания</Label>
                    <Input
                      value={task.title}
                      onChange={(e) => updateTask(task.id, 'title', e.target.value)}
                      placeholder="Введите название задания"
                    />
                  </div>
                  <div>
                    <Label>Описание</Label>
                    <textarea
                      className="w-full min-h-[80px] p-3 border rounded-md resize-none"
                      value={task.description}
                      onChange={(e) => updateTask(task.id, 'description', e.target.value)}
                      placeholder="Опишите что нужно сделать"
                    />
                  </div>
                </div>
              ))}
              {formData.tasks.length === 0 && (
                <div className="text-center py-8 text-muted-foreground">
                  <p>Нет заданий. Добавьте первое задание.</p>
                </div>
              )}
            </CardContent>
          </Card>
        </div>

        {/* Боковая панель настроек */}
        <div className="space-y-6">
          {/* Настройки */}
          <Card>
            <CardHeader>
              <CardTitle>Настройки</CardTitle>
            </CardHeader>
            <CardContent className="space-y-4">
              <div>
                <Label>Тип материала</Label>
                <div className="grid grid-cols-1 gap-2 mt-2">
                  {CONTENT_TYPE_OPTIONS.map((option) => (
                    <Button
                      key={option.value}
                      variant={formData.content_type === option.value ? 'default' : 'outline'}
                      size="sm"
                      onClick={() => setFormData(prev => ({ ...prev, content_type: option.value as any }))}
                      className="justify-start"
                    >
                      <option.icon className="h-4 w-4 mr-2" />
                      {option.label}
                    </Button>
                  ))}
                </div>
              </div>

              <div>
                <Label htmlFor="skill_type">Навык</Label>
                <select
                  id="skill_type"
                  className="w-full p-2 border rounded-md"
                  value={formData.skill_type}
                  onChange={(e) => setFormData(prev => ({ ...prev, skill_type: e.target.value }))}
                >
                  {SKILLS_OPTIONS.map((option) => (
                    <option key={option.value} value={option.value}>
                      {option.label}
                    </option>
                  ))}
                </select>
              </div>

              <div>
                <Label>Уровень сложности</Label>
                <div className="grid grid-cols-1 gap-2 mt-2">
                  {DIFFICULTY_OPTIONS.map((option) => (
                    <Button
                      key={option.value}
                      variant={formData.difficulty_level === option.value ? 'default' : 'outline'}
                      size="sm"
                      onClick={() => setFormData(prev => ({ ...prev, difficulty_level: option.value as any }))}
                      className="justify-start"
                    >
                      <Badge className={`${option.color} mr-2 hover:${option.color}`} variant="secondary">
                        {option.label}
                      </Badge>
                    </Button>
                  ))}
                </div>
              </div>
            </CardContent>
          </Card>

          {/* Статус публикации */}
          <Card>
            <CardHeader>
              <CardTitle>Публикация</CardTitle>
            </CardHeader>
            <CardContent className="space-y-4">
              <div className="flex items-center justify-between">
                <span className="text-sm">Статус:</span>
                <Badge className={formData.is_published ? 'bg-green-100 text-green-800 hover:bg-green-100' : 'bg-orange-100 text-orange-800 hover:bg-orange-100'}>
                  {formData.is_published ? 'Опубликован' : 'Черновик'}
                </Badge>
              </div>
              <p className="text-xs text-muted-foreground">
                {formData.is_published 
                  ? 'Материал доступен всем студентам' 
                  : 'Материал скрыт от студентов'
                }
              </p>
            </CardContent>
          </Card>
        </div>
      </div>
    </div>
  )
} 