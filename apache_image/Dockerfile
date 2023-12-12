# Используем базовый образ Ubuntu need to test FROM php:8.1-apache
FROM ubuntu:latest

# Обновляем индексы пакетов и устанавливаем необходимые пакеты
RUN apt-get update && \
    apt-get install -y apache2 php libapache2-mod-php php-fpm php-mysql && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN a2enmod php8.1

COPY ./www /var/www/html
COPY ./apache/000-default.conf:/etc/apache2/sites-available/000-default.conf
COPY ./apache/ports.conf:/etc/apache2/ports.conf

EXPOSE 8080

# Запускаем Apache в foreground режиме
CMD ["apache2ctl", "-D", "FOREGROUND"]
