#!/bin/bash
#
# Criado/adaptado por Ribamar FS - http://ribafs.me
# Script com tudo o necessário para a instalação do CMS Joomla 3 e do framework Laravel 8
#
apt install dialog;
#
while :
 do
    clear
servico=$(dialog --stdout --backtitle 'Instalação de pacotes no Ubuntu Server 16.04 LTS - 64' \
                --menu 'Selecione a opção com a seta ou o número e tecle Enter\n' 0 0 0 \
                2 'Instalar LAMP e outros' \
                0 'Sair' )
    case $servico in
      2) clear;
apt update;
# "Instalar pacotes básicos.";
apt install -y apache2 libapache2-mod-php7.4 git mcrypt curl composer;

# "Instalar Apache e módulos.";

a2enmod rewrite;
systemctl restart apache2;

# Instalar SGBDs
apt install -y mariadb-server;

# "Instalar PHP 7.4 e extensões.";
apt install -y php7.4 php-cli php-imagick php-curl php-bz2 php-gd php-intl php-mysql php-zip php-apcu-bc php-apcu php-xml;
apt install -y php7.4-xsl php7.4-bcmath php7.4-mbstring php7.4-gettext;

wget http://spout.ussg.indiana.edu/linux/ubuntu/pool/main/m/memcached/memcached_1.6.6-3ubuntu1_amd64.deb;
dpkg -i memcached_1.6.6-3ubuntu1_amd64.deb;
apt install -y php-memcache;
rm memcached_1.6.6-3ubuntu1_amd64.deb;

a2enmod rewrite;
systemctl restart apache2;

apt install -y unzip;

# Ajustar relógio se em dual-boot
#timedatectl set-local-rtc 1 --adjust-system-clock;


# "Efetuar update e upgrade do Sistema. Geralmente é necessário reboot, nos casos em que o kernel seja atualizado";
apt -y update;
apt -y upgrade;;
      0) clear;exit;;
   esac
done
