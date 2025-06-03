import { Link, useLocation } from "react-router-dom"
import { useAuthStore } from "../../stores/auth"
import { cn } from "../../lib/utils"
import {
  LayoutDashboard,
  BookOpen,
  LineChart,
  Settings,
  LogOut,
  User,
  Menu,
  X,
  Calendar
} from "lucide-react"
import { useState, useEffect } from "react"
import { Button } from "../ui/button"
import { userStorage } from "../../utils/userStorage"

interface StudentLayoutProps {
  children: React.ReactNode
}

export function StudentLayout({ children }: StudentLayoutProps) {
  const location = useLocation()
  const user = useAuthStore(state => state.user)
  const clearAuth = useAuthStore(state => state.clearAuth)
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false)

  // Закрываем меню при изменении маршрута
  useEffect(() => {
    setIsMobileMenuOpen(false)
  }, [location])

  // Закрываем меню при клике вне его на мобильных устройствах
  useEffect(() => {
    const handleClickOutside = (event: MouseEvent) => {
      const sidebar = document.getElementById('sidebar')
      if (sidebar && !sidebar.contains(event.target as Node)) {
        setIsMobileMenuOpen(false)
      }
    }

    if (isMobileMenuOpen) {
      document.addEventListener('mousedown', handleClickOutside)
    }

    return () => {
      document.removeEventListener('mousedown', handleClickOutside)
    }
  }, [isMobileMenuOpen])

  // Блокируем скролл при открытом мобильном меню
  useEffect(() => {
    if (isMobileMenuOpen) {
      document.body.style.overflow = 'hidden'
    } else {
      document.body.style.overflow = 'unset'
    }

    return () => {
      document.body.style.overflow = 'unset'
    }
  }, [isMobileMenuOpen])

  const navigation = [
    {
      name: "Дашборд",
      href: "/dashboard",
      icon: LayoutDashboard
    },
    {
      name: "Задания",
      href: "/daily-tasks",
      icon: Calendar
    },
    {
      name: "Обучение",
      href: "/learning",
      icon: BookOpen
    },
    {
      name: "Прогресс",
      href: "/progress",
      icon: LineChart
    },
    {
      name: "Профиль",
      href: "/profile",
      icon: User
    },
  ]

  return (
    <div className="min-h-screen bg-background">
      {/* Мобильная верхняя панель */}
      <div className="lg:hidden fixed top-0 left-0 right-0 h-16 bg-card border-b z-50 flex items-center justify-between px-4">
        <Button
          variant="ghost"
          size="icon"
          onClick={() => setIsMobileMenuOpen(!isMobileMenuOpen)}
          className="h-10 w-10"
        >
          {isMobileMenuOpen ? (
            <X className="h-6 w-6" />
          ) : (
            <Menu className="h-6 w-6" />
          )}
        </Button>
        
        <h1 className="text-lg font-semibold truncate">Soft Skill</h1>
        
        <Button
          variant="ghost"
          size="icon"
          onClick={() => {
            userStorage.clearUserData()
            clearAuth()
          }}
          className="h-10 w-10"
          title="Выйти"
        >
          <LogOut className="h-5 w-5" />
        </Button>
      </div>

      {/* Боковая панель */}
      <div
        id="sidebar"
        className={cn(
          "fixed inset-y-0 left-0 z-40 w-72 transform transition-transform duration-300 ease-in-out lg:translate-x-0",
          isMobileMenuOpen ? "translate-x-0" : "-translate-x-full lg:translate-x-0"
        )}
      >
        {/* Сайдбар */}
        <div className="flex flex-1 flex-col h-full bg-card border-r shadow-xl lg:shadow-none">
          {/* Логотип - скрыт на мобильных, показан на десктопе */}
          <div className="hidden lg:flex h-16 items-center px-4">
            <h1 className="text-2xl font-bold">Soft Skill</h1>
          </div>

          {/* Отступ для мобильной верхней панели */}
          <div className="h-16 lg:hidden"></div>

          {/* Навигация */}
          <nav className="flex-1 space-y-1 px-4 py-4">
            {navigation.map((item) => {
              const isActive = location.pathname === item.href
              return (
                <Link
                  key={item.name}
                  to={item.href}
                  onClick={() => setIsMobileMenuOpen(false)}
                  className={cn(
                    "flex items-center gap-x-3 rounded-lg px-4 py-3 text-sm font-medium transition-all",
                    isActive
                      ? "bg-primary text-primary-foreground hover:bg-primary hover:text-primary-foreground shadow-sm"
                      : "text-muted-foreground hover:bg-muted hover:text-foreground"
                  )}
                >
                  <item.icon className="h-5 w-5 flex-shrink-0" />
                  <span className="truncate">{item.name}</span>
                </Link>
              )
            })}
          </nav>

          {/* Профиль пользователя - только для десктопа */}
          <div className="hidden lg:block mt-auto p-4 border-t">
            <div className="flex items-center justify-between">
              <div className="flex items-center min-w-0">
                <div className="min-w-0">
                  <p className="text-sm font-medium truncate">{user?.full_name}</p>
                  <p className="text-xs text-muted-foreground truncate">{user?.email}</p>
                </div>
              </div>
              <button
                onClick={() => {
                  userStorage.clearUserData()
                  clearAuth()
                }}
                className="text-muted-foreground hover:text-foreground ml-2 flex-shrink-0"
                title="Выйти"
              >
                <LogOut className="h-5 w-5" />
              </button>
            </div>
          </div>
        </div>
      </div>

      {/* Затемнение фона при открытом мобильном меню */}
      {isMobileMenuOpen && (
        <div
          className="fixed inset-0 bg-black/50 backdrop-blur-sm z-30 lg:hidden"
          onClick={() => setIsMobileMenuOpen(false)}
        />
      )}

      {/* Основной контент */}
      <div className="lg:pl-72">
        {/* Отступ для мобильной верхней панели */}
        <div className="h-16 lg:hidden"></div>
        
        <main className="py-6 px-4 sm:px-6 lg:px-8 lg:py-10">
          {children}
        </main>
      </div>
    </div>
  )
}