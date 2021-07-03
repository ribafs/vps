#!/bin/bash
#
# Criado/adaptado por Ribamar FS - http://ribafs.org
apt update;
# "Instalar pacotes básicos.";
apt install -y apache2 libapache2-mod-php7.4 git mcrypt curl composer;

# "Instalar Apache e módulos.";

a2enmod rewrite;
systemctl restart apache2;

# Instalar SGBDs
apt install -y mariadb-server postgresql;

# "Instalar PHP 7.4 e extensões.";
apt install -y php7.4-xml php7.4-xsl php7.4-curl php7.4-xdebug php7.4-intl php7.4 php7.4-bcmath php7.4-mysql php7.4-pdo-pgsql;
apt install -y php7.4-zip php7.4-mbstring php7.4-gettext php7.4-gd php-curl php-pear;

# "Instalar suporte a cache no PHP.";
apt install -y php-apcu;

wget http://ftp.ussg.iu.edu/linux/debian/pool/main/m/memcached/memcached_1.5.6-1.1_amd64.deb;
dpkg -i memcached_1.5.6-1.1_amd64.deb;
apt install -f -y;
apt install -y php-memcache php-memcached;

systemctl restart apache2;
apt --fix-broken install;
apt autoremove;
