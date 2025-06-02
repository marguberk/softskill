import { useState, useEffect } from "react"
import { Card, CardHeader, CardTitle, CardContent } from "../../components/ui/card"
import { Button } from "../../components/ui/button"
import { Input } from "../../components/ui/input"
import { toast } from "sonner"
import { useAuthStore } from "../../stores/auth"
import {
  User,
  Mail,
  Lock,
  Edit3,
  Save,
  X,
  Eye,
  EyeOff
} from "lucide-react"

interface UserProfile {
  id: number
  email: string
  full_name: string
  role: string
  is_active: boolean
}

export default function StudentProfile() {
  const [profile, setProfile] = useState<UserProfile | null>(null)
  const [isLoading, setIsLoading] = useState(true)
  const [isEditing, setIsEditing] = useState(false)
  const [isChangingPassword, setIsChangingPassword] = useState(false)
  const [isSavingProfile, setIsSavingProfile] = useState(false)
  const [isSavingPassword, setIsSavingPassword] = useState(false)
  const [showPasswords, setShowPasswords] = useState({
    current: false,
    new: false,
    confirm: false
  })
  const [editForm, setEditForm] = useState({
    full_name: "",
    email: ""
  })
  const [passwordForm, setPasswordForm] = useState({
    current_password: "",
    new_password: "",
    confirm_password: ""
  })

  const { user, setAuth } = useAuthStore()
  const API_BASE = 'http://127.0.0.1:8002/api/v1'

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
      } else {
        toast.error('Не удалось загрузить данные профиля')
      }
    } catch (error) {
      console.error('Ошибка при загрузке профиля:', error)
      toast.error('Ошибка при загрузке профиля')
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
      setIsSavingProfile(true)
      const response = await fetch(`${API_BASE}/auth/profile`, {
        method: 'PUT',
        headers: getAuthHeaders(),
        body: JSON.stringify(editForm)
      })
      
      if (response.ok) {
        const updatedProfile = await response.json()
        setProfile(updatedProfile)
        setIsEditing(false)
        
        // Обновляем пользователя в store
        if (user) {
          const token = localStorage.getItem('token') || localStorage.getItem('access_token')
          if (token) {
            setAuth({
              ...user,
              full_name: updatedProfile.full_name,
              email: updatedProfile.email
            }, token)
          }
        }
        
        toast.success('Профиль успешно обновлен')
      } else {
        const error = await response.json()
        toast.error(error.detail || 'Ошибка при сохранении профиля')
      }
    } catch (error) {
      console.error('Ошибка при сохранении профиля:', error)
      toast.error('Ошибка при сохранении профиля')
    } finally {
      setIsSavingProfile(false)
    }
  }

  const handlePasswordChange = async () => {
    // Валидация полей
    if (!passwordForm.current_password) {
      toast.error('Введите текущий пароль')
      return
    }

    if (!passwordForm.new_password) {
      toast.error('Введите новый пароль')
      return
    }

    if (!passwordForm.confirm_password) {
      toast.error('Подтвердите новый пароль')
      return
    }

    if (passwordForm.new_password !== passwordForm.confirm_password) {
      toast.error('Новый пароль и подтверждение не совпадают')
      return
    }

    if (passwordForm.new_password.length < 6) {
      toast.error('Пароль должен содержать минимум 6 символов')
      return
    }

    if (passwordForm.current_password === passwordForm.new_password) {
      toast.error('Новый пароль должен отличаться от текущего')
      return
    }

    try {
      setIsSavingPassword(true)
      const response = await fetch(`${API_BASE}/auth/change-password`, {
        method: 'PUT',
        headers: getAuthHeaders(),
        body: JSON.stringify({
          current_password: passwordForm.current_password,
          new_password: passwordForm.new_password
        })
      })
      
      if (response.ok) {
        toast.success('Пароль успешно изменен')
        setPasswordForm({
          current_password: "",
          new_password: "",
          confirm_password: ""
        })
        setIsChangingPassword(false)
      } else {
        const error = await response.json()
        if (error.detail === 'Неверный текущий пароль' || error.detail === 'Incorrect current password') {
          toast.error('Неверный текущий пароль')
        } else {
          toast.error(error.detail || 'Ошибка при смене пароля')
        }
      }
    } catch (error) {
      console.error('Ошибка при смене пароля:', error)
      toast.error('Ошибка соединения с сервером')
    } finally {
      setIsSavingPassword(false)
    }
  }

  const handleCancelPasswordChange = () => {
    setPasswordForm({
      current_password: "",
      new_password: "",
      confirm_password: ""
    })
    setIsChangingPassword(false)
  }

  const togglePasswordVisibility = (field: 'current' | 'new' | 'confirm') => {
    setShowPasswords(prev => ({
      ...prev,
      [field]: !prev[field]
    }))
  }

  useEffect(() => {
    loadProfile()
  }, [])

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
        <Button 
          variant="outline" 
          onClick={loadProfile}
          className="mt-4"
        >
          Попробовать снова
        </Button>
      </div>
    )
  }

  return (
    <div className="space-y-8">
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

      {/* Контент в две колонки */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
        {/* Основная информация */}
        <Card className="h-fit">
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
                    disabled={isSavingProfile}
                  >
                    <X className="h-4 w-4 mr-2" />
                    Отмена
                  </Button>
                  <Button 
                    size="sm"
                    onClick={handleSave}
                    disabled={isSavingProfile}
                  >
                    {isSavingProfile ? (
                      <>
                        <div className="animate-spin rounded-full h-4 w-4 border-b-2 border-white mr-2"></div>
                        Сохранение...
                      </>
                    ) : (
                      <>
                        <Save className="h-4 w-4 mr-2" />
                        Сохранить
                      </>
                    )}
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
                    disabled={isSavingProfile}
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
                    disabled={isSavingProfile}
                  />
                ) : (
                  <p className="text-lg">{profile.email}</p>
                )}
              </div>
            </div>
          </CardContent>
        </Card>

        {/* Смена пароля */}
        <Card className="h-fit">
          <CardHeader>
            <div className="flex items-center justify-between">
              <CardTitle className="flex items-center gap-2">
                <Lock className="h-5 w-5" />
                Безопасность
              </CardTitle>
              {!isChangingPassword ? (
                <Button 
                  variant="outline" 
                  size="sm"
                  onClick={() => setIsChangingPassword(true)}
                  disabled={isEditing}
                >
                  <Lock className="h-4 w-4 mr-2" />
                  Изменить пароль
                </Button>
              ) : (
                <div className="flex gap-2">
                  <Button 
                    variant="outline" 
                    size="sm"
                    onClick={handleCancelPasswordChange}
                    disabled={isSavingPassword}
                  >
                    <X className="h-4 w-4 mr-2" />
                    Отмена
                  </Button>
                  <Button 
                    size="sm"
                    onClick={handlePasswordChange}
                    disabled={isSavingPassword}
                  >
                    {isSavingPassword ? (
                      <>
                        <div className="animate-spin rounded-full h-4 w-4 border-b-2 border-white mr-2"></div>
                        Сохранение...
                      </>
                    ) : (
                      <>
                        <Save className="h-4 w-4 mr-2" />
                        Сохранить
                      </>
                    )}
                  </Button>
                </div>
              )}
            </div>
          </CardHeader>
          <CardContent>
            {!isChangingPassword ? (
              <div className="flex items-center justify-between p-4 border rounded-lg">
                <div>
                  <h4 className="font-medium">Изменить пароль</h4>
                  <p className="text-sm text-muted-foreground">
                    Обновите пароль для обеспечения безопасности аккаунта
                  </p>
                </div>
              </div>
            ) : (
              <div className="space-y-4">
                {/* Текущий пароль */}
                <div className="space-y-2">
                  <label className="text-sm font-medium">
                    Текущий пароль
                  </label>
                  <div className="relative">
                    <Input
                      type={showPasswords.current ? "text" : "password"}
                      value={passwordForm.current_password}
                      onChange={(e) => setPasswordForm(prev => ({ ...prev, current_password: e.target.value }))}
                      placeholder="Введите текущий пароль"
                      disabled={isSavingPassword}
                    />
                    <button
                      type="button"
                      onClick={() => togglePasswordVisibility('current')}
                      className="absolute right-3 top-1/2 -translate-y-1/2 text-gray-500 hover:text-gray-700"
                      disabled={isSavingPassword}
                    >
                      {showPasswords.current ? (
                        <EyeOff className="h-4 w-4" />
                      ) : (
                        <Eye className="h-4 w-4" />
                      )}
                    </button>
                  </div>
                </div>

                {/* Новый пароль */}
                <div className="space-y-2">
                  <label className="text-sm font-medium">
                    Новый пароль
                  </label>
                  <div className="relative">
                    <Input
                      type={showPasswords.new ? "text" : "password"}
                      value={passwordForm.new_password}
                      onChange={(e) => setPasswordForm(prev => ({ ...prev, new_password: e.target.value }))}
                      placeholder="Введите новый пароль"
                      disabled={isSavingPassword}
                    />
                    <button
                      type="button"
                      onClick={() => togglePasswordVisibility('new')}
                      className="absolute right-3 top-1/2 -translate-y-1/2 text-gray-500 hover:text-gray-700"
                      disabled={isSavingPassword}
                    >
                      {showPasswords.new ? (
                        <EyeOff className="h-4 w-4" />
                      ) : (
                        <Eye className="h-4 w-4" />
                      )}
                    </button>
                  </div>
                </div>

                {/* Подтверждение пароля */}
                <div className="space-y-2">
                  <label className="text-sm font-medium">
                    Подтвердите новый пароль
                  </label>
                  <div className="relative">
                    <Input
                      type={showPasswords.confirm ? "text" : "password"}
                      value={passwordForm.confirm_password}
                      onChange={(e) => setPasswordForm(prev => ({ ...prev, confirm_password: e.target.value }))}
                      placeholder="Повторите новый пароль"
                      disabled={isSavingPassword}
                    />
                    <button
                      type="button"
                      onClick={() => togglePasswordVisibility('confirm')}
                      className="absolute right-3 top-1/2 -translate-y-1/2 text-gray-500 hover:text-gray-700"
                      disabled={isSavingPassword}
                    >
                      {showPasswords.confirm ? (
                        <EyeOff className="h-4 w-4" />
                      ) : (
                        <Eye className="h-4 w-4" />
                      )}
                    </button>
                  </div>
                </div>

                {/* Требования к паролю */}
                <div className="text-xs text-muted-foreground bg-muted p-3 rounded-lg">
                  <p className="font-medium mb-1">Требования к паролю:</p>
                  <ul className="list-disc list-inside space-y-1">
                    <li>Минимум 6 символов</li>
                    <li>Должен отличаться от текущего пароля</li>
                    <li>Рекомендуется использовать буквы, цифры и специальные символы</li>
                  </ul>
                </div>
              </div>
            )}
          </CardContent>
        </Card>
      </div>
    </div>
  )
}