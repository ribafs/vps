# apk search -v 'php8*' | sort
apk -U upgrade
# Pacotes básicos
apk add nano wget unzip bash git curl composer
# SGBD
#apk add postgresql mariadb sqlite
apk add mariadb
# Apache e PHP
apk add apache2 php8-apache2 php8 php8-pdo_mysql php8-cli php8-pear php8-pecl-apcu php8-pecl-mcrypt php8-pecl-memcached php8-iconv
apk add php8-bz2 php8-gettext php8-gd php8-intl php8-xml php8-zip php8-xml php8-bcmath php8-xsl php8-opcache php8-curl php8-pecl-redis
#apk add php-mysqlnd php-pgsql php-sqlite
apk add php8-mysqlnd

