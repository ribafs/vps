# Scripts para agilizar as tarefas rotineiras

Os que não requerem parâmetro uso um alias. Para os que precisam de parâmetro uso script com $1, $3, ...
# Scritps criadores de scripts
ubin
umod

debian10.sh
gs - Sincronizar repositório local com remoto, mas somente o branch master: cd pasta; gs 'Comentário'
gsa - Sincronizar repositório local com remoto do Arthur, mas somente o branch master: cd pasta;gsa 'Comentário'
l8 - instalar laravel 8 (lembrar que ele precisa estar sozinho no virtualhost): l8 nome
perms - ajusta as permissões de uma pasta em /var/www/html ou de toda a html
porta - mostrar uma das portas abertas: 80, 443 ou 65522: porta 80
recriardb - recriar um banco de dados: recriardb nome

Estes dois primeiros são para agilizar a criação dos demais.

## ubin
```bash 
sudo nano /usr/local/bin/ubin
sudo nano /usr/local/bin/$1
sudo chmod +x /usr/local/bin/ubin
```
## umod
```bash
sudo nano /usr/local/bin/umod
sudo chmod +x /usr/local/bin/$1
sudo chmod +x /usr/local/bin/umod
```
## Usando o ubin para criar o umod
```bash
ubin umod
```
## Usando o umod para setar o chmod +x no ubin
```bash
umod ubin
```
## l8
```bash
ubin l8
rm -rf $1
laravel new $1 --jet --stack=livewire
umod l8
```
## gs - git sincronização do desktop com o remoto
```bash
ubin gs

git add .
git commit -m "$1"
git pull
git push

umod gs
```
## Limpar cache da RAM

ubin m

free -m
sysctl -w vm.drop_caches=3
swapoff -a
swapon -a
free -m

umod m

