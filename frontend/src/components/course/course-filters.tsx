import { Input } from "../ui/input"
import { Label } from "../ui/label"
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "../ui/select"
import { Slider } from "../ui/slider"

interface CourseFiltersProps {
  onFilterChange: (filters: any) => void
}

export function CourseFilters({ onFilterChange }: CourseFiltersProps) {
  return (
    <div className="space-y-4">
      <div>
        <Label>Поиск</Label>
        <Input
          placeholder="Введите название курса..."
          onChange={(e) => onFilterChange({ search: e.target.value })}
        />
      </div>

      <div>
        <Label>Категория</Label>
        <Select onValueChange={(value) => onFilterChange({ category: value })}>
          <SelectTrigger>
            <SelectValue placeholder="Выберите категорию" />
          </SelectTrigger>
          <SelectContent>
            <SelectItem value="all">Все категории</SelectItem>
            <SelectItem value="programming">Программирование</SelectItem>
            <SelectItem value="design">Дизайн</SelectItem>
            <SelectItem value="business">Бизнес</SelectItem>
            <SelectItem value="marketing">Маркетинг</SelectItem>
          </SelectContent>
        </Select>
      </div>

      <div>
        <Label>Уровень</Label>
        <Select onValueChange={(value) => onFilterChange({ level: value })}>
          <SelectTrigger>
            <SelectValue placeholder="Выберите уровень" />
          </SelectTrigger>
          <SelectContent>
            <SelectItem value="all">Все уровни</SelectItem>
            <SelectItem value="beginner">Начинающий</SelectItem>
            <SelectItem value="intermediate">Средний</SelectItem>
            <SelectItem value="advanced">Продвинутый</SelectItem>
          </SelectContent>
        </Select>
      </div>

      <div>
        <Label>Длительность</Label>
        <Select onValueChange={(value) => onFilterChange({ duration: value })}>
          <SelectTrigger>
            <SelectValue placeholder="Выберите длительность" />
          </SelectTrigger>
          <SelectContent>
            <SelectItem value="all">Любая длительность</SelectItem>
            <SelectItem value="short">До 2 часов</SelectItem>
            <SelectItem value="medium">2-5 часов</SelectItem>
            <SelectItem value="long">Более 5 часов</SelectItem>
          </SelectContent>
        </Select>
      </div>

      <div>
        <Label>Цена</Label>
        <div className="pt-2">
          <Slider
            defaultValue={[0]}
            max={100000}
            step={1000}
            onValueChange={(value) => onFilterChange({ maxPrice: value[0] })}
          />
          <div className="mt-1 text-sm text-muted-foreground">
            До {Intl.NumberFormat('ru-RU').format(100000)} ₸
          </div>
        </div>
      </div>
    </div>
  )
}