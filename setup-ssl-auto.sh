#!/bin/bash

echo "🔍 Ожидаю готовности DNS для SSL сертификата..."

# Функция проверки DNS
check_dns() {
    dig +short margulan.site @8.8.8.8 | grep -q "85.202.192.20"
}

# Ожидание DNS пропагации
counter=0
max_attempts=120  # 10 минут (каждые 5 секунд)

while [ $counter -lt $max_attempts ]; do
    if check_dns; then
        echo "✅ DNS пропагировался! Устанавливаю SSL сертификат..."
        
        # Установка SSL
        sudo certbot --nginx -d margulan.site -d www.margulan.site --non-interactive --agree-tos --email admin@margulan.site --redirect
        
        if [ $? -eq 0 ]; then
            echo "🎉 SSL сертификат успешно установлен!"
            echo "🌐 Сайт доступен: https://margulan.site"
            
            # Применяем SSL конфигурацию
            sudo cp /home/ubuntu/MaroAI/nginx-maroai-ssl.conf /etc/nginx/sites-available/maroai
            sudo nginx -t && sudo systemctl reload nginx
            
            echo "✅ SSL конфигурация применена!"
            break
        else
            echo "❌ Ошибка при установке SSL. Повторю через 30 секунд..."
            sleep 30
        fi
    else
        echo "⏳ DNS еще не готов. Проверяю через 5 секунд... ($counter/$max_attempts)"
        sleep 5
        counter=$((counter + 1))
    fi
done

if [ $counter -eq $max_attempts ]; then
    echo "⚠️ Превышено время ожидания DNS. Попробуйте позже вручную:"
    echo "sudo certbot --nginx -d margulan.site -d www.margulan.site"
fi 