import { Navigate, useLocation } from 'react-router-dom'
import { useAuthStore } from '../../stores/auth'
import { useEffect, useState } from 'react'

interface ProtectedRouteProps {
  children: React.ReactNode
}

export function ProtectedRoute({ children }: ProtectedRouteProps) {
  const { isAuthenticated, user, initializeAuth } = useAuthStore()
  const location = useLocation()
  const [isInitialized, setIsInitialized] = useState(false)

  useEffect(() => {
    // Инициализируем авторизацию при первой загрузке
    initializeAuth()
    setIsInitialized(true)
  }, [initializeAuth])

  // Показываем загрузку пока не инициализировались
  if (!isInitialized) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary"></div>
      </div>
    )
  }

  // Если не авторизован, перенаправляем на логин
  if (!isAuthenticated || !user) {
    return <Navigate to="/login" state={{ from: location }} replace />
  }

  return <>{children}</>
}