import { Button } from "../ui/button"
import { useAuthStore } from "../../stores/auth"
import { useNavigate } from "react-router-dom"
import { LogOut, User } from "lucide-react"
import { userStorage } from "../../utils/userStorage"

export function UserNav() {
  const navigate = useNavigate()
  const { user, clearAuth } = useAuthStore()

  const handleLogout = () => {
    // Очищаем данные пользователя из localStorage
    userStorage.clearUserData()
    
    clearAuth()
    navigate('/login')
  }

  return (
    <div className="flex items-center gap-4 px-4 py-3 border-t">
      <div className="min-w-0 flex-1 flex items-center">
        <div className="h-10 w-10 rounded-full bg-muted flex items-center justify-center">
          <User className="h-5 w-5 text-muted-foreground" />
        </div>
        <div className="ml-3 min-w-0 flex-1">
          <p className="text-sm font-medium truncate">
            {user?.full_name || 'Пользователь'}
          </p>
          <p className="text-sm text-muted-foreground truncate">
            {user?.email}
          </p>
        </div>
      </div>
      <Button
        variant="ghost"
        size="icon"
        onClick={handleLogout}
        className="h-8 w-8"
      >
        <LogOut className="h-5 w-5" />
      </Button>
    </div>
  )
}