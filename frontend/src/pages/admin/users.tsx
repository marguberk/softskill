import { Card, CardContent } from "../../components/ui/card"
import { Users } from "lucide-react"

export default function UsersPage() {
  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-3xl font-bold tracking-tight">Управление пользователями</h1>
        <p className="text-muted-foreground">
          Просмотр и управление пользователями системы
        </p>
      </div>

      <Card>
        <CardContent className="py-12 text-center">
          <Users className="h-12 w-12 text-muted-foreground mx-auto mb-4" />
          <h3 className="text-lg font-medium mb-2">Скоро будет доступно</h3>
          <p className="text-muted-foreground">
            Функционал управления пользователями находится в разработке
          </p>
        </CardContent>
      </Card>
    </div>
  )
} 