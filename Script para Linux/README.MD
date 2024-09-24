# Blacklist Dolutech Automatizada Linux (bdal.sh)

## Introdução

**Blacklist Dolutech Automatizada Linux (bdal.sh)** é uma ferramenta em shell script que automatiza o gerenciamento de uma blacklist de endereços IP utilizando o `nftables`. O script baixa uma lista de bloqueio de uma fonte externa, atualiza-a periodicamente via `cron`, e permite a gestão manual da lista através de um menu interativo. Esta ferramenta é ideal para administradores de sistemas que desejam proteger seus servidores contra IPs maliciosos de forma automatizada e flexível.

## Recursos

- **Download Automático da Blacklist:** Baixa a lista de IPs maliciosos a partir de um repositório no GitHub.
- **Configuração Automatizada do `nftables`:** Adiciona regras para bloquear os IPs listados.
- **Atualização Automática via `cron`:** Configura tarefas agendadas para atualizar a blacklist regularmente.
- **Menu Interativo:** Interface amigável para forçar atualizações, alterar intervalos de atualização, e gerenciar IPs específicos.
- **Gestão Manual de IPs:** Adicione ou remova IPs específicos da blacklist conforme necessário.

## Requisitos

Antes de usar o `bdal.sh`, certifique-se de que seu sistema atende aos seguintes requisitos:

- **Sistema Operacional:** Linux (Testado em distribuições baseadas em Debian/Ubuntu)
- **Permissões:** Acesso root ou sudo
- **Dependências:**
  - `nftables`
  - `curl`
  - `cron`

## Instalação

### Passo 1: Instale as Dependências

Execute os seguintes comandos para instalar as dependências necessárias:

```bash
sudo apt update
sudo apt install -y nftables curl cron
