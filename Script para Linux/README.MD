
# Blacklist Dolutech Automatizada Linux (bdal.sh)

### Gerenciamento Automatizado de IPs Maliciosos com `nftables` e Atualização Diária

## Índice
- [Descrição](#descrição)
- [Funcionalidades](#funcionalidades)
- [Requisitos](#requisitos)
- [Instalação](#instalação)
- [Uso](#uso)
  - [Execução do Script](#execução-do-script)
  - [Menu Interativo](#menu-interativo)
- [Configuração de Regras do `nftables`](#configuração-de-regras-do-nftables)
- [Configuração de Atualização Automática com `cron`](#configuração-de-atualização-automática-com-cron)
- [Personalização](#personalização)
- [Contribuições](#contribuições)
- [Licença](#licença)
- [Contato](#contato)

## Descrição

O **Blacklist Dolutech Automatizada Linux (bdal.sh)** é um script shell desenvolvido para gerenciar e aplicar uma blacklist de IPs utilizando o `nftables`. Ele automatiza o download da blacklist fornecida pela [Dolutech Blacklist](https://github.com/dolutech/blacklist-dolutech/blob/main/Black-list-semanal-dolutech.txt) e permite a atualização periódica via `cron`. Além disso, oferece um menu interativo para adicionar ou remover IPs manualmente, e permite a personalização do tempo de atualização.

## Funcionalidades

- **Download Automático da Blacklist:** A lista é baixada do repositório da Dolutech e aplicada automaticamente no firewall `nftables`.
- **Configuração do `nftables`:** Regras de bloqueio são criadas para os IPs maliciosos listados.
- **Atualização Automática via `cron`:** Você pode configurar para atualizar a blacklist diariamente ou em intervalos personalizados.
- **Menu Interativo:** Gerenciamento de IPs e atualização da blacklist através de um menu simples e intuitivo.
- **Gerenciamento Manual de IPs:** Permite adicionar ou remover IPs específicos da blacklist conforme necessário.

## Requisitos

Antes de utilizar o `bdal.sh`, verifique se o seu sistema atende aos seguintes requisitos:

- **Sistema Operacional:** Linux (testado em distribuições baseadas em Debian/Ubuntu)
- **Permissões:** Acesso root (necessário para configurar o `nftables`)
- **Dependências:** 
  - `nftables`
  - `curl`
  - `cron`

## Instalação

### Passo 1: Instalar Dependências

Para instalar as dependências necessárias:

```bash
sudo apt update
sudo apt install -y nftables curl cron
```

### Passo 2: Download do Script

Clone este repositório ou baixe o script manualmente:

```bash
git clone https://github.com/seuusuario/bdal.sh.git
cd bdal.sh
```

### Passo 3: Torne o Script Executável

```bash
chmod +x bdal.sh
```

### Passo 4: (Opcional) Mover o Script para o PATH

Para facilitar a execução, mova o script para um diretório como `/usr/local/bin`:

```bash
sudo mv bdal.sh /usr/local/bin/bdal.sh
```

Agora você poderá executar o script de qualquer lugar utilizando `bdal.sh`.

## Uso

### Execução do Script

Para executar o script, utilize:

```bash
sudo ./bdal.sh
```

ou, se o script foi movido para `/usr/local/bin`:

```bash
sudo bdal.sh
```

### Menu Interativo

Após a execução, você verá um menu interativo como este:

```
-----------------------------------------
 Blacklist Dolutech Automatizada Linux (bdal.sh)
-----------------------------------------
1) Forçar atualização da Blacklist Dolutech
2) Mudar o tempo de atualização da blacklist
3) Adicionar um IP específico à blacklist
4) Remover um IP específico da blacklist
5) Sair
-----------------------------------------
Escolha uma opção [1-5]:
```

### Opções

1. **Forçar atualização da Blacklist Dolutech**: Baixa e aplica a lista mais recente de IPs maliciosos.
2. **Mudar o tempo de atualização da blacklist**: Permite configurar a frequência de atualização (diariamente ou a cada X horas).
3. **Adicionar um IP específico à blacklist**: Insira manualmente um IP para ser bloqueado.
4. **Remover um IP específico da blacklist**: Remova um IP específico da lista de bloqueio.
5. **Sair**: Fecha o menu.

## Configuração de Regras do `nftables`

O script configura automaticamente o `nftables` criando uma tabela e uma cadeia personalizadas para aplicar a blacklist. As regras são aplicadas na cadeia `bdal_blacklist`, que bloqueia os IPs listados.

### Persistência das Regras

Para garantir que as regras do `nftables` persistam após reinicializações, execute:

```bash
sudo nft list ruleset > /etc/nftables.conf
sudo systemctl enable nftables
```

Isso garantirá que o `nftables` carregue as regras ao iniciar.

## Configuração de Atualização Automática com `cron`

O script oferece a opção de configurar o `cron` para atualizar a blacklist automaticamente. Você pode definir a frequência como diária ou em intervalos específicos de horas.

### Configuração Manual do `cron`

Caso prefira configurar manualmente, edite o crontab:

```bash
sudo crontab -e
```

E adicione uma linha para agendar a atualização, como por exemplo:

```bash
0 2 * * * /bin/bash /caminho/para/bdal.sh update
```

Isso fará com que o script execute uma atualização diariamente às 2h da manhã.

## Personalização

Você pode personalizar alguns aspectos do script, como a URL de download da blacklist e o local onde a lista é armazenada localmente.

### URL da Blacklist

Por padrão, o script baixa a blacklist do seguinte URL:

```
https://raw.githubusercontent.com/dolutech/blacklist-dolutech/main/Black-list-semanal-dolutech.txt
```

Se quiser alterar a fonte, modifique a variável `BLACKLIST_URL` no script.

### Localização da Blacklist Local

A lista de IPs é armazenada por padrão em `/etc/bdal_blacklist.txt`. Para alterar este local, modifique a variável `LOCAL_BLACKLIST` no script.

## Contribuições

Contribuições são bem-vindas! Se desejar colaborar com este projeto, siga estas etapas:

1. **Fork o repositório**
2. **Crie uma nova branch para sua feature ou correção**: 

   ```bash
   git checkout -b minha-nova-feature
   ```

3. **Commit suas alterações**: 

   ```bash
   git commit -m "Descrição da nova feature"
   ```

4. **Faça o push para a branch**: 

   ```bash
   git push origin minha-nova-feature
   ```

5. **Abra um Pull Request**

## Licença

Este projeto está licenciado sob a [MIT License](LICENSE).

## Contato

Se você tiver alguma dúvida ou sugestão, sinta-se à vontade para abrir uma issue ou entrar em contato por e-mail: [lucas@dolutech.com](mailto:lucas@dolutech.com).
