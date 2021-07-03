#!/bin/bash
# # Este script faz parte do http://aurelio.net/shell/dialog
#
# Exemplo de como amarrar o script num menu principal usando o 'while'. O 'case' é usado para identificar qual foi a ação
# escolhida. Após cada ação, ele sempre retorna ao menu principal. Só sai do script caso escolha a última opção, aperte CANCELAR ou ESC.
#
# Útil para usar como login shell de pessoas inexperientes ou fazer utilitários de ações restritas e definidas.
#
# FLUXOGRAMA
#                      INÍCIO                    FIM
#                   +-----------+            +----------+
#          +------> |    menu   |--Esc-----> |  sai do  |
#          |        | principal |--Cancel--> | programa |
#          |        +-----Ok----+       +--> +----------+
#          |              |             |
#          +--<--1 2 3-4--+--Zero--->---+
#
sudo apt install -y dialog;
# Dados iniciais. Caminho completo
# Pasta do script webamin.sh
WEBADMIN=/home/ribafs/web-admin
DIRCAKE='/var/www/html/cake3'
DATABASE='adminbr_db'
USERNAME='root'
PASSWORD=''
SCRIPT='/home/ribafs/cake3-acl/db.sql'
ROUTES='/home/ribafs/cake3-acl/routes.php'
#
# Loop que mostra o menu principal
while : ; do

    # Mostra o menu na tela, com as ações disponíveis
    resposta=$(
      dialog --stdout               \
             --title 'Painel de Administração do Servidor'  \
             --menu 'Use as setas para escolher
ou os números, então tecle enter:' \
            0 0 0                   \
            1 'Instalar o CakePHP 3' \
            2 'Criar o banco de dados no MySQL'  \
            3 'Instalar o plugin admin-br no aplicativo criado'     \
            4 'Executar migrate e seeder e gerar o código'       \
            5 'Importar script SQL para o bancoc criado e finalizar'       \
            0 'Sair'                )

    # Ela apertou CANCELAR ou ESC, então vamos sair...
    [ $? -ne 0 ] && break

    # De acordo com a opção escolhida, dispara programas
    case "$resposta" in
         1) clear;
echo 'Aguarde enquanto eu cuido disso por você...';
echo '';
echo '';
echo '';
echo '';
composer create-project --prefer-dist cakephp/app:~3.0 $DIRCAKE;
# Corrigir o composer.json
sed -i '/postAutoloadDump/d' $DIRCAKE/composer.json;
sed -i 's/E_ALL/E_ALL \& ~E_NOTICE \& ~E_USER_DEPRECATED/g' $DIRCAKE/config/app.php;;
         2) dialog                                          \
   --title 'AVISO'                              \
   --yesno "\nO banco de dados ==$DATABASE== será criado.
            Caso exista será removido. Continuar?\n\n"    \
   0 0;
mysql -u$USERNAME -e "DROP DATABASE IF EXISTS $DATABASE;create database IF NOT EXISTS $DATABASE; GRANT ALL PRIVILEGES ON $DATABASE.* TO $USERNAME@localhost IDENTIFIED BY '$PASSWORD';FLUSH PRIVILEGES;";
mysql -u$USERNAME -e "USE $DATABASE;FLUSH PRIVILEGES;";
# Ajustes no config/app_local.php
# Ajuste do username
sed -i "0,/my_app/{s//$USERNAME/}" $DIRCAKE/config/app_local.php;
# Ajuste da senha
sed -i "s/secret/$PASSWORD/g" $DIRCAKE/config/app_local.php;
# Ajuste do nome do banco
sed -i "0,/my_app/{s//$DATABASE/}" $DIRCAKE/config/app_local.php;;
         3) echo 'Aguarde enquanto instalo o plugin admin-br...';
echo '';
echo '';
echo '';
echo '';
cd $DIRCAKE;
composer require ribafs/admin-br 
# Habilitar
cd $DIRCAKE;
bin/cake plugin load AdminBr --bootstrap;;
         4) # Executar composer update, migrate e seeders
cd $DIRCAKE;
composer dump-autoload -d vendor/ribafs/admin-br;
# Executar migrate e seeder
cd $DIRCAKE;
bin/cake migrations migrate -p AdminBr;
bin/cake migrations seed -p AdminBr;;
         5) # Importar script medbra
mysql -h localhost -u "$USERNAME" "$DATABASE" < "$SCRIPT";
         # Geração do Código e ajustando as permissões
cd $DIRCAKE;
bin/cake bake all groups -t AdminBr;
bin/cake bake all users -t AdminBr;
bin/cake bake all permissions -t AdminBr;
bin/cake bake all customers -t AdminBr;
bin/cake bake all especialidades -t AdminBr;
bin/cake bake all medicos -t AdminBr;
bin/cake bake all casos -t AdminBr;
bin/cake bake all docs_comproves -t AdminBr;
bin/cake bake all pacientes -t AdminBr;
bin/cake bake all propostas -t AdminBr;
bin/cake bake all verificacoes -t AdminBr;

# Configurar a rota login como a default
rm $DIRCAKE/config/routes.php;
cp $ROUTES $DIRCAKE/config
$DIRCAKE/perms;;

         0) break ;;
    esac

done

# Mensagem final :)
dialog --msgbox ''Concluído. Verifique acessando via navegador!'' 5 40

