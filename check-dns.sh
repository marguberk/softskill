#!/bin/bash

echo "🔍 Мониторинг DNS пропагации для margulan.site..."
echo "Ожидаемый IP: 85.202.192.20"
echo ""

# Список DNS серверов для проверки
DNS_SERVERS=("8.8.8.8" "1.1.1.1" "208.67.222.222" "9.9.9.9")

for dns in "${DNS_SERVERS[@]}"; do
    echo "🌐 Проверяю DNS сервер: $dns"
    result=$(dig +short margulan.site @$dns 2>/dev/null)
    
    if [ -z "$result" ]; then
        echo "   ❌ Нет записи"
    elif [ "$result" = "85.202.192.20" ]; then
        echo "   ✅ Правильный IP: $result"
    else
        echo "   ⚠️  Неожиданный IP: $result"
    fi
done

echo ""
echo "🔧 Проверяю также через nslookup..."
nslookup margulan.site 2>/dev/null | grep -A1 "Name:" | tail -1 | grep "85.202.192.20" > /dev/null
if [ $? -eq 0 ]; then
    echo "✅ nslookup: DNS работает!"
else
    echo "❌ nslookup: DNS еще не пропагировался"
fi

echo ""
echo "⏰ DNS пропагация обычно занимает от 15 минут до 48 часов"
echo "📱 Можете проверить на https://dnschecker.org/" 