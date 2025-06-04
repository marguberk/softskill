#!/bin/bash

# Скрипт для настройки Ubuntu 24.04 LTS сервера для MaroAI
# Запустить с правами sudo

set -e

echo "🚀 Начинаем настройку сервера для MaroAI..."

# Обновление системы
echo "📦 Обновление системы..."
apt update && apt upgrade -y

# Установка базовых пакетов
echo "🔧 Установка базовых пакетов..."
apt install -y curl wget git htop nano ufw nginx software-properties-common

# Установка Node.js 18.x
echo "📦 Установка Node.js..."
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
apt install -y nodejs

# Установка Python 3.11
echo "🐍 Установка Python 3.11..."
apt install -y python3.11 python3.11-venv python3.11-dev python3-pip

# Установка PostgreSQL 15
echo "🗄️ Установка PostgreSQL..."
apt install -y postgresql postgresql-contrib

# Настройка firewall
echo "🔒 Настройка firewall..."
ufw --force enable
ufw allow 22
ufw allow 80
ufw allow 443
ufw allow 8002

# Создание пользователя для приложения
echo "👤 Создание пользователя maroai..."
useradd -m -s /bin/bash maroai
usermod -aG sudo maroai

# Создание директории для приложения
echo "📁 Создание директорий..."
mkdir -p /var/www/maroai
chown maroai:maroai /var/www/maroai

# Настройка PostgreSQL
echo "🗄️ Настройка PostgreSQL..."
sudo -u postgres createuser --createdb --pwprompt maroai
sudo -u postgres createdb maroai_db -O maroai

echo "✅ Базовая настройка сервера завершена!"
echo "📝 Следующие шаги:"
echo "1. Зайдите под пользователем maroai: sudo su - maroai"
echo "2. Перейдите в директорию: cd /var/www/maroai"
echo "3. Запустите скрипт развертывания приложения" 