import { Link, useLocation } from "react-router-dom"
import { useAuthStore } from "../../stores/auth"
import { cn } from "../../lib/utils"
import {
  LayoutDashboard,
  BookOpen,
  Users,
  BarChart,
  Settings,
  LogOut,
  Menu,
  X,
  Plus
} from "lucide-react"
import { useState, useEffect } from "react"
import { Button } from "../ui/button"

interface AdminLayoutProps {
  children: React.ReactNode
}

export function AdminLayout({ children }: AdminLayoutProps) {
  const location = useLocation()
  const user = useAuthStore(state => state.user)
  const clearAuth = useAuthStore(state => state.clearAuth)
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false)

  // Проверяем права доступа
  if (user?.role !== 'admin') {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-center">
          <h1 className="text-2xl font-bold mb-4">Доступ запрещен</h1>
          <p className="text-muted-foreground mb-4">У вас нет прав для доступа к админ-панели</p>
          <Link to="/dashboard">
            <Button>Вернуться на главную</Button>
          </Link>
        </div>
      </div>
    )
  }

  const navigation = [
    {
      name: "Панель управления",
      href: "/admin",
      icon: LayoutDashboard
    },
    {
      name: "Материалы",
      href: "/admin/materials",
      icon: BookOpen
    },
    {
      name: "Пользователи",
      href: "/admin/users",
      icon: Users
    },
    {
      name: "Аналитика",
      href: "/admin/analytics",
      icon: BarChart
    }
  ]

  // Закрываем меню при изменении маршрута
  useEffect(() => {
    setIsMobileMenuOpen(false)
  }, [location])

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
        className={cn(
          "fixed inset-y-0 left-0 z-40 w-72 transform transition-transform duration-200 ease-in-out lg:translate-x-0",
          isMobileMenuOpen ? "translate-x-0" : "-translate-x-full"
        )}
      >
        {/* Сайдбар */}
        <div className="flex flex-1 flex-col h-full bg-card border-r">
          {/* Логотип */}
          <div className="flex h-16 items-center px-4">
            <h1 className="text-2xl font-bold text-primary">Soft Skill Admin</h1>
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
                      ? "bg-primary text-primary-foreground"
                      : "text-muted-foreground hover:bg-muted hover:text-foreground"
                  )}
                >
                  <item.icon className="h-5 w-5" />
                  {item.name}
                </Link>
              )
            })}
          </nav>

          {/* Быстрые действия */}
          <div className="p-4 border-t">
            <Link to="/admin/materials/new">
              <Button className="w-full" size="sm">
                <Plus className="h-4 w-4 mr-2" />
                Создать материал
              </Button>
            </Link>
          </div>

          {/* Профиль пользователя */}
          <div className="p-4 border-t">
            <div className="flex items-center justify-between">
              <div className="flex items-center">
                <div>
                  <p className="text-sm font-medium">{user?.full_name}</p>
                  <p className="text-xs text-muted-foreground">Администратор</p>
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