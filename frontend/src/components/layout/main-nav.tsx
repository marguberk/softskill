import { Link, useLocation } from "react-router-dom"
import { cn } from "../../lib/utils"
import { LayoutGrid, BookOpen, Users, Settings, Award } from "lucide-react"

const navItems = [
  {
    title: "Главная",
    href: "/dashboard",
    icon: LayoutGrid
  },
  {
    title: "Курсы",
    href: "/courses",
    icon: BookOpen
  },
  {
    title: "Достижения",
    href: "/achievements",
    icon: Award
  },
  {
    title: "Сообщество",
    href: "/community",
    icon: Users
  },
  {
    title: "Настройки",
    href: "/settings",
    icon: Settings
  }
]

export function MainNav() {
  const location = useLocation()

  return (
    <nav className="space-y-1">
      {navItems.map((item) => (
        <Link
          key={item.href}
          to={item.href}
          className={cn(
            "flex items-center px-3 py-2 text-sm rounded-md transition-colors",
            "hover:bg-muted hover:text-primary",
            location.pathname === item.href
              ? "bg-muted text-primary font-medium"
              : "text-muted-foreground"
          )}
        >
          <item.icon className="h-5 w-5 mr-3" />
          {item.title}
        </Link>
      ))}
    </nav>
  )
}