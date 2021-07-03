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
                1 'Atualizar repositórios' \
                2 'Instalar Servidor Web e cia' \
                3 'Efetuar o Upgrade da distribuição' \
                0 'Sair' )
    case $servico in
      1) apt-get update;;
      2) clear;
echo "Instalar pacotes básicos. Tecle Enter para instalar!";
apt-get install -y aptitude unzip mc git;

clear;
echo "Instalar Apache e módulos. Tecle Enter para instalar!";
apt-get install -y nginx php7.0-fpm;
 
clear;
# Instalar SGBDs somente para testes locais. Visto que o servidor é outro: 10.0.0.60
apt-get install -y mysql-server;

clear;
echo "Instalar PHP 5 e extensões. Tecle Enter para instalar!";
apt-get install -y php7.0-bcmath php7.0 mcrypt mcrypt php7.0-mcrypt php7.0-mysqlnd php7.0 php7.0-gd php-pear curl php7.0-curl;
apt-get install -y php7.0-zip php-gettext php-auth php7.0-xml php7.0-xsl;

clear;
echo "Instalar suporte a cache no PHP. Tecle Enter para instalar!";
# Cache de php
apt-get -y install php-apcu;

wget http://ftp.ussg.iu.edu/linux/ubuntu/pool/main/m/memcached/memcached_1.4.25-2ubuntu1_amd64.deb;
dpkg -i -y memcached_1.4.25-2ubuntu1_amd64.deb;
apt-get -y install php-memcache;

echo "Configurar para suporte ao php no Nginx";
read n;

nano /etc/nginx/sites-available/default;
service nginx restart;

clear;;

	  3) clear;
echo "Efetuar update e upgrade do Sistema. Algumas vezes é necessário reboot";

apt-get -y update;
apt-get -y upgrade;;
      0) clear;exit;;
   esac
done
