#!/bin/bash

echo "🚀 Начинаю полную настройку MaroAI сервера с SSL..."

# 1. Настройка firewall
echo "📡 Настраиваю firewall..."
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw allow 8000/tcp
sudo ufw allow 3000/tcp
sudo ufw --force enable

# 2. Установка nginx и certbot
echo "🌐 Устанавливаю nginx и certbot..."
sudo apt update
sudo apt install -y nginx certbot python3-certbot-nginx

# 3. Создание базовой HTML страницы для проверки
echo "📄 Создаю базовую HTML страницу..."
sudo mkdir -p /var/www/html
echo "<!DOCTYPE html>
<html>
<head>
    <title>MaroAI Learning Platform</title>
    <meta charset='utf-8'>
</head>
<body>
    <h1>🎓 MaroAI Learning Platform</h1>
    <p>Система обучения готовится к запуску...</p>
    <p>Домен: margulan.site</p>
    <p>IP: 85.202.192.20</p>
</body>
</html>" | sudo tee /var/www/html/index.html

# 4. Настройка временного nginx для получения сертификата
echo "⚙️ Настраиваю временный nginx..."
sudo cp /home/ubuntu/MaroAI/nginx-maroai.conf /etc/nginx/sites-available/maroai-temp
sudo ln -sf /etc/nginx/sites-available/maroai-temp /etc/nginx/sites-enabled/
sudo rm -f /etc/nginx/sites-enabled/default
sudo nginx -t && sudo systemctl reload nginx

# 5. Получение SSL сертификата
echo "🔒 Получаю SSL сертификат от Let's Encrypt..."
sudo certbot --nginx -d margulan.site -d www.margulan.site --non-interactive --agree-tos --email admin@margulan.site --redirect

# 6. Настройка финальной конфигурации nginx с SSL
echo "🔧 Настраиваю финальную конфигурацию nginx с SSL..."
sudo cp /home/ubuntu/MaroAI/nginx-maroai-ssl.conf /etc/nginx/sites-available/maroai
sudo ln -sf /etc/nginx/sites-available/maroai /etc/nginx/sites-enabled/
sudo rm -f /etc/nginx/sites-enabled/maroai-temp
sudo nginx -t && sudo systemctl reload nginx

# 7. Создание frontend сервиса
echo "🖥️ Настраиваю frontend сервис..."
sudo cp /home/ubuntu/MaroAI/maroai-frontend.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable maroai-frontend.service
sudo systemctl start maroai-frontend.service

# 8. Настройка автообновления сертификатов
echo "🔄 Настраиваю автообновление SSL сертификатов..."
sudo systemctl enable certbot.timer
sudo systemctl start certbot.timer

# 9. Проверка статуса сервисов
echo "✅ Проверяю статус сервисов..."
sudo systemctl status maroai-backend.service --no-pager
sudo systemctl status maroai-frontend.service --no-pager
sudo systemctl status nginx --no-pager

# 10. Дополнительные правила iptables
echo "🔓 Открываю порты в системе..."
sudo iptables -I INPUT -p tcp --dport 80 -j ACCEPT
sudo iptables -I INPUT -p tcp --dport 443 -j ACCEPT
sudo iptables -I INPUT -p tcp --dport 8000 -j ACCEPT
sudo iptables -I INPUT -p tcp --dport 3000 -j ACCEPT

# Сохранение правил iptables
sudo netfilter-persistent save 2>/dev/null || echo "netfilter-persistent не установлен"

# 11. Тестирование SSL
echo "🧪 Тестирую SSL соединение..."
sleep 5
curl -I https://margulan.site 2>/dev/null | head -5 || echo "SSL пока недоступен (DNS может еще не обновиться)"

echo ""
echo "🎉 Полная настройка завершена!"
echo ""
echo "📍 Ваше приложение доступно по адресам:"
echo "   🌐 Основной сайт: https://margulan.site"
echo "   🌐 Альтернативный: https://www.margulan.site"
echo "   🔗 Backend API: https://margulan.site/api"
echo "   🔗 Прямой IP: http://85.202.192.20"
echo ""
echo "🔒 SSL сертификат установлен и будет автоматически обновляться"
echo ""
echo "🔧 Для проверки логов используйте:"
echo "   sudo journalctl -u maroai-backend.service -f"
echo "   sudo journalctl -u maroai-frontend.service -f"
echo "   sudo tail -f /var/log/nginx/maroai_error.log"
echo "   sudo certbot certificates" 