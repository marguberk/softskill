import sqlite3
from passlib.context import CryptContext

# Настройка хеширования паролей
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

def create_password_hash(password: str) -> str:
    return pwd_context.hash(password)

def main():
    # Подключаемся к базе данных
    conn = sqlite3.connect('app.db')
    cursor = conn.cursor()
    
    # Удаляем старого пользователя если существует
    cursor.execute("DELETE FROM users WHERE email = ?", ("marguberk@gmail.com",))
    
    # Создаем хеш пароля
    password_hash = create_password_hash("password123")
    
    # Создаем нового пользователя
    cursor.execute("""
        INSERT INTO users (email, hashed_password, full_name, role, is_active)
        VALUES (?, ?, ?, ?, ?)
    """, ("marguberk@gmail.com", password_hash, "Маргулан Бекмырзаев", "student", True))
    
    conn.commit()
    conn.close()
    
    print("✅ Студент создан успешно!")
    print("📧 Email: marguberk@gmail.com")
    print("🔑 Пароль: password123")
    print("🎓 Роль: student")

if __name__ == "__main__":
    main() 