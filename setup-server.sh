#!/bin/bash

echo "🚀 Начинаю финальную настройку MaroAI сервера..."

# 1. Настройка firewall
echo "📡 Настраиваю firewall..."
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw allow 8000/tcp
sudo ufw allow 3000/tcp
sudo ufw --force enable

# 2. Установка nginx
echo "🌐 Устанавливаю nginx..."
sudo apt update
sudo apt install -y nginx

# 3. Настройка nginx
echo "⚙️ Настраиваю nginx..."
sudo cp /home/ubuntu/MaroAI/nginx-maroai.conf /etc/nginx/sites-available/maroai
sudo ln -sf /etc/nginx/sites-available/maroai /etc/nginx/sites-enabled/
sudo rm -f /etc/nginx/sites-enabled/default
sudo nginx -t && sudo systemctl reload nginx

# 4. Создание frontend сервиса
echo "🖥️ Настраиваю frontend сервис..."
sudo cp /home/ubuntu/MaroAI/maroai-frontend.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable maroai-frontend.service
sudo systemctl start maroai-frontend.service

# 5. Проверка статуса сервисов
echo "✅ Проверяю статус сервисов..."
sudo systemctl status maroai-backend.service --no-pager
sudo systemctl status maroai-frontend.service --no-pager
sudo systemctl status nginx --no-pager

# 6. Открытие портов в системе
echo "🔓 Открываю порты..."
sudo iptables -I INPUT -p tcp --dport 80 -j ACCEPT
sudo iptables -I INPUT -p tcp --dport 443 -j ACCEPT
sudo iptables -I INPUT -p tcp --dport 8000 -j ACCEPT
sudo iptables -I INPUT -p tcp --dport 3000 -j ACCEPT

# Сохранение правил iptables
sudo netfilter-persistent save 2>/dev/null || echo "netfilter-persistent не установлен"

echo "🎉 Настройка завершена!"
echo ""
echo "📍 Ваше приложение доступно по адресам:"
echo "   Frontend: http://85.202.192.20"
echo "   Backend API: http://85.202.192.20/api"
echo "   Прямой доступ к API: http://85.202.192.20:8000"
echo ""
echo "🔧 Для проверки логов используйте:"
echo "   sudo journalctl -u maroai-backend.service -f"
echo "   sudo journalctl -u maroai-frontend.service -f"
echo "   sudo tail -f /var/log/nginx/maroai_error.log" 