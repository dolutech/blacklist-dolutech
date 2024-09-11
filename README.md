# Blacklist Semanal Contra Abuso

Este repositório contém uma blacklist de endereços IP maliciosos, bloqueados devido a tentativas de abuso, como ataques de força bruta, tentativas de login maliciosas, varreduras de vulnerabilidades e outras atividades suspeitas. A lista é atualizada diariamente para garantir a proteção contínua.

## 🚨 Objetivo

Nosso objetivo é fornecer uma lista atualizada de endereços IP que têm histórico de comportamento abusivo, ajudando desenvolvedores, administradores de sistemas e profissionais de segurança a proteger suas aplicações e redes contra ameaças.

## 🔄 Atualizações Diárias

A lista de IPs é revisada e atualizada diariamente, refletindo novos bloqueios e remoções de IPs que foram identificados como não mais maliciosos. Se você estiver utilizando esta lista, certifique-se de mantê-la sincronizada com o repositório para garantir que sua rede esteja protegida de ameaças emergentes.

## 📄 Formato da Blacklist

Os IPs bloqueados são listados no formato simples de texto, com um IP por linha:
0.0.0.0
0.0.0.0
0.0.0.0

### Formato de arquivo

O arquivo de blacklist principal está disponível em:
- **`blacklist.txt`**: Contém a lista completa de IPs bloqueados. Atualizado diariamente.

## 🚀 Como Usar

1. Clone este repositório:
    ```bash
    git clone https://github.com/dolutech/blacklist-dolutech.git
    ```

2. Acesse o diretório do repositório:
    ```bash
    cd blacklist-dolutech
    ```

3. Use o arquivo `Black-list-semanal-dolutech.txt` em sua aplicação ou servidor para bloquear os IPs maliciosos. Você pode aplicar a blacklist de várias maneiras, dependendo da sua configuração de firewall, servidor web ou IDS (Sistema de Detecção de Intrusões).

    Exemplo para bloquear IPs no **iptables** (Linux):
    ```bash
    while read ip; do
      sudo iptables -A INPUT -s $ip -j DROP
    done < Black-list-semanal-dolutech.txt
    ```

## ⚙️ Integração Automatizada

Para manter a blacklist sempre atualizada, você pode automatizar a atualização usando um cron job para sincronizar o repositório diariamente:

1. Adicione um cron job para rodar a cada dia:
    ```bash
    crontab -e
    ```

2. Adicione a seguinte linha para atualizar o repositório diariamente às 02:00:
    ```
    0 2 * * * cd /caminho/para/blacklist-dolutech && git pull
    ```

## 🤝 Contribuições

Se você identificar algum IP que acredita ser erroneamente incluído na lista, ou se você encontrar novos IPs abusivos, sinta-se à vontade para abrir uma [issue](https://github.com/seuusuario/blacklist-semanal/issues) ou enviar uma [pull request](https://github.com/seuusuario/blacklist-semanal/pulls) com a atualização.

## 📧 Contato

Para mais informações ou reportar abusos, entre em contato:
- **Email**: contato@dolutech.com
- **Website**: [Dolutech](https://dolutech.com)

## 🛡️ Licença

Este projeto é licenciado sob a **MIT License** - veja o arquivo [LICENSE](LICENSE) para mais detalhes.


