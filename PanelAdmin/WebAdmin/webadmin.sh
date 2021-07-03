#!/bin/sh
# Instalador do web admin
# Dados iniciais. Caminho completo
clear
echo ''
echo ''
echo ''
echo '=========== Instalando o CakePHP 3 com o plugin admin-br  ==========='
echo ''
echo ''
echo 'Irei instalar com tudo default. Caso queira customizar tecle Ctrl+C e edite este script. Apenas tecle enter para instalar com os defaults'
read n
DIRCAKE='/backup/www/medbra'
DATABASE='medbra_db'
# Como é somente para uso local, usarei o root sem senha para a criação do banco. O user abaixo é o do cake
USERNAME='medbra_us'
PASSWORD='zmxn1029M@'
SCRIPT='/home/ribafs/web-admin/db.sql'
ROUTES='/home/ribafs/web-admin/routes.php'
TITLE='Medbra'
echo ''
echo ''
echo 'Aguarde enquanto eu cuido disso por você...'
echo ''
echo ''
echo ''
# Instalação do cakephp 3
composer create-project --prefer-dist cakephp/app:~3.0 $DIRCAKE

sed -i '/postAutoloadDump/d' $DIRCAKE/composer.json
sed -i 's/E_ALL/E_ALL \& ~E_NOTICE \& ~E_USER_DEPRECATED/g' $DIRCAKE/config/app.php
echo ''
echo ''
echo ''
echo ''

echo 'Não se preocupe com a mensagem de erro em vermelho. Cuidarei dela como recomendado.'
echo "O banco $DATABASE será removido. Apenas tecle enter para continuar ou Ctrl+C caro queira preservá-lo"
read n
echo ''
echo ''
echo ''
echo ''

mysql -uroot -e "DROP DATABASE IF EXISTS $DATABASE;create database IF NOT EXISTS $DATABASE;FLUSH PRIVILEGES;"
mysql -uroot -e "USE $DATABASE;FLUSH PRIVILEGES;"

# Ajuste do username no config/app_local.php
sed -i "0,/my_app/{s//$USERNAME/}" $DIRCAKE/config/app_local.php

# Ajuste da senha
sed -i "s/secret/$PASSWORD/g" $DIRCAKE/config/app_local.php

# Ajuste do nome do banco
sed -i "0,/my_app/{s//$DATABASE/}" $DIRCAKE/config/app_local.php

# Desabilitar avisos de derpecated. Efetuar manualmente
# sed -i "0,/E_ALL/{s/E_ALL & ~E_USER_DEPRECATED/}" $DIRCAKE/config/app.php

# Instalar o plugin admin-br
cd $DIRCAKE
composer require ribafs/admin-br

# Habilitar
cd $DIRCAKE
bin/cake plugin load AdminBr --bootstrap

# Título do aplicativo
sed -i 's/"Título do Aplicativo"/$TITLE/g' $DIRCAKE/src/Controller/AppController.php

# Executar composer update
cd $DIRCAKE
composer dump-autoload -d vendor/ribafs/admin-br

# Executar migrate e seeder
cd $DIRCAKE
bin/cake migrations migrate -p AdminBr
bin/cake migrations seed -p AdminBr

# Importar script medbra
mysql -uroot "$DATABASE" < "$SCRIPT"

# Geração do Código com o bake

cd $DIRCAKE
bin/cake bake all groups -t AdminBr -f
bin/cake bake all users -t AdminBr -f
bin/cake bake all permissions -t AdminBr -f
bin/cake bake all documentos -t AdminBr -f
bin/cake bake all especialidades -t AdminBr -f
bin/cake bake all medicos_especialidades -t AdminBr -f
bin/cake bake all medicos -t AdminBr -f
bin/cake bake all casos -t AdminBr -f
bin/cake bake all pacientes -t AdminBr -f
bin/cake bake all propostas -t AdminBr -f
bin/cake bake all verificacoes -t AdminBr -f

# Configurar a rota login como a default
rm $DIRCAKE/config/routes.php
cp $ROUTES $DIRCAKE/config

# Ajustar permissões
echo ''
echo ''
echo ''
echo "Aguarde enquanto ajusto as permissões do $DIRCAKE"
echo ''
echo ''
echo ''
sudo find $DIRCAKE -type d -exec chmod 755 {} \;
sudo find $DIRCAKE -type d -exec chmod ug+s {} \;
sudo find $DIRCAKE -type f -exec chmod 664 {} \;
sudo chown -R www-data:www-data $DIRCAKE
echo ''
echo ''
echo ''
echo 'Aguarde enquanto ajusto as permissões. Precisará entrar com a senha do sudo'
echo ''
echo ''
echo ''
echo 'Finalizei. Agora você pode acessar pelo navegador.'
echo 'Exemplo: http://localhost/cake3'
echo 'Ajuste as permissões do /var/www/html/cake3'

