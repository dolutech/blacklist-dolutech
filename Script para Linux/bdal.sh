#!/bin/bash

# Nome do arquivo de blacklist local
LOCAL_BLACKLIST="/etc/bdal_blacklist.txt"

# URL da blacklist no GitHub (usar a URL raw)
BLACKLIST_URL="https://raw.githubusercontent.com/dolutech/blacklist-dolutech/main/Black-list-semanal-dolutech.txt"

# Nome da tabela e chain no nftables
NFT_TABLE="inet filter"
NFT_CHAIN="bdal_blacklist"

# Função para verificar se o script está sendo executado como root
check_root() {
    if [ "$EUID" -ne 0 ]; then
        echo "Este script precisa ser executado como root."
        exit 1
    fi
}

# Função para baixar a blacklist
download_blacklist() {
    echo "Baixando a blacklist de $BLACKLIST_URL..."
    curl -s -o "$LOCAL_BLACKLIST" "$BLACKLIST_URL"
    if [ $? -ne 0 ]; then
        echo "Erro ao baixar a blacklist."
        exit 1
    fi
    echo "Blacklist baixada com sucesso."
}

# Função para configurar o nftables
configure_nftables() {
    echo "Configurando nftables..."
    # Criar tabela e chain se não existirem
    nft list tables | grep -q "filter"
    if [ $? -ne 0 ]; then
        nft add table inet filter
    fi

    nft list chain inet filter | grep -q "$NFT_CHAIN"
    if [ $? -ne 0 ]; then
        nft add chain inet filter "$NFT_CHAIN" { type filter hook input priority 0 \; }
        nft add rule inet filter "$NFT_CHAIN" ip saddr { 0.0.0.0/0 } drop
    fi

    # Limpar regras existentes
    nft flush chain inet filter "$NFT_CHAIN"

    # Adicionar regras da blacklist
    while IFS= read -r ip; do
        # Ignorar linhas vazias e comentários
        [[ "$ip" =~ ^#.*$ || -z "$ip" ]] && continue
        nft add rule inet filter "$NFT_CHAIN" ip saddr "$ip" drop
    done < "$LOCAL_BLACKLIST"

    echo "nftables configurado com sucesso."
}

# Função para adicionar uma regra de blacklist personalizada
add_custom_ip() {
    read -p "Digite o IP que deseja adicionar à blacklist: " ip
    if ! [[ $ip =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
        echo "IP inválido."
        return
    fi
    echo "$ip" >> "$LOCAL_BLACKLIST"
    echo "IP $ip adicionado à blacklist local."
    configure_nftables
}

# Função para remover uma regra de blacklist personalizada
remove_custom_ip() {
    read -p "Digite o IP que deseja remover da blacklist: " ip
    if grep -Fxq "$ip" "$LOCAL_BLACKLIST"; then
        grep -vFx "$ip" "$LOCAL_BLACKLIST" > /tmp/bdal_blacklist.tmp
        mv /tmp/bdal_blacklist.tmp "$LOCAL_BLACKLIST"
        echo "IP $ip removido da blacklist local."
        configure_nftables
    else
        echo "IP $ip não encontrado na blacklist."
    fi
}

# Função para forçar a atualização da blacklist
force_update() {
    download_blacklist
    configure_nftables
}

# Função para configurar o cron job
configure_cron() {
    echo "Escolha o intervalo de atualização da blacklist:"
    echo "1) Diário"
    echo "2) A cada X horas"
    read -p "Opção [1-2]: " option

    cron_job=""

    if [ "$option" -eq 1 ]; then
        cron_job="0 2 * * * /bin/bash $(realpath $0) update"
    elif [ "$option" -eq 2 ]; then
        read -p "Digite o intervalo de horas: " hours
        if ! [[ "$hours" =~ ^[0-9]+$ ]]; then
            echo "Intervalo inválido."
            return
        fi
        cron_job="0 */$hours * * * /bin/bash $(realpath $0) update"
    else
        echo "Opção inválida."
        return
    fi

    # Remover cron job existente do script
    crontab -l | grep -v "$(realpath $0)" | crontab -

    # Adicionar novo cron job
    (crontab -l 2>/dev/null; echo "$cron_job") | crontab -

    echo "Cron job configurado: $cron_job"
}

# Função para exibir o menu
show_menu() {
    echo "-----------------------------------------"
    echo " Blacklist Dolutech Automatizada Linux (bdal.sh)"
    echo "-----------------------------------------"
    echo "1) Forçar atualização da Blacklist Dolutech"
    echo "2) Mudar o tempo de atualização da blacklist"
    echo "3) Adicionar um IP específico à blacklist"
    echo "4) Remover um IP específico da blacklist"
    echo "5) Sair"
    echo "-----------------------------------------"
}

# Função principal
main() {
    check_root

    if [ "$1" == "update" ]; then
        force_update
        exit 0
    fi

    while true; do
        show_menu
        read -p "Escolha uma opção [1-5]: " choice
        case $choice in
            1)
                force_update
                ;;
            2)
                configure_cron
                ;;
            3)
                add_custom_ip
                ;;
            4)
                remove_custom_ip
                ;;
            5)
                echo "Saindo..."
                exit 0
                ;;
            *)
                echo "Opção inválida."
                ;;
        esac
        echo ""
    done
}

# Executar a função principal
main "$@"
