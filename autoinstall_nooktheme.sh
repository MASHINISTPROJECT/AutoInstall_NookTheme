#!/bin/bash
export LANG="ru_RU.UTF-8"

show_banner() {
    clear
    echo "=============================================="
    echo "  NookTheme Auto Installer"
    echo "  Автор: MASHINIST [YT]"
    echo "=============================================="
    echo "  Подпишись на Соц сети:"
    echo "  Ютуб: https://www.youtube.com/@MASHINIST_8888"
    echo "  Дискорд: https://discord.gg/BE8fEbJ9HJ"
    echo "=============================================="
    echo ""
}

install_nooktheme() {
    echo "Начинаем установку NookTheme..."
    echo ""
    
    sudo apt update
    sudo apt install -y software-properties-common
    sudo add-apt-repository ppa:ondrej/php -y
    sudo apt update
    sudo apt install -y php8.3
    php -v
    cd /var/www/pterodactyl && php artisan down
    curl -L https://github.com/Nookure/NookTheme/releases/latest/download/panel.tar.gz | tar -xzv
    chmod -R 755 storage/* bootstrap/cache
    composer install --no-dev --optimize-autoloader
    php artisan view:clear && php artisan config:clear
    php artisan migrate --seed --force
    chown -R www-data:www-data /var/www/pterodactyl/*
    php artisan queue:restart
    php artisan up
    
    echo ""
    echo "=============================================="
    echo "  Установка NookTheme успешно завершена!"
    echo "=============================================="
    echo ""
    read -p "Нажмите Enter для выхода..."
    exit 0
}

main_menu() {
    while true; do
        show_banner
        echo "1. Установить тему NookTheme"
        echo "2. Выход"
        echo ""
        read -p "Выберите пункт [1-2]: " choice
        
        case $choice in
            1)
                install_nooktheme
                ;;
            2)
                echo "Выход..."
                exit 0
                ;;
            *)
                echo "Неверный выбор. Попробуйте снова."
                sleep 2
                ;;
        esac
    done
}

# Запуск главного меню
main_menu