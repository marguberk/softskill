#!/bin/bash

# Скрипт для развертывания MaroAI приложения
# Запускать от имени пользователя maroai

set -e

echo "🚀 Развертывание MaroAI приложения..."

# Переход в директорию приложения
cd /var/www/maroai

# Клонирование репозитория
echo "📥 Клонирование репозитория..."
git clone https://github.com/marguberk/softskill.git .

# Создание виртуального окружения Python
echo "🐍 Создание виртуального окружения..."
python3.11 -m venv venv
source venv/bin/activate

# Установка Python зависимостей
echo "📦 Установка Python зависимостей..."
pip install --upgrade pip
pip install -r requirements.txt

# Установка Node.js зависимостей
echo "📦 Установка Node.js зависимостей..."
cd frontend
npm install
npm run build
cd ..

# Создание .env файла
echo "⚙️ Создание конфигурации..."
cat > .env << EOL
# Database
DATABASE_URL=postgresql://maroai:ENTER_PASSWORD_HERE@localhost/maroai_db

# JWT
SECRET_KEY=your-secret-key-change-this-in-production
ALGORITHM=HS256
ACCESS_TOKEN_EXPIRE_MINUTES=30

# CORS
ALLOWED_ORIGINS=["http://localhost:3000", "http://localhost:5173", "http://85.202.192.20", "http://margulan.site"]

# Environment
ENVIRONMENT=production
EOL

echo "📝 ВАЖНО: Отредактируйте файл .env и укажите правильный пароль для базы данных!"

# Создание systemd сервиса для бэкенда
echo "🔧 Создание systemd сервиса..."
sudo tee /etc/systemd/system/maroai-backend.service > /dev/null << EOL
[Unit]
Description=MaroAI Backend
After=network.target

[Service]
Type=simple
User=maroai
WorkingDirectory=/var/www/maroai
Environment=PATH=/var/www/maroai/venv/bin
ExecStart=/var/www/maroai/venv/bin/uvicorn main:app --host 0.0.0.0 --port 8002
Restart=always

[Install]
WantedBy=multi-user.target
EOL

# Настройка Nginx
echo "🌐 Настройка Nginx..."
sudo tee /etc/nginx/sites-available/maroai << EOL
server {
    listen 80;
    server_name margulan.site 85.202.192.20;

    # Frontend
    location / {
        root /var/www/maroai/frontend/dist;
        try_files \$uri \$uri/ /index.html;
    }

    # Backend API
    location /api/ {
        proxy_pass http://127.0.0.1:8002;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }

    # Static files
    location /static/ {
        root /var/www/maroai;
    }
}
EOL

# Активация конфигурации Nginx
sudo ln -sf /etc/nginx/sites-available/maroai /etc/nginx/sites-enabled/
sudo rm -f /etc/nginx/sites-enabled/default
sudo nginx -t
sudo systemctl restart nginx

echo "✅ Развертывание завершено!"
echo ""
echo "📝 Следующие шаги:"
echo "1. Отредактируйте .env файл: nano .env"
echo "2. Настройте базу данных: python init_db.py"
echo "3. Запустите сервис: sudo systemctl enable maroai-backend && sudo systemctl start maroai-backend"
echo "4. Проверьте статус: sudo systemctl status maroai-backend"
echo ""
echo "🌐 Сайт будет доступен по адресу: http://margulan.site" 