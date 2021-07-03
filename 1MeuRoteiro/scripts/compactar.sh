#!/bin/bash
#
# Criado/adaptado por Ribamar FS - http://ribafs.org
#
apt install -y dialog;
#
while :
 do
    clear
    servico=$(dialog --stdout --backtitle 'Compactar e Descompactar' \
                --menu 'Selecione a opção com a seta ou o número e tecle Enter\n' 0 0 0 \
                1 'Descompactar tar.gz' \
                2 'Descompactar zip' \
                0 'Sair' )
    case $servico in
      1) apt update;;
      2) clear;
# "Instalar pacotes básicos. Tecle Enter para instalar!";
apt install -y apache2 libapache2-mod-php7.4 aptitude git composer mc curl phpunit;

# Instalar SGBDs somente para testes locais. Visto que o servidor é outro: 10.0.0.60
# apt install -y mysql-server postgresql sqlite;
apt install -y mariadb-server postgresql sqlite3;

# "Instalar PHP 7 e extensões. Tecle Enter para instalar!";
# apt install -y php7.4 php7.4-bcmath php7.4-gd php7.4-mysql php7.4-pgsql php7.4-pdo-pgsql php7.4-sqlite php7.4-curl;
apt install -y php7.4 php7.4-bcmath php7.4-gd php7.4-mysql php7.4-pgsql php7.4-sqlite3 php7.4-curl;
apt install -y php-pear php7.4-xml php7.4-xsl php-xdebug php7.4-intl;
apt install -y php7.4-zip php7.4-mbstring php-gettext php7.4-fpm;
phpenmod mbstring;

# "Instalar suporte a cache no PHP. Tecle Enter para instalar!";
apt install -y php-apcu;

wget http://spout.ussg.indiana.edu/linux/ubuntu/pool/main/m/memcached/memcached_1.5.22-2ubuntu0.1_amd64.deb;
dpkg -i memcached_1.5.22-2ubuntu0.1_amd64.deb;
apt install -y php-memcache;

a2enmod rewrite;
systemctl restart apache2;

# Instalar outros softwares
apt install -y ttf-mscorefonts-installer fonts-crosextra-carlito fonts-crosextra-caladea vokoscreen;
apt install -y rar zip unzip p7zip-full ubuntu-restricted-extras kolourpaint;
add-apt-repository ppa:linuxuprising/shutter;
apt update;
apt install -y shutter;
#https://www.vivaolinux.com.br/dica/Instalando-o-Shutter-no-Linux-Mint-20-e-Ubuntu-2004
apt install shutter -y;
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
apt install -y nodejs;
apt autoremove -y;

# Ajustar relógio se em dual-boot
#timedatectl set-local-rtc 1 --adjust-system-clock;

apt update;
apt upgrade -y;;
      0) clear;exit;;
   esac
done
