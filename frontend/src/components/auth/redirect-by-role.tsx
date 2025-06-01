import { Navigate } from "react-router-dom"
import { useAuthStore } from "../../stores/auth"

export function RedirectByRole() {
  const getHomeRoute = useAuthStore(state => state.getHomeRoute)
  
  return <Navigate to={getHomeRoute()} replace />
} 