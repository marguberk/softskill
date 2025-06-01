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

const registerSchema = z.object({
  email: z
    .string()
    .email("Некорректный email адрес")
    .min(1, "Email обязателен"),
  fullName: z
    .string()
    .min(2, "ФИО должно содержать минимум 2 символа")
    .max(100, "ФИО слишком длинное")
    .regex(/^[а-яА-Яa-zA-Z\s-]+$/, "ФИО может содержать только буквы, пробелы и дефис"),
  password: z
    .string()
    .min(8, "Пароль должен содержать минимум 8 символов")
    .regex(/[A-Z]/, "Пароль должен содержать хотя бы одну заглавную букву")
    .regex(/[a-z]/, "Пароль должен содержать хотя бы одну строчную букву")
    .regex(/[0-9]/, "Пароль должен содержать хотя бы одну цифру"),
  passwordConfirm: z.string()
}).refine((data) => data.password === data.passwordConfirm, {
  message: "Пароли не совпадают",
  path: ["passwordConfirm"],
});

type RegisterForm = z.infer<typeof registerSchema>;

export default function RegisterPage() {
  const navigate = useNavigate()
  const [showPassword, setShowPassword] = useState(false)
  const [showPasswordConfirm, setShowPasswordConfirm] = useState(false)
  const setAuth = useAuthStore(state => state.setAuth)

  const {
    register,
    handleSubmit,
    formState: { errors, isSubmitting },
    setError
  } = useForm<RegisterForm>({
    resolver: zodResolver(registerSchema)
  });

  const onSubmit = async (data: RegisterForm) => {
      try {
        const response = await auth.register({
          email: data.email,
          password: data.password,
          full_name: data.fullName
        });
        setAuth(response.user, response.access_token);
        toast.success("Регистрация успешна!");
        navigate("/dashboard");
      } catch (error: any) {
        console.error("Полная ошибка:", error);

        if (error.response) {
          // Ошибка от сервера
          console.error("Ответ сервера:", error.response.data);
          toast.error(error.response.data.detail || "Ошибка на сервере");
        } else if (error.request) {
          // Ошибка сети
          toast.error("Не удалось подключиться к серверу. Проверьте подключение.");
        } else {
          // Другие ошибки
          toast.error(error.message || "Неизвестная ошибка");
        }
      }
    };

  return (
    <div className="min-h-screen flex items-center justify-center bg-background">
      <div className="w-full max-w-md space-y-8 p-8">
        <div className="text-center">
          <h2 className="text-2xl font-bold">Создание аккаунта</h2>
          <p className="text-sm text-muted-foreground">
            Заполните форму для регистрации
          </p>
        </div>

        <form onSubmit={handleSubmit(onSubmit)} className="space-y-6">
          <div className="space-y-2">
            <Label htmlFor="email">Электронная почта</Label>
            <Input
              {...register("email")}
              type="email"
              placeholder="example@mail.com"
              aria-invalid={!!errors.email}
            />
            {errors.email && (
              <p className="text-sm text-red-500">{errors.email.message}</p>
            )}
          </div>

          <div className="space-y-2">
            <Label htmlFor="fullName">ФИО</Label>
            <Input
              {...register("fullName")}
              placeholder="Иванов Иван"
              aria-invalid={!!errors.fullName}
            />
            {errors.fullName && (
              <p className="text-sm text-red-500">{errors.fullName.message}</p>
            )}
          </div>

          <div className="space-y-2">
            <Label htmlFor="password">Пароль</Label>
            <div className="relative">
              <Input
                {...register("password")}
                type={showPassword ? "text" : "password"}
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

          <div className="space-y-2">
            <Label htmlFor="passwordConfirm">Подтверждение пароля</Label>
            <div className="relative">
              <Input
                {...register("passwordConfirm")}
                type={showPasswordConfirm ? "text" : "password"}
                aria-invalid={!!errors.passwordConfirm}
              />
              <button
                type="button"
                onClick={() => setShowPasswordConfirm(!showPasswordConfirm)}
                className="absolute right-3 top-1/2 -translate-y-1/2 text-gray-500 hover:text-gray-700"
              >
                {showPasswordConfirm ? (
                  <EyeOff className="h-5 w-5" />
                ) : (
                  <Eye className="h-5 w-5" />
                )}
              </button>
            </div>
            {errors.passwordConfirm && (
              <p className="text-sm text-red-500">{errors.passwordConfirm.message}</p>
            )}
          </div>

          <Button
            type="submit"
            className="w-full bg-primary hover:bg-primary/90"
            disabled={isSubmitting}
          >
            {isSubmitting ? (
              <div className="flex items-center justify-center">
                <svg className="animate-spin -ml-1 mr-3 h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                  <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
                  <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                </svg>
                Регистрация...
              </div>
            ) : (
              "Зарегистрироваться"
            )}
          </Button>

          <div className="text-center text-sm">
            <a
              href="#"
              className="text-primary hover:text-primary/90"
              onClick={(e) => {
                e.preventDefault();
                navigate("/login");
              }}
            >
              Уже есть аккаунт? Войти
            </a>
          </div>
        </form>
      </div>
    </div>
  )
}