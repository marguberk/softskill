import { useState } from "react"
import { useNavigate } from "react-router-dom"
import { useForm } from "react-hook-form"
import { zodResolver } from "@hookform/resolvers/zod"
import * as z from "zod"
import { toast } from "sonner"
import { Button } from "../../components/ui/button"
import { Input } from "../../components/ui/input"
import { Label } from "../../components/ui/label"
import { Eye, EyeOff } from "lucide-react"
import { auth } from "../../lib/api"
import { useAuthStore } from "../../stores/auth"

const loginSchema = z.object({
  email: z.string().email("Некорректный email адрес"),
  password: z.string().min(1, "Введите пароль"),
});

type LoginForm = z.infer<typeof loginSchema>;

export default function LoginPage() {
  const navigate = useNavigate()
  const [showPassword, setShowPassword] = useState(false)
  const { setAuth, getHomeRoute } = useAuthStore()

  const {
    register,
    handleSubmit,
    formState: { errors, isSubmitting }
  } = useForm<LoginForm>({
    resolver: zodResolver(loginSchema)
  });

  const onSubmit = async (data: LoginForm) => {
    try {
      const formData = new URLSearchParams();
      formData.append('username', data.email);
      formData.append('password', data.password);

      const response = await fetch('http://127.0.0.1:8002/api/v1/auth/login', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: formData,
      });

      if (!response.ok) {
        const errorData = await response.json();
        throw new Error(errorData.detail || 'Ошибка входа');
      }

      const responseData = await response.json();

      // Сохраняем данные авторизации
      setAuth(responseData.user, responseData.access_token);

      toast.success("Успешный вход!");
      
      // Редиректим на домашнюю страницу в зависимости от роли
      navigate(getHomeRoute());
    } catch (error: any) {
      console.error("Login error:", error);
      toast.error(error.message || "Ошибка входа. Проверьте email и пароль.");
    }
  };

  return (
    <div className="min-h-screen flex items-center justify-center bg-background">
      <div className="w-full max-w-md space-y-8 p-8">
        <div className="text-center">
          <h2 className="text-2xl font-bold">Добро пожаловать</h2>
          <p className="text-sm text-muted-foreground">
            Войдите в свой аккаунт
          </p>
        </div>

        <form onSubmit={handleSubmit(onSubmit)} className="space-y-6">
          <div className="space-y-2">
            <Label htmlFor="email">Электронная почта</Label>
            <Input
              id="email"
              type="email"
              placeholder="example@mail.com"
              {...register("email")}
              aria-invalid={!!errors.email}
            />
            {errors.email && (
              <p className="text-sm text-red-500">{errors.email.message}</p>
            )}
          </div>

          <div className="space-y-2">
            <Label htmlFor="password">Пароль</Label>
            <div className="relative">
              <Input
                id="password"
                type={showPassword ? "text" : "password"}
                {...register("password")}
                aria-invalid={!!errors.password}
              />
              <button
                type="button"
                onClick={() => setShowPassword(!showPassword)}
                className="absolute right-3 top-1/2 -translate-y-1/2 text-gray-500 hover:text-gray-700"
              >
                {showPassword ? (
                  <EyeOff className="h-5 w-5" />
                ) : (
                  <Eye className="h-5 w-5" />
                )}
              </button>
            </div>
            {errors.password && (
              <p className="text-sm text-red-500">{errors.password.message}</p>
            )}
          </div>

          <Button
            type="submit"
            className="w-full"
            disabled={isSubmitting}
          >
            {isSubmitting ? (
              <div className="flex items-center justify-center">
                <svg className="animate-spin -ml-1 mr-3 h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                  <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
                  <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                </svg>
                Выполняется вход...
              </div>
            ) : (
              "Войти"
            )}
          </Button>

          <div className="flex justify-between text-sm">
            <a
              href="#"
              className="text-primary hover:text-primary/90"
              onClick={(e) => {
                e.preventDefault();
                navigate("/register");
              }}
            >
              Нет аккаунта? Зарегистрироваться
            </a>
            <a
              href="#"
              className="text-primary hover:text-primary/90"
              onClick={(e) => {
                e.preventDefault();
                navigate("/forgot-password");
              }}
            >
              Забыли пароль?
            </a>
          </div>
        </form>
      </div>
    </div>
  )
}