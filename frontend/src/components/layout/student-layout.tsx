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
      {/* Мобильная кнопка меню */}
      <div className="lg:hidden fixed top-4 left-4 z-50">
        <Button
          variant="outline"
          size="icon"
          onClick={() => setIsMobileMenuOpen(!isMobileMenuOpen)}
        >
          {isMobileMenuOpen ? (
            <X className="h-6 w-6" />
          ) : (
            <Menu className="h-6 w-6" />
          )}
        </Button>
      </div>

      {/* Боковая панель */}
      <div
        id="sidebar"
        className={cn(
          "fixed inset-y-0 left-0 z-40 w-72 transform transition-transform duration-200 ease-in-out lg:translate-x-0",
          isMobileMenuOpen ? "translate-x-0" : "-translate-x-full"
        )}
      >
        {/* Сайдбар */}
        <div className="flex flex-1 flex-col h-full bg-card border-r">
          {/* Логотип */}
          <div className="flex h-16 items-center px-4">
            <h1 className="text-2xl font-bold">Soft Skill</h1>
          </div>

          {/* Навигация */}
          <nav className="flex-1 space-y-1 px-2 mt-5">
            {navigation.map((item) => {
              const isActive = location.pathname === item.href
              return (
                <Link
                  key={item.name}
                  to={item.href}
                  className={cn(
                    "flex items-center gap-x-3 rounded-lg px-3 py-2 text-sm font-medium transition-all",
                    isActive
                      ? "bg-primary text-primary-foreground hover:bg-primary hover:text-primary-foreground"
                      : "text-muted-foreground hover:bg-muted hover:text-foreground"
                  )}
                >
                  <item.icon className="h-5 w-5" />
                  {item.name}
                </Link>
              )
            })}
          </nav>

          {/* Профиль пользователя */}
          <div className="mt-auto p-4 border-t">
            <div className="flex items-center justify-between">
              <div className="flex items-center">
                <div>
                  <p className="text-sm font-medium">{user?.full_name}</p>
                  <p className="text-xs text-muted-foreground">{user?.email}</p>
                </div>
              </div>
              <button
                onClick={() => clearAuth()}
                className="text-muted-foreground hover:text-foreground"
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
          className="fixed inset-0 bg-background/80 backdrop-blur-sm z-30 lg:hidden"
          onClick={() => setIsMobileMenuOpen(false)}
        />
      )}

      {/* Основной контент */}
      <div className="lg:pl-72">
        <main className="py-10">
          <div className="px-4 sm:px-6 lg:px-8">
            {children}
          </div>
        </main>
      </div>
    </div>
  )
}