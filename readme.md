> [!IMPORTANT]
>* Resolver /etc/secureboot
>* Backup /etc/key (copiar para ~/.config/sops/age)

# Bem Vindo!

Esta é minha configuração para o NixOS.

## Como usá-la?
*Atenção:* Esta não é uma configuração generalizada ou que se adapta ao seu sistema, é apenas disponibilizada para consulta e precisa ser adaptada para ser utilizada por terceiros.

Não há nada demais aqui, eu utilizo a estrutura padrão dos flakes, juntamente com os padrões vistos no [repositório nix-starter-configs](https://github.com/Misterio77/nix-starter-configs).

### Tenho alguma dúvida ou sugestão...
Sou um membro semi-ativo da comunidade Nix em geral, você pode me contatar por [e-mail](mailto:arthsmn@proton.me), Discord (estou nos servidores do [Vimjoyer](https://www.youtube.com/@vimjoyer) e do [IogaMaster](https://www.youtube.com/@IogaMaster)) e no [Manual do Usuário](https://manualdousuario.net/).


## Estrutura
* flake.nix, flake.lock
** Aqui declaro as dependências(inputs) e o que deve ser construído(output).
* nixos/
** Configuração principal do meu sistema. Por enquanto tenho somente uma máquina então esse repositório não tenta servir para diversos computadores.
** *Atenção:* Os arquivos tem muitas configurações pessoais, segredos e o hardware.nix é aquele gerado na instalação (específico da máquina). Se for utilizá-los saibam que modificações são necessárias.
* hosts/${hostname}/homeManager/
** Minha configuração da home. Apenas utilizo com um dos usuários da minha máquina, então não tenho necessidade de declarar casas para outros usuários.
** *Atenção:* Essas configurações tem algumas partes pessoais e segredos. Leia e modifique de acordo antes de utilizar.
* nixosModules|homeManagerModules/
** Meus módulos. Aqui é onde ficam as minhas funções especiais, que configuram partes do sistema que o NixOS/Home-Manager não configura ou que simplifica a declaração de alguma configuração.
* overlays/
** Aqui ficam minhas modificações de pacotes do nixpkgs que não foram levadas para o nixpkgs ou não podem. Também pode haver algum pacote com versão mais antiga caso seja necessário manter a versão.
* overlays/pkgs/
** Aqui encontram-se alguns pacotes que eu ainda não tentei levar para o nixpkgs ou que não podem entrar lá por algum motivo.
* hosts/secrets.yaml .sops.yaml
** Meus segredos. São partes da configuração que não podem ser disponibilizadas publicamente.
** *Atenção:* Se for utilizar os segredos, não esqueça de adaptar para a sua chave age/pgp e usar o seu arquivo de segredos.
