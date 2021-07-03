Instalação

apt update && apt upgrade -y && reboot

Aguarde um pouco. Alguns segundos.

ssh root@159.89.102.244

adduser ribafs
usermod -aG sudo ribafs
mkdir /root/backup
cp /etc/ssh/sshd_config /root/backup

nano /etc/ssh/sshd_config

Port 65522
LoginGraceTime 30
PermitRootLogin yes
PasswordAuthentication no

Adicionar ao final
AllowUsers ribafs root

service ssh restart

Copiar a chave pública do SSH do meu desktop que está no root para o ribafs

rsync --archive --chown=ribafs:ribafs ~/.ssh /home/ribafs

Após toda a configuração mudar
PermitRootLogin no
E remover root do final

== Configurando o UFW

Como o ufw está limpo

ufw allow 65522
ufw allow http
ufw allow https
ufw allow 'Nginx HTTP'
ufw enable
ufw status verbose

ip addr show eth0 | grep inet | awk '{ print $3; }' | sed 's/\/.*$//'

Verificar o IP
curl -4 icanhazip.com

reboot

Acessar do desktop com ribafs
ssh -p 65522 ribafs@159.89.102.244

Criar script no desktop

sudo nano /usr/local/bin/docipi
ssh -p 65525 ribafs@159.89.102.244
sudo chmod +x /usr/local/bin/docipi

Instalar pacotes básicos
sudo apt install unzip mc aptitude

== Adicionar partição de swap com 2GB
Especialmente importante para quem tem pouca RAM

sudo su

dd if=/dev/zero of=/swapfile bs=1M count=2048
mkswap /swapfile
chmod 600 /swapfile
swapon /swapfile

nano /etc/fstab
/swapfile	swap	swap	defaults	0	0

Testar
free -m

== Criar script para limpar o cache da RAM

nano /usr/local/bin/m

sysctl -w vm.drop_caches=3
swapoff -a
swapon -a

chmod +x /usr/local/bin/m

Rodar como root

m

== Instalar o LEMP

apt-get -y install mariadb-server

mysql_secure_installation

apt-get install nginx

service nginx start

Teste
http://159.89.102.244


== Instalar php-fpm

php -v
7.4.3

apt-get -y install php7.4-fpm

cp /etc/nginx/sites-available/default /root/backup
nano /etc/nginx/sites-available/default


service nginx reload

cp /etc/php/7.4/fpm/php.ini /root/backup

nano /etc/php/7.4/fpm/php.ini

Mudar
;cgi.fix_pathinfo=1;
para
cgi.fix_pathinfo=0;

service php7.4-fpm reload

nano /var/www/html/info.php

<?php	
phpinfo();

http://159.89.102.244/info.php

Instalar php7.4

apt-get -y install php7.4-mysql php7.4-curl php7.4-gd php7.4-intl php-pear php-imagick php7.4-imap php-memcache php7.4-pspell php7.4-sqlite3 php7.4-tidy php7.4-xmlrpc php7.4-xsl php7.4-mbstring php7.4-pdo-pgsql

service php7.4-fpm reload

nano /etc/nginx/sites-available/default

Alterar
index index.html index.htm index.nginx-debian.html index.php

Descomente
        location ~ \.php$ {
                include snippets/fastcgi-php.conf;
        #
        #       # With php-fpm (or other unix sockets):
                fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;
        #       # With php-cgi (or other tcp sockets):
        #       fastcgi_pass 127.0.0.1:9000;
        }

        location ~ /\.ht {
                deny all;
        }

Checar configuração
sudo nginx -t

sudo systemctl reload nginx

Criar

nano /var/www/html/index.html

Contendo
<h1>Agora vou de nginx</h1>

Chame pelo navegador
http://159.89.102.244/

Testando PHP

nano /var/www/html/i.php

<?php
phpinfo()(;

http://159.89.102.244/i.php

Uma boa ideia
sudo rm /var/www/html/i.php


== MySQL/MariaDB

sudo mysql -uroot

CREATE DATABASE bd_exemplo;

drop database bd_exemplo;

create table ...

show databases

show tables

criar user

drop user

Criar script php com conexão com mysql

CREATE DATABASE bd_exemplo;
CREATE USER 'user_exemplo'@'localhost' IDENTIFIED BY 'senha';
GRANT ALL ON bd_exemplo.* TO 'user_exemplo'@'localhost';
\q

mysql -uuser_exemplo -psenha
SHOW DATABASES;
    CREATE TABLE bd_exemplo.lista (
        item_id INT AUTO_INCREMENT,
        conteudo VARCHAR(255),
        PRIMARY KEY(item_id)
    );
use bd_exemplo;
show tables;
INSERT INTO bd_exemplo.lista (conteudo) VALUES ("Meu item mais importante");
SELECT * FROM bd_exemplo.lista;
\q

nano /var/www/html/lista.php

<?php
$user = "user_exemplo";
$password = "senha";
$database = "bd_exemplo";
$table = "lista";

try {
  $db = new PDO("mysql:host=localhost;dbname=$database", $user, $password);
  echo "<h2>TODO</h2><ol>";
  foreach($db->query("SELECT conteudo FROM $table") as $row) {
    echo "<li>" . $row['conteudo'] . "</li>";
  }
  echo "</ol>";
} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}

http://159.89.102.244/lista.php

https://www.digitalocean.com/community/tutorials/how-to-install-linux-nginx-mysql-php-lemp-stack-on-ubuntu-20-04-pt

