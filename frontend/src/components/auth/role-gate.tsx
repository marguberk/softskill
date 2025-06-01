import { useAuthStore } from "../../stores/auth"
import { Navigate } from "react-router-dom"

interface RoleGateProps {
  children: React.ReactNode
  allowedRoles: string[]
}

export function RoleGate({ children, allowedRoles }: RoleGateProps) {
  const user = useAuthStore(state => state.user)

  if (!user) {
    return <Navigate to="/login" replace />
  }

  if (!allowedRoles.includes(user.role)) {
    // Перенаправляем на соответствующую домашнюю страницу
    if (user.role === "teacher") {
      return <Navigate to="/teacher/dashboard" replace />
    }
    return <Navigate to="/dashboard" replace />
  }

  return <>{children}</>
}