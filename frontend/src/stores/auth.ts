import { create } from 'zustand'

interface User {
  id: number
  email: string
  full_name: string
  role: string
}

interface AuthState {
  user: User | null
  token: string | null
  isAuthenticated: boolean
  setAuth: (user: User, token: string) => void
  clearAuth: () => void
  initializeAuth: () => void
  getHomeRoute: () => string
}

const getStoredToken = () => {
  return localStorage.getItem('token') || localStorage.getItem('access_token')
}

const getStoredUser = (): User | null => {
  try {
    const storedUser = localStorage.getItem('user')
    return storedUser ? JSON.parse(storedUser) : null
  } catch {
    return null
  }
}

export const useAuthStore = create<AuthState>((set, get) => ({
  user: null,
  token: null,
  isAuthenticated: false,
  setAuth: (user, token) => {
    localStorage.setItem('token', token)
    localStorage.setItem('user', JSON.stringify(user))
    localStorage.removeItem('access_token')
    set({ user, token, isAuthenticated: true })
  },
  clearAuth: () => {
    localStorage.removeItem('token')
    localStorage.removeItem('access_token')
    localStorage.removeItem('user')
    set({ user: null, token: null, isAuthenticated: false })
  },
  initializeAuth: () => {
    const token = getStoredToken()
    const user = getStoredUser()
    
    if (token && user) {
      set({ user, token, isAuthenticated: true })
    } else {
      // Если данные неполные, очищаем все
      get().clearAuth()
    }
  },
  getHomeRoute: () => {
    const { user } = get()
    if (!user) return '/login'
    return user.role === 'admin' ? '/admin' : '/dashboard'
  }
}))

// Инициализируем состояние при загрузке
useAuthStore.getState().initializeAuth()