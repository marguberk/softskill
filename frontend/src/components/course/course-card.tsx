import { Card, CardContent, CardFooter } from "../ui/card"
import { Button } from "../ui/button"
import { BookOpen, Users, Clock } from "lucide-react"
import { useNavigate } from "react-router-dom"

interface CourseCardProps {
  id: number
  title: string
  description: string
  studentsCount: number
  duration: string
  lessonsCount: number
  imageUrl?: string
  price?: number
  enrolled?: boolean
  progress?: number
}

export function CourseCard({
  id,
  title,
  description,
  studentsCount,
  duration,
  lessonsCount,
  imageUrl,
  price,
  enrolled = false,
  progress
}: CourseCardProps) {
  const navigate = useNavigate()

  return (
    <Card className="overflow-hidden">
      {/* Обложка курса */}
      <div className="relative aspect-video w-full overflow-hidden bg-muted">
        <img
          src={imageUrl || "/api/placeholder/400/225"}
          alt={title}
          className="object-cover w-full h-full"
        />
        {price !== undefined && !enrolled && (
          <div className="absolute top-4 right-4 bg-background/95 px-3 py-1 rounded-full">
            <span className="font-medium">{price === 0 ? "Бесплатно" : `${price} ₸`}</span>
          </div>
        )}
        {enrolled && progress !== undefined && (
          <div className="absolute bottom-0 left-0 right-0 h-1 bg-muted">
            <div
              className="h-full bg-primary transition-all"
              style={{ width: `${progress}%` }}
            />
          </div>
        )}
      </div>

      <CardContent className="p-4">
        <h3 className="font-semibold text-lg line-clamp-1">{title}</h3>
        <p className="text-muted-foreground text-sm mt-1 line-clamp-2">
          {description}
        </p>

        <div className="mt-4 flex items-center gap-4 text-sm text-muted-foreground">
          <div className="flex items-center gap-1">
            <Clock className="h-4 w-4" />
            <span>{duration}</span>
          </div>
          <div className="flex items-center gap-1">
            <BookOpen className="h-4 w-4" />
            <span>{lessonsCount} уроков</span>
          </div>
          <div className="flex items-center gap-1">
            <Users className="h-4 w-4" />
            <span>{studentsCount}</span>
          </div>
        </div>
      </CardContent>

      <CardFooter className="p-4 pt-0">
        <Button
          className="w-full"
          variant={enrolled ? "secondary" : "default"}
          onClick={() => navigate(`/courses/${id}`)}
        >
          {enrolled ? "Продолжить обучение" : "Подробнее"}
        </Button>
      </CardFooter>
    </Card>
  )
}