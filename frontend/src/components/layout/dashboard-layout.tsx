import { MainNav } from "./main-nav"
import { UserNav } from "./user-nav"

interface DashboardLayoutProps {
  children: React.ReactNode
}

export function DashboardLayout({ children }: DashboardLayoutProps) {
  return (
    <div className="min-h-screen bg-background">
      {/* Сайдбар */}
      <div className="fixed inset-y-0 w-64 border-r bg-card">
        <div className="flex h-full flex-col">
          {/* Логотип */}
          <div className="border-b h-14 flex items-center px-4">
            <h1 className="text-xl font-bold">Soft Skill</h1>
          </div>

          {/* Основная навигация */}
          <div className="flex-1 overflow-y-auto p-4">
            <MainNav />
          </div>

          {/* Профиль пользователя */}
          <UserNav />
        </div>
      </div>

      {/* Основной контент */}
      <div className="pl-64">
        <main className="p-8">
          {children}
        </main>
      </div>
    </div>
  )
}