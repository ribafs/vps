#!/bin/bash
#
# Criado/adaptado por Ribamar FS - http://ribafs.me
# Script com tudo o necessário para a instalação do CMS Joomla 3 e do framework Laravel 8
sudo apt update;

# "Instalar pacotes básicos.";
apt install -y apache2 libapache2-mod-php7.3 git mcrypt curl composer mc;
a2enmod rewrite;
systemctl restart apache2;

apt install -y mariadb-server;

# "Instalar PHP 7.3 e extensões.";
apt install -y php7.3 php-cli php-imagick php-curl php-bz2 php-gd php-intl php-mysql php-zip php-apcu-bc php-apcu php-xml;
apt install -y php7.3-xsl php7.3-bcmath php7.3-mbstring php7.3-gettext;
apt install -y php-cli php-imagick php-curl php-bz2;

wget http://spout.ussg.indiana.edu/linux/ubuntu/pool/main/m/memcached/memcached_1.6.9+dfsg-1_amd64.deb;
dpkg -i memcached_1.6.9+dfsg-1_amd64.deb;
apt install -y php-memcache;
rm memcached_1.6.9+dfsg-1_amd64.deb;

curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
apt install -y nodejs

a2enmod rewrite;
systemctl restart apache2;

apt -y update;
apt -y upgrade;
