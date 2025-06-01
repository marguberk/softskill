import { useState, useEffect } from "react"
import { Card, CardHeader, CardTitle, CardContent } from "../../components/ui/card"
import { Button } from "../../components/ui/button"
import { Input } from "../../components/ui/input"
import { Badge } from "../../components/ui/badge"
import {
  User,
  Mail,
  Calendar,
  Shield,
  Edit3,
  Save,
  X
} from "lucide-react"

interface UserProfile {
  id: number
  email: string
  full_name: string
  role: string
  is_active: boolean
  created_at: string
}

export default function StudentProfile() {
  const [profile, setProfile] = useState<UserProfile | null>(null)
  const [isLoading, setIsLoading] = useState(true)
  const [isEditing, setIsEditing] = useState(false)
  const [editForm, setEditForm] = useState({
    full_name: "",
    email: ""
  })

  const API_BASE = 'http://127.0.0.1:8000/api/v1'

  const getAuthHeaders = () => {
    const token = localStorage.getItem('token') || localStorage.getItem('access_token')
    return {
      'Authorization': `Bearer ${token}`,
      'Content-Type': 'application/json'
    }
  }

  const loadProfile = async () => {
    try {
      setIsLoading(true)
      const response = await fetch(`${API_BASE}/auth/me`, {
        headers: getAuthHeaders()
      })
      
      if (response.ok) {
        const data = await response.json()
        setProfile(data)
        setEditForm({
          full_name: data.full_name || "",
          email: data.email || ""
        })
      }
    } catch (error) {
      console.error('Ошибка при загрузке профиля:', error)
    } finally {
      setIsLoading(false)
    }
  }

  const handleEdit = () => {
    setIsEditing(true)
  }

  const handleCancel = () => {
    if (profile) {
      setEditForm({
        full_name: profile.full_name || "",
        email: profile.email || ""
      })
    }
    setIsEditing(false)
  }

  const handleSave = async () => {
    try {
      const response = await fetch(`${API_BASE}/auth/profile`, {
        method: 'PUT',
        headers: getAuthHeaders(),
        body: JSON.stringify(editForm)
      })
      
      if (response.ok) {
        const updatedProfile = await response.json()
        setProfile(updatedProfile)
        setIsEditing(false)
      }
    } catch (error) {
      console.error('Ошибка при сохранении профиля:', error)
    }
  }

  useEffect(() => {
    loadProfile()
  }, [])

  const getRoleLabel = (role: string) => {
    switch (role) {
      case 'admin': return 'Администратор'
      case 'student': return 'Студент'
      default: return role
    }
  }

  const getRoleColor = (role: string) => {
    switch (role) {
      case 'admin': return 'bg-red-100 text-red-800'
      case 'student': return 'bg-blue-100 text-blue-800'
      default: return 'bg-gray-100 text-gray-800'
    }
  }

  if (isLoading) {
    return (
      <div className="flex items-center justify-center min-h-96">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary"></div>
      </div>
    )
  }

  if (!profile) {
    return (
      <div className="text-center py-12">
        <p>Не удалось загрузить данные профиля</p>
      </div>
    )
  }

  return (
    <div className="space-y-8 max-w-2xl">
      {/* Заголовок */}
      <div>
        <h2 className="text-3xl font-bold tracking-tight flex items-center gap-3">
          <User className="h-8 w-8 text-primary" />
          Мой профиль
        </h2>
        <p className="text-muted-foreground">
          Управляйте информацией своего аккаунта
        </p>
      </div>

      {/* Основная информация */}
      <Card>
        <CardHeader className="pb-3">
          <div className="flex items-center justify-between">
            <CardTitle className="flex items-center gap-2">
              <User className="h-5 w-5" />
              Основная информация
            </CardTitle>
            {!isEditing ? (
              <Button 
                variant="outline" 
                size="sm"
                onClick={handleEdit}
              >
                <Edit3 className="h-4 w-4 mr-2" />
                Редактировать
              </Button>
            ) : (
              <div className="flex gap-2">
                <Button 
                  variant="outline" 
                  size="sm"
                  onClick={handleCancel}
                >
                  <X className="h-4 w-4 mr-2" />
                  Отмена
                </Button>
                <Button 
                  size="sm"
                  onClick={handleSave}
                >
                  <Save className="h-4 w-4 mr-2" />
                  Сохранить
                </Button>
              </div>
            )}
          </div>
        </CardHeader>
        <CardContent className="pt-0">
          <div className="space-y-6">
            {/* Имя */}
            <div className="space-y-2">
              <label className="text-sm font-medium flex items-center gap-2">
                <User className="h-4 w-4" />
                Полное имя
              </label>
              {isEditing ? (
                <Input
                  value={editForm.full_name}
                  onChange={(e) => setEditForm(prev => ({ ...prev, full_name: e.target.value }))}
                  placeholder="Введите ваше полное имя"
                />
              ) : (
                <p className="text-lg">{profile.full_name || "Не указано"}</p>
              )}
            </div>

            {/* Email */}
            <div className="space-y-2">
              <label className="text-sm font-medium flex items-center gap-2">
                <Mail className="h-4 w-4" />
                Email
              </label>
              {isEditing ? (
                <Input
                  type="email"
                  value={editForm.email}
                  onChange={(e) => setEditForm(prev => ({ ...prev, email: e.target.value }))}
                  placeholder="Введите email"
                />
              ) : (
                <p className="text-lg">{profile.email}</p>
              )}
            </div>

            {/* Роль */}
            <div className="space-y-2">
              <label className="text-sm font-medium flex items-center gap-2">
                <Shield className="h-4 w-4" />
                Роль
              </label>
              <Badge className={getRoleColor(profile.role)}>
                {getRoleLabel(profile.role)}
              </Badge>
            </div>

            {/* Дата регистрации */}
            <div className="space-y-2">
              <label className="text-sm font-medium flex items-center gap-2">
                <Calendar className="h-4 w-4" />
                Дата регистрации
              </label>
              <p className="text-lg">
                {new Date(profile.created_at).toLocaleDateString('ru-RU', {
                  day: 'numeric',
                  month: 'long',
                  year: 'numeric'
                })}
              </p>
            </div>

            {/* Статус аккаунта */}
            <div className="space-y-2">
              <label className="text-sm font-medium">
                Статус аккаунта
              </label>
              <Badge className={profile.is_active ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'}>
                {profile.is_active ? 'Активный' : 'Неактивный'}
              </Badge>
            </div>
          </div>
        </CardContent>
      </Card>

      {/* Дополнительная информация */}
      <Card>
        <CardHeader>
          <CardTitle>Безопасность</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="space-y-4">
            <div className="flex items-center justify-between p-4 border rounded-lg">
              <div>
                <h4 className="font-medium">Изменить пароль</h4>
                <p className="text-sm text-muted-foreground">
                  Обновите пароль для обеспечения безопасности аккаунта
                </p>
              </div>
              <Button variant="outline" disabled>
                Скоро...
              </Button>
            </div>
          </div>
        </CardContent>
      </Card>
    </div>
  )
}