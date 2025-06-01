import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom'
import { useEffect } from 'react'
import { Toaster } from './components/ui/toaster'
import { ProtectedRoute } from './components/auth/protected-route'
import { RoleGate } from './components/auth/role-gate'
import { RedirectByRole } from './components/auth/redirect-by-role'
import { StudentLayout } from './components/layout/student-layout'
import { AdminLayout } from './components/layout/admin-layout'
import { useAuthStore } from './stores/auth'

// Страницы авторизации
import LoginPage from './pages/auth/login'
import RegisterPage from './pages/auth/register'

// Страницы для студентов
import StudentDashboard from './pages/student/dashboard'
import LearningPage from './pages/student/learning'
import MaterialPage from './pages/student/material'
import StudentProgress from './pages/student/progress'
import StudentProfile from './pages/student/profile'
import CoursePage from './pages/student/course' // Добавляем этот импорт
import LessonPage from './pages/student/lesson'
import SkillsAssessment from './pages/student/skills-assessment'
import DailyTasksPage from './pages/student/daily-tasks'

// Страницы для админов
import AdminDashboard from './pages/admin/dashboard'
import MaterialsPage from './pages/admin/materials'
import MaterialEditor from './pages/admin/material-editor'
import UsersPage from './pages/admin/users'

function App() {
  const initializeAuth = useAuthStore(state => state.initializeAuth)

  useEffect(() => {
    // Инициализируем авторизацию при загрузке приложения
    initializeAuth()
  }, [initializeAuth])

  return (
    <>
      <Router>
        <Routes>
          {/* Публичные маршруты */}
          <Route path="/login" element={<LoginPage />} />
          <Route path="/register" element={<RegisterPage />} />

          {/* Маршруты для студентов */}
          <Route
            path="/dashboard"
            element={
              <ProtectedRoute>
                <RoleGate allowedRoles={["student"]}>
                  <StudentLayout>
                    <StudentDashboard />
                  </StudentLayout>
                </RoleGate>
              </ProtectedRoute>
            }
          />
          <Route
            path="/learning"
            element={
              <ProtectedRoute>
                <RoleGate allowedRoles={["student"]}>
                  <StudentLayout>
                    <LearningPage />
                  </StudentLayout>
                </RoleGate>
              </ProtectedRoute>
            }
          />
          <Route
            path="/learning/:id"
            element={
              <ProtectedRoute>
                <RoleGate allowedRoles={["student"]}>
                  <StudentLayout>
                    <MaterialPage />
                  </StudentLayout>
                </RoleGate>
              </ProtectedRoute>
            }
          />
          <Route
            path="/courses/:courseId"
            element={
              <ProtectedRoute>
                <RoleGate allowedRoles={["student"]}>
                  <StudentLayout>
                    <CoursePage />
                  </StudentLayout>
                </RoleGate>
              </ProtectedRoute>
            }
          />
          <Route
            path="/progress"
            element={
              <ProtectedRoute>
                <RoleGate allowedRoles={["student"]}>
                  <StudentLayout>
                    <StudentProgress />
                  </StudentLayout>
                </RoleGate>
              </ProtectedRoute>
            }
          />
          <Route
            path="/profile"
            element={
              <ProtectedRoute>
                <RoleGate allowedRoles={["student"]}>
                  <StudentLayout>
                    <StudentProfile />
                  </StudentLayout>
                </RoleGate>
              </ProtectedRoute>
            }
          />
          <Route
            path="/skills-assessment"
            element={
              <ProtectedRoute>
                <RoleGate allowedRoles={["student"]}>
                  <StudentLayout>
                    <SkillsAssessment />
                  </StudentLayout>
                </RoleGate>
              </ProtectedRoute>
            }
          />
          <Route
            path="/daily-tasks"
            element={
              <ProtectedRoute>
                <RoleGate allowedRoles={["student"]}>
                  <StudentLayout>
                    <DailyTasksPage />
                  </StudentLayout>
                </RoleGate>
              </ProtectedRoute>
            }
          />
          <Route
              path="/courses/:courseId/lessons/:lessonId"
              element={
                <ProtectedRoute>
                  <RoleGate allowedRoles={["student"]}>
                    <StudentLayout>
                      <LessonPage />
                    </StudentLayout>
                  </RoleGate>
                </ProtectedRoute>
              }
            />

          {/* Маршруты для админов */}
          <Route
            path="/admin"
            element={
              <ProtectedRoute>
                <RoleGate allowedRoles={["admin"]}>
                  <AdminLayout>
                    <AdminDashboard />
                  </AdminLayout>
                </RoleGate>
              </ProtectedRoute>
            }
          />
          <Route
            path="/admin/materials"
            element={
              <ProtectedRoute>
                <RoleGate allowedRoles={["admin"]}>
                  <AdminLayout>
                    <MaterialsPage />
                  </AdminLayout>
                </RoleGate>
              </ProtectedRoute>
            }
          />
          <Route
            path="/admin/materials/new"
            element={
              <ProtectedRoute>
                <RoleGate allowedRoles={["admin"]}>
                  <AdminLayout>
                    <MaterialEditor />
                  </AdminLayout>
                </RoleGate>
              </ProtectedRoute>
            }
          />
          <Route
            path="/admin/materials/:materialId/edit"
            element={
              <ProtectedRoute>
                <RoleGate allowedRoles={["admin"]}>
                  <AdminLayout>
                    <MaterialEditor />
                  </AdminLayout>
                </RoleGate>
              </ProtectedRoute>
            }
          />
          <Route
            path="/admin/users"
            element={
              <ProtectedRoute>
                <RoleGate allowedRoles={["admin"]}>
                  <AdminLayout>
                    <UsersPage />
                  </AdminLayout>
                  </RoleGate>
                </ProtectedRoute>
              }
            />

          {/* Редирект с корневого маршрута */}
          <Route path="/" element={<RedirectByRole />} />
        </Routes>
      </Router>
      <Toaster />
    </>
  )
}

export default App