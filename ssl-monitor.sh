#!/bin/bash

echo "🔍 Запускаю мониторинг DNS для получения SSL сертификата..."

# Функция для проверки DNS
check_dns_propagation() {
    local domain=$1
    local expected_ip=$2
    
    # Проверяем несколько DNS серверов
    local dns_servers=("8.8.8.8" "1.1.1.1" "208.67.222.222" "9.9.9.9")
    local success_count=0
    
    for dns_server in "${dns_servers[@]}"; do
        local result=$(dig +short $domain @$dns_server | grep "^$expected_ip$")
        if [ ! -z "$result" ]; then
            success_count=$((success_count + 1))
        fi
    done
    
    # Возвращаем true если хотя бы 2 из 4 серверов отвечают правильно
    [ $success_count -ge 2 ]
}

# Функция для получения SSL сертификата
get_ssl_certificate() {
    echo "🔒 Получаю SSL сертификат..."
    
    # Пробуем webroot метод
    sudo certbot certonly --webroot -w /var/www/html -d margulan.site -d www.margulan.site \
        --non-interactive --agree-tos --email admin@margulan.site
    
    if [ $? -eq 0 ]; then
        echo "✅ SSL сертификат успешно получен!"
        
        # Применяем SSL конфигурацию nginx
        sudo cp /home/ubuntu/MaroAI/nginx-maroai-ssl.conf /etc/nginx/sites-available/maroai
        sudo nginx -t && sudo systemctl reload nginx
        
        echo "🎉 HTTPS настроен! Сайт доступен по адресу:"
        echo "   https://margulan.site"
        echo "   https://www.margulan.site"
        
        return 0
    else
        echo "❌ Ошибка при получении SSL сертификата"
        return 1
    fi
}

# Основной цикл мониторинга
counter=0
max_attempts=240  # 20 минут (каждые 5 секунд)

echo "⏰ Мониторинг DNS пропагации для margulan.site..."
echo "📍 Ожидаемый IP: 85.202.192.20"
echo ""

while [ $counter -lt $max_attempts ]; do
    if check_dns_propagation "margulan.site" "85.202.192.20"; then
        echo ""
        echo "🎉 DNS пропагировался в достаточном количестве серверов!"
        echo "⏳ Жду еще 30 секунд для стабилизации..."
        sleep 30
        
        if get_ssl_certificate; then
            echo ""
            echo "✅ Настройка домена завершена успешно!"
            exit 0
        else
            echo "⚠️ SSL не удалось получить. Жду еще 60 секунд..."
            sleep 60
        fi
    else
        echo "⏳ DNS проверка $((counter + 1))/$max_attempts - еще не готово..."
        sleep 5
        counter=$((counter + 1))
    fi
done

echo ""
echo "⚠️ Превышено время ожидания DNS пропагации."
echo "🔧 Попробуйте позже вручную:"
echo "   sudo certbot --nginx -d margulan.site -d www.margulan.site"
echo ""
echo "📱 Проверить статус DNS: https://dnschecker.org/" 