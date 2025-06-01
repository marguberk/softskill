import { useState, useEffect } from "react"
import { useParams, Link } from "react-router-dom"
import ReactMarkdown from 'react-markdown'
import { Card, CardHeader, CardTitle, CardContent } from "../../components/ui/card"
import { Button } from "../../components/ui/button"
import { Badge } from "../../components/ui/badge"
import {
  BookOpen,
  Play,
  Clock,
  ArrowLeft,
  CheckCircle,
  Circle
} from "lucide-react"

// Интерфейс для обучающего материала
interface LearningMaterial {
  id: number
  title: string
  description: string
  type: 'video' | 'article' | 'tutorial'
  skill: string
  duration: string
  level: 'beginner' | 'intermediate' | 'advanced'
  url: string
  author: string
  theory: string
  videoId?: string
  tasks?: Task[]
}

interface Task {
  id: number
  title: string
  description: string
  completed: boolean
}

// Мок данные для материалов с полным содержимым
const LEARNING_MATERIALS: LearningMaterial[] = [
  {
    id: 1,
    title: "Эффективная коммуникация в команде",
    description: "Основы делового общения, активное слушание и конструктивная обратная связь",
    type: 'video',
    skill: 'communication',
    duration: '15 мин',
    level: 'beginner',
    url: 'https://youtube.com/watch?v=dQw4w9WgXcQ',
    videoId: 'dQw4w9WgXcQ',
    author: 'Анна Смирнова',
    theory: `
## Основы эффективной коммуникации

### Активное слушание
Активное слушание — это навык, который позволяет не просто слышать, но и понимать собеседника. Основные принципы:
- **Полное внимание** — сосредоточьтесь на говорящем
- **Невербальные сигналы** — кивайте, поддерживайте зрительный контакт
- **Переформулирование** — повторите услышанное своими словами
- **Задавайте вопросы** — уточняйте детали и показывайте заинтересованность

### Конструктивная обратная связь
Правильная обратная связь помогает команде расти и развиваться:
1. **Будьте конкретными** — указывайте на конкретные действия
2. **Фокусируйтесь на поведении** — критикуйте действия, а не личность
3. **Предлагайте решения** — не только указывайте на проблемы
4. **Выбирайте время** — давайте обратную связь в подходящий момент

### Барьеры в коммуникации
- Эмоциональные барьеры
- Культурные различия
- Технические помехи
- Предрассудки и стереотипы
    `,
    tasks: [
      {
        id: 1,
        title: "Практика активного слушания",
        description: "В течение дня проведите 3 разговора, применяя технику активного слушания. Отметьте, как изменилось качество общения.",
        completed: false
      },
      {
        id: 2,
        title: "Дайте конструктивную обратную связь",
        description: "Найдите возможность дать коллеге или другу конструктивную обратную связь, используя принципы из урока.",
        completed: false
      }
    ]
  },
  {
    id: 2,
    title: "Лидерство в цифровую эпоху",
    description: "Современные подходы к управлению командой и мотивации сотрудников",
    type: 'article',
    skill: 'leadership',
    duration: '8 мин',
    level: 'intermediate',
    url: 'https://example.com/leadership-article',
    author: 'Дмитрий Козлов',
    theory: `
## Лидерство в цифровую эпоху

### Цифровое лидерство
В современном мире лидеры должны адаптироваться к быстро меняющимся технологиям и новым способам работы.

### Ключевые навыки цифрового лидера:
1. **Технологическая грамотность** — понимание цифровых инструментов
2. **Гибкость** — способность адаптироваться к изменениям
3. **Удаленное управление** — эффективное руководство распределенными командами
4. **Цифровая коммуникация** — использование онлайн-платформ для общения

### Мотивация в цифровой среде
- Установка четких целей и метрик
- Регулярная обратная связь через цифровые каналы
- Признание достижений в публичных каналах
- Предоставление возможностей для обучения и роста
    `,
    tasks: [
      {
        id: 1,
        title: "Оценка цифровых навыков команды",
        description: "Проведите оценку цифровых навыков вашей команды и составьте план развития.",
        completed: false
      }
    ]
  },
  {
    id: 3,
    title: "Техники решения проблем",
    description: "Структурированный подход к анализу и решению сложных задач",
    type: 'tutorial',
    skill: 'problem_solving',
    duration: '25 мин',
    level: 'advanced',
    url: 'https://youtube.com/watch?v=example3',
    videoId: 'oHg5SJYRHA0',
    author: 'Елена Петрова',
    theory: `
## Структурированный подход к решению проблем

### Метод "5 почему"
Техника, которая помогает найти корень проблемы:
1. Определите проблему
2. Спросите "Почему это произошло?"
3. Для каждого ответа снова спросите "Почему?"
4. Повторите 5 раз
5. Найдите и устраните корневую причину

### Матрица Эйзенхауэра
Помогает расставить приоритеты:
- **Важно и срочно** — делайте сразу
- **Важно, но не срочно** — планируйте
- **Не важно, но срочно** — делегируйте
- **Не важно и не срочно** — исключайте

### Мозговой штурм
Правила эффективного мозгового штурма:
1. Отложите критику
2. Стремитесь к количеству идей
3. Развивайте идеи других
4. Записывайте все предложения
    `,
    tasks: [
      {
        id: 1,
        title: "Применение метода '5 почему'",
        description: "Выберите актуальную проблему и примените метод '5 почему' для поиска корневой причины.",
        completed: false
      },
      {
        id: 2,
        title: "Организация мозгового штурма",
        description: "Проведите сессию мозгового штурма для решения рабочей или учебной задачи.",
        completed: false
      }
    ]
  }
]

const SKILLS_MAP = {
  communication: 'Коммуникация',
  leadership: 'Лидерство',
  problem_solving: 'Решение проблем',
  time_management: 'Управление временем',
  emotional_intelligence: 'Эмоциональный интеллект',
  teamwork: 'Командная работа'
}

const LEVEL_MAP = {
  beginner: 'Начинающий',
  intermediate: 'Средний',
  advanced: 'Продвинутый'
}

export default function LearningMaterialPage() {
  const { materialId } = useParams()
  const [material, setMaterial] = useState<LearningMaterial | null>(null)
  const [tasks, setTasks] = useState<Task[]>([])

  useEffect(() => {
    const foundMaterial = LEARNING_MATERIALS.find(m => m.id === parseInt(materialId || '0'))
    if (foundMaterial) {
      setMaterial(foundMaterial)
      setTasks(foundMaterial.tasks || [])
    }
  }, [materialId])

  const toggleTask = (taskId: number) => {
    setTasks(prev => prev.map(task => 
      task.id === taskId ? { ...task, completed: !task.completed } : task
    ))
  }

  const getTypeIcon = (type: string) => {
    switch (type) {
      case 'video':
        return <Play className="h-5 w-5" />
      case 'article':
        return <BookOpen className="h-5 w-5" />
      case 'tutorial':
        return <BookOpen className="h-5 w-5" />
      default:
        return <BookOpen className="h-5 w-5" />
    }
  }

  const getLevelColor = (level: string) => {
    switch (level) {
      case 'beginner':
        return 'bg-green-100 text-green-800'
      case 'intermediate':
        return 'bg-yellow-100 text-yellow-800'
      case 'advanced':
        return 'bg-red-100 text-red-800'
      default:
        return 'bg-gray-100 text-gray-800'
    }
  }

  if (!material) {
    return (
      <div className="text-center py-12">
        <BookOpen className="h-12 w-12 text-muted-foreground mx-auto mb-4" />
        <h3 className="text-lg font-medium mb-2">Материал не найден</h3>
        <Link to="/learning">
          <Button variant="outline">
            <ArrowLeft className="h-4 w-4 mr-2" />
            Вернуться к обучению
          </Button>
        </Link>
      </div>
    )
  }

  return (
    <div className="space-y-8">
      {/* Заголовок с навигацией */}
      <div className="flex items-center gap-4">
        <Link to="/learning">
          <Button variant="outline" size="sm">
            <ArrowLeft className="h-4 w-4 mr-2" />
            Назад
          </Button>
        </Link>
        <div className="flex-1">
          <div className="flex items-center gap-3 mb-2">
            {getTypeIcon(material.type)}
            <h1 className="text-3xl font-bold tracking-tight">{material.title}</h1>
          </div>
          <div className="flex items-center gap-4 text-sm text-muted-foreground">
            <span>{material.author}</span>
            <div className="flex items-center gap-1">
              <Clock className="h-4 w-4" />
              {material.duration}
            </div>
            <Badge className={getLevelColor(material.level)}>
              {LEVEL_MAP[material.level]}
            </Badge>
            <Badge variant="outline">
              {SKILLS_MAP[material.skill as keyof typeof SKILLS_MAP]}
            </Badge>
          </div>
        </div>
      </div>

      {/* Видео (если есть) */}
      {material.videoId && (
        <Card>
          <CardContent className="p-0">
            <div className="aspect-video">
              <iframe
                width="100%"
                height="100%"
                src={`https://www.youtube.com/embed/${material.videoId}`}
                title={material.title}
                frameBorder="0"
                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                allowFullScreen
                className="rounded-lg"
              />
            </div>
          </CardContent>
        </Card>
      )}

      {/* Теоретическая часть */}
      <Card>
        <CardHeader>
          <CardTitle className="flex items-center gap-2">
            <BookOpen className="h-5 w-5" />
            Теоретическая часть
          </CardTitle>
        </CardHeader>
        <CardContent>
          <div className="markdown-content">
            <ReactMarkdown
              components={{
                h1: ({node, ...props}) => <h1 className="text-2xl font-bold mb-4 text-foreground" {...props} />,
                h2: ({node, ...props}) => <h2 className="text-xl font-semibold mb-3 mt-6 text-foreground" {...props} />,
                h3: ({node, ...props}) => <h3 className="text-lg font-medium mb-2 mt-4 text-foreground" {...props} />,
                p: ({node, ...props}) => <p className="mb-3 text-muted-foreground leading-relaxed" {...props} />,
                ul: ({node, ...props}) => <ul className="list-disc ml-6 mb-4 space-y-1" {...props} />,
                ol: ({node, ...props}) => <ol className="list-decimal ml-6 mb-4 space-y-1" {...props} />,
                li: ({node, ...props}) => <li className="text-muted-foreground" {...props} />,
                strong: ({node, ...props}) => <strong className="font-semibold text-foreground" {...props} />,
              }}
            >
              {material.theory}
            </ReactMarkdown>
          </div>
        </CardContent>
      </Card>

      {/* Практические задания */}
      {tasks.length > 0 && (
        <Card>
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <CheckCircle className="h-5 w-5" />
              Практические задания
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              {tasks.map((task) => (
                <div 
                  key={task.id} 
                  className="flex items-start gap-3 p-4 border rounded-lg hover:bg-muted/50 transition-colors"
                >
                  <button
                    onClick={() => toggleTask(task.id)}
                    className="mt-1"
                  >
                    {task.completed ? (
                      <CheckCircle className="h-5 w-5 text-green-600" />
                    ) : (
                      <Circle className="h-5 w-5 text-muted-foreground" />
                    )}
                  </button>
                  <div className="flex-1">
                    <h4 className={`font-medium mb-1 ${task.completed ? 'line-through text-muted-foreground' : ''}`}>
                      {task.title}
                    </h4>
                    <p className={`text-sm ${task.completed ? 'line-through text-muted-foreground' : 'text-muted-foreground'}`}>
                      {task.description}
                    </p>
                  </div>
                </div>
              ))}
            </div>
          </CardContent>
        </Card>
      )}

      {/* Внешняя ссылка на источник */}
      <Card>
        <CardContent className="pt-6">
          <div className="flex items-center justify-between">
            <div>
              <h4 className="font-medium mb-1">Источник материала</h4>
              <p className="text-sm text-muted-foreground">
                Перейти к оригинальному источнику для дополнительной информации
              </p>
            </div>
            <Button asChild>
              <a href={material.url} target="_blank" rel="noopener noreferrer">
                Перейти к источнику
              </a>
            </Button>
          </div>
        </CardContent>
      </Card>
    </div>
  )
} 