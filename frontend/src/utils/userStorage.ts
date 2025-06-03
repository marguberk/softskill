// Утилиты для работы с пользовательскими данными в localStorage
// Привязывает данные к конкретному пользователю

const getUserId = (): string => {
  const token = localStorage.getItem('token') || localStorage.getItem('access_token')
  if (!token) return 'anonymous'
  
  try {
    // Извлекаем user_id из токена (это простая реализация, в продакшене лучше использовать proper JWT parsing)
    const payload = JSON.parse(atob(token.split('.')[1]))
    return payload.sub || payload.user_id || 'anonymous'
  } catch {
    return 'anonymous'
  }
}

const getUserStorageKey = (key: string): string => {
  const userId = getUserId()
  return `${key}_user_${userId}`
}

export const userStorage = {
  // Завершенные уроки
  getCompletedLessons(): Record<string, boolean> {
    const key = getUserStorageKey('completedLessons')
    return JSON.parse(localStorage.getItem(key) || '{}')
  },

  setCompletedLessons(data: Record<string, boolean>): void {
    const key = getUserStorageKey('completedLessons')
    localStorage.setItem(key, JSON.stringify(data))
  },

  // Завершенные задания с XP
  getCompletedTasksXP(): Record<string, boolean> {
    const key = getUserStorageKey('completedTasksXP')
    return JSON.parse(localStorage.getItem(key) || '{}')
  },

  setCompletedTasksXP(data: Record<string, boolean>): void {
    const key = getUserStorageKey('completedTasksXP')
    localStorage.setItem(key, JSON.stringify(data))
  },

  // Очистка данных пользователя (при выходе)
  clearUserData(): void {
    const userId = getUserId()
    const keys = Object.keys(localStorage).filter(key => key.includes(`_user_${userId}`))
    keys.forEach(key => localStorage.removeItem(key))
  },

  // Миграция старых данных к новому формату
  migrateOldData(): void {
    const userId = getUserId()
    if (userId === 'anonymous') return

    // Мигрируем completedLessons
    const oldCompletedLessons = localStorage.getItem('completedLessons')
    if (oldCompletedLessons && !localStorage.getItem(getUserStorageKey('completedLessons'))) {
      localStorage.setItem(getUserStorageKey('completedLessons'), oldCompletedLessons)
      localStorage.removeItem('completedLessons')
    }

    // Мигрируем completedTasksXP
    const oldCompletedTasksXP = localStorage.getItem('completedTasksXP')
    if (oldCompletedTasksXP && !localStorage.getItem(getUserStorageKey('completedTasksXP'))) {
      localStorage.setItem(getUserStorageKey('completedTasksXP'), oldCompletedTasksXP)
      localStorage.removeItem('completedTasksXP')
    }
  }
} 