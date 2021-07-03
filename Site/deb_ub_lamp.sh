#!/bin/bash
#
# Criado/adaptado por Ribamar FS - http://ribafs.org
#
apt-get install dialog;
#
while :
 do
    clear
servico=$(dialog --stdout --backtitle 'Instalação de pacotes no Ubuntu Server 16.04 LTS - 64' \
                --menu 'Selecione a opção com a seta ou o número e tecle Enter\n' 0 0 0 \
                2 'Instalar LAMP' \
                0 'Sair' )
    case $servico in
      2) clear;
apt-get update;
# "Instalar pacotes básicos. Tecle Enter para instalar!";
apt-get install -y aptitude unzip git;

apt-get install -y apache2 libapache2-mod-php7.0;
a2enmod rewrite;
a2enmod headers;
 
# Instalar SGBDs somente para testes locais. Visto que o servidor é outro: 10.0.0.60
apt -y install mariadb-server;
mysql_secure_installation;

echo "Instalar PHP 5 e extensões. Tecle Enter para instalar!";
apt-get install -y php7.0-bcmath php7.0 mcrypt mcrypt php7.0-mcrypt php7.0-mysqlnd php7.0 php7.0-gd php-pear curl php7.0-curl php7.0-mbstring;
apt-get install -y php7.0-zip php-gettext php7.0-fpm php-auth php7.0-xml php7.0-xsl;

# "Instalar suporte a cache no PHP. Tecle Enter para instalar!";
apt-get -y install php-apcu;

wget http://ftp.ussg.iu.edu/linux/ubuntu/pool/main/m/memcached/memcached_1.4.25-2ubuntu1_amd64.deb;
dpkg -i -y memcached_1.4.25-2ubuntu1_amd64.deb;
apt-get -y install php-memcache;

clear;
echo "Configurar .htaccess no Apache 2.4 trocando None por All
e /var/www por /backup/www.
Aperte ENTER para configurar.";
read n;

nano /etc/apache2/apache2.conf;

apt-get -y update;
apt-get -y upgrade;;
      0) clear;exit;;
   esac
done
