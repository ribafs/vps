== Criar um servidor com Alpine 13.3

Criar uma chave do SSH do seu desktop

cd ~/
ssh-keygen -t rsa -b 4096 -C "ribafs@gmail.com"

Aparecerá:
Generating public/private rsa key pair.
Enter file in which to save the key (/home/ribafs/.ssh/id_rsa):

Apenas tecle Enter para aceitar o path default

Então aparece:
Enter passphrase (empty for no passphrase):

Pode deixar vazio. Eu prefiro entrar com uma senha.

Então aparece para repetir:
Enter same passphrase again:

Agora precisamos copiar para a área de transferência da RAM o hash gerado para adicionar ao Linode. Para isso digite

cat ~/.ssh/id_rsa.pub

cat ~/.ssh/id_rsa.pub

Então aparece algo assim:

cat ~/.ssh/idt_rsa.pub
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDDLOX8r2GFHPB7sbwnA8LN4r4fou69063i21lmhZtaD/Z8FuiaEV8gp7TBU7vmR04A4NwEoQVRV0g7g9IBiK2fEm6i2TXI3oaWITBLKMGeWi2t0ispitR1f5OAlYLD8JQml599Tm70fHu3Z+ZVPOtSbY6sYPNn0CZfGaXjz0gnP4gc9TuaR+tgFXpbIku9uSdoWSKhlUh3sALW7y10VVDpESJ4sEcXxqJPEHD64kmHvwqBvTcYjyEPfsmVqUTC03JqUxYsHaY+bF0kjj08VMP0Z9EVTFBu/MvjNEd7dPwruUqd0U6mrpkKQLlfvv2FbaqKOPJ3p9NrkdG9jCFYSjcHKHCAeeI7q69q2axinh5bx2nOTO8hoo3HXr9e/YHVXSxssBPQ1xyuR/0uQw9fdnNfSru5VJeILazBkSK99EgbHGEtP2y9YudtuU4CUEvMhrSgfbWIEi60cmtBCj/D8254fASpCg74YSdm5pwdbKp1effDf0mGhNJeM1yfcPjgqNMVKljZ1fxxBlNaQhR/uIORK2TXXJTZWprQ7KzztflNAMp1HX8rfIq1r1NYL+L9+Rd5zMCREgSCu1cu2YpZzdZgMGFznMv9JOYVNixHtwt/9xIlb1Lk8AGnrdDtR49E73Dpgtygi+8yYb0hEJo81+oCDYo5wtyhfIMgFo1pTvp1pw== ribafs@gmail.com

Copie desde ssh-rsa até o seu email ao final, inclusive.

Efetuar login no Linode

https://login.linode.com/login

Acessar


