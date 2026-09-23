#!/usr/bin/env bash
# --- CORES ---
R='\033[1;31m'
G='\033[1;32m'
Y='\033[1;33m'
C='\033[1;36m'
W='\033[1;37m'
DIM='\033[2m'
N='\033[0m'

set -euo pipefail

# ==============================================================================
# PROVISIONER DE VM
# ==============================================================================

banner_exec_demo() {
    # ==============================================================================
    # ## 1. Usando Parâmetros (O modo "Pro")
    # ==============================================================================
    # sudo bash provisioner.sh \
    #   --hostname "srvfake" \
    #   --user "safake" \
    #   --service "fake" \
    #   --pass "SenhaFake" \
    #   --domain-pub "dm.fake.com.br" \
    #   --domain-loc "dm.local" \
    #   --static \
    #   --interface "ens18" \
    #   --ip "10.0.17.0/24" \
    #   --gateway "10.0.17.254" \
    #   --dns1 "8.8.8.8" \
    #   --dns2 "1.0.0.1"
    # ==============================================================================
    # ==============================================================================
    # # 2. Copiar e Colar tudo (Heredoc)
    # ==============================================================================
    # sudo bash provisioner.sh <<EOF
    # srvfake
    # safake
    # fake
    # SenhaFake
    # SenhaFake
    # dm.fake.com.br
    # dm.local
    # s
    # ens18
    # 10.0.17.0/24
    # 10.0.17.254
    # 8.8.8.8
    # 1.0.0.1
    # s
    # EOF
    # ==============================================================================
    # ==============================================================================
    # 3. Uso no Cloud-Init (Cenário Profissional)
    # ==============================================================================
    # #cloud-config
    # runcmd:
    #   - curl -sSL https://seu-link.com/provisioner.sh -o /tmp/provisioner.sh
    #   - chmod +x /tmp/provisioner.sh
    #   - /tmp/provisioner.sh --hostname "srv-prod" --user "admin" --pass "SenhaForte123" --service "meu-app" --domain-pub "meu-site.com"
    #
    # Uso interativo : bash provisioner.sh
    # Uso automatizado: bash provisioner.sh --hostname srv-app-01 --user saagentai \
    #                    --service agentai --pass "S3nh@Forte" \
    #                    --domain-pub empresa.com.br --domain-loc casa.local \
    #                    [--static --interface eth0 --ip 192.168.1.100/24 \
    #                     --gateway 192.168.1.1 --dns1 8.8.8.8 --dns2 8.8.4.4]
    # ==============================================================================
    sleep 5
}


# ==============================================================================
# VERIFICAÇÃO ROOT
# ==============================================================================
if [ "$EUID" -ne 0 ]; then
    echo -e "${R}>>> ERRO: Execute como root!  (sudo -i)${N}"
    exit 1
fi

# ==============================================================================
# PARSE DE PARÂMETROS (automação)
# ==============================================================================
P_HOST="";     P_USER="";    P_SERVICE=""; P_PASS=""
P_DOM_PUB="";  P_DOM_LOC=""
P_STATIC="n";  P_IFACE="";   P_IP="";      P_GW=""
P_DNS1="";     P_DNS2=""

while [[ $# -gt 0 ]]; do
    case "$1" in
        --hostname)    P_HOST="$2";     shift 2 ;;
        --user)        P_USER="$2";     shift 2 ;;
        --service)     P_SERVICE="$2";  shift 2 ;;
        --pass)        P_PASS="$2";     shift 2 ;;
        --domain-pub)  P_DOM_PUB="$2";  shift 2 ;;
        --domain-loc)  P_DOM_LOC="$2";  shift 2 ;;
        --static)      P_STATIC="s";    shift 1 ;;
        --interface)   P_IFACE="$2";    shift 2 ;;
        --ip)          P_IP="$2";       shift 2 ;;
        --gateway)     P_GW="$2";       shift 2 ;;
        --dns1)        P_DNS1="$2";     shift 2 ;;
        --dns2)        P_DNS2="$2";     shift 2 ;;
        -h|--help)
            sed -n '3,9p' "$0" | sed 's/^# //'
            exit 0 ;;
        *)
            echo -e "${R}Parâmetro desconhecido: $1${N}"
            exit 1 ;;
    esac
done

# ==============================================================================
# FUNÇÕES AUXILIARES
# ==============================================================================

# Valida IP no formato x.x.x.x
_ip_valido() {
    local ip="$1"
    [[ "$ip" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]] || return 1
    IFS='.' read -ra p <<< "$ip"
    for o in "${p[@]}"; do [[ "$o" -le 255 ]] || return 1; done
    return 0
}

# Valida CIDR no formato x.x.x.x/nn
_cidr_valido() {
    local cidr="$1"
    [[ "$cidr" == *"/"* ]] || { echo -e "  ${R}Use o formato IP/prefixo — ex: 192.168.1.100/24${N}"; return 1; }
    local ip="${cidr%/*}" prefix="${cidr#*/}"
    _ip_valido "$ip"           || { echo -e "  ${R}IP inválido em '$cidr'${N}"; return 1; }
    [[ "$prefix" =~ ^[0-9]+$ ]] && [[ "$prefix" -ge 0 && "$prefix" -le 32 ]] \
        || { echo -e "  ${R}Prefixo deve ser entre 0 e 32 (ex: /24)${N}"; return 1; }
    return 0
}

# Converte prefixo CIDR → máscara dotted (para /etc/network/interfaces)
_cidr_para_mascara() {
    local prefix="$1"
    local mask=0; local full=$(( 0xFFFFFFFF << (32 - prefix) & 0xFFFFFFFF ))
    printf "%d.%d.%d.%d\n" \
        $(( (full >> 24) & 255 )) $(( (full >> 16) & 255 )) \
        $(( (full >>  8) & 255 )) $(( full & 255 ))
}

# Lista interfaces físicas (sem loopback, sem virtuais docker/veth)
_listar_ifaces() {
    ip -o link show \
        | awk -F': ' '{print $2}' \
        | grep -v -E '^(lo|docker|veth|br-|virbr)' \
        | sed 's/@.*//'
}

# Exibe tabela de interfaces com IP atual e estado
_mostrar_ifaces() {
    echo -e "  ${C}Interfaces de rede disponíveis:${N}"
    echo -e "  ${DIM}─────────────────────────────────────────────────────${N}"
    local i=1
    while IFS= read -r iface; do
        local ip_atual estado
        # O "|| true" evita que o script pare se o grep não encontrar IP
        ip_atual=$(ip -4 addr show dev "$iface" 2>/dev/null \
            | grep -oP '(?<=inet\s)\d+(\.\d+){3}/\d+' | head -1 || true)
        ip_atual="${ip_atual:-sem IP}"

        estado=$(ip link show "$iface" 2>/dev/null \
            | grep -oP '(?<=state )\w+' | head -1 || true)
        estado="${estado:-?}"

        # Cor por estado
        local cor_estado="$R"
        [[ "$estado" == "UP" ]] && cor_estado="$G"
        [[ "$estado" == "UNKNOWN" ]] && cor_estado="$Y"

        printf "  ${G}[%d]${N} %-14s  IP: %-22s  Estado: ${cor_estado}%s${N}\n" \
            "$i" "$iface" "$ip_atual" "$estado"
        ((i++))
    done < <(_listar_ifaces)
    echo -e "  ${DIM}─────────────────────────────────────────────────────${N}"
}

# Pede um campo com default, retorna na variável $RESP
# Uso: _perguntar "Prompt" "default" [validador]
_perguntar() {
    local prompt="$1" default="$2" validator="${3:-}"
    while true; do
        if [ -n "$default" ]; then
            printf "  %b [%b%s%b]: " "$prompt" "$G" "$default" "$N"
            read -r RESP
            RESP="${RESP:-$default}"
        else
            printf "  %b: " "$prompt"
            read -r RESP
        fi
        [ -z "$RESP" ] && { echo -e "  ${R}Campo obrigatório.${N}"; continue; }
        [ -n "$validator" ] && { $validator "$RESP" || continue; }
        return 0
    done
}

# Pede senha (sem eco)
_perguntar_senha() {
    while true; do
        printf "  Senha para root e %b%s%b: " "$G" "$USUARIO_NOVO" "$N"
        read -rs RESP; echo
        printf "  Confirme a senha: "
        read -rs RESP2; echo
        [ "$RESP" = "$RESP2" ] || { echo -e "  ${R}Senhas não conferem.${N}"; continue; }
        [ -n "$RESP" ]         || { echo -e "  ${R}Senha não pode ser vazia.${N}"; continue; }
        return 0
    done
}

# ==============================================================================
# COLETA DE INFORMAÇÕES (roda antes de qualquer alteração)
# ==============================================================================
coletar_informacoes() {

    # Variáveis globais preenchidas aqui
    HOSTNAME_NOVO="" USUARIO_NOVO="" SERVICE_HOSTED="" PASS_ROOT=""
    DOMINIO_PUBLICO="" DOMINIO_LOCAL=""
    STATIC_IP="n" NET_INTERFACE="" IP_ADDRESS="" GATEWAY=""
    DNS_PRIMARY="" DNS_SECONDARY=""

    while true; do
        clear
        echo -e "${C}"
        echo "  ╔══════════════════════════════════════════════════════╗"
        echo "  ║        PROVISIONER DE VM — CONFIGURAÇÃO INICIAL      ║"
        echo "  ╚══════════════════════════════════════════════════════╝"
        echo -e "${N}"

        # ── SERVIDOR ───────────────────────────────────────────────
        echo -e "  ${Y}▸ SERVIDOR${N}"

        if [ -n "$P_HOST" ]; then
            HOSTNAME_NOVO="$P_HOST"
            echo -e "  Hostname         : ${G}$HOSTNAME_NOVO${N}  ${DIM}(parâmetro)${N}"
        else
            _perguntar "Hostname  (ex: srv-app-01)" ""
            HOSTNAME_NOVO="$RESP"
        fi

        if [ -n "$P_USER" ]; then
            USUARIO_NOVO="$P_USER"
            echo -e "  Usuário          : ${G}$USUARIO_NOVO${N}  ${DIM}(parâmetro)${N}"
        else
            _perguntar "Usuário principal" "saagentai"
            USUARIO_NOVO="$RESP"
        fi

        if [ -n "$P_SERVICE" ]; then
            SERVICE_HOSTED="$P_SERVICE"
            echo -e "  Serviço/Pasta    : ${G}$SERVICE_HOSTED${N}  ${DIM}(parâmetro)${N}"
        else
            _perguntar "Nome do serviço  (pasta em /opt/projetos/)" "agentai"
            SERVICE_HOSTED="$RESP"
        fi

        if [ -n "$P_PASS" ]; then
            PASS_ROOT="$P_PASS"
            echo -e "  Senha            : ${G}(via parâmetro)${N}"
        else
            _perguntar_senha
            PASS_ROOT="$RESP"
        fi

        echo ""
        # ── DOMÍNIOS ───────────────────────────────────────────────
        echo -e "  ${Y}▸ DOMÍNIOS${N}"

        if [ -n "$P_DOM_PUB" ]; then
            DOMINIO_PUBLICO="$P_DOM_PUB"
            echo -e "  Domínio público  : ${G}$DOMINIO_PUBLICO${N}  ${DIM}(parâmetro)${N}"
        else
            _perguntar "Domínio público" "puzzlepunker.com.br"
            DOMINIO_PUBLICO="$RESP"
        fi

        if [ -n "$P_DOM_LOC" ]; then
            DOMINIO_LOCAL="$P_DOM_LOC"
            echo -e "  Domínio local    : ${G}$DOMINIO_LOCAL${N}  ${DIM}(parâmetro)${N}"
        else
            _perguntar "Domínio local" "casa.local"
            DOMINIO_LOCAL="$RESP"
        fi

        echo ""
        # ── REDE ───────────────────────────────────────────────────
        echo -e "  ${Y}▸ REDE${N}"
        _mostrar_ifaces
        echo ""

        if [[ "$P_STATIC" =~ ^[Ss]$ ]]; then
            STATIC_IP="s"
        else
            printf "  Configurar IP estático? (s/N): "
            read -r STATIC_IP
            STATIC_IP="${STATIC_IP:-n}"
        fi

        if [[ "$STATIC_IP" =~ ^[Ss]$ ]]; then

            # Seleção de interface
            mapfile -t IFACES < <(_listar_ifaces)
            if [ -n "$P_IFACE" ]; then
                NET_INTERFACE="$P_IFACE"
                echo -e "  Interface        : ${G}$NET_INTERFACE${N}  ${DIM}(parâmetro)${N}"
            elif [ "${#IFACES[@]}" -eq 1 ]; then
                NET_INTERFACE="${IFACES[0]}"
                echo -e "  Interface        : ${G}$NET_INTERFACE${N}  ${DIM}(única detectada)${N}"
            else
                while true; do
                    printf "  Interface — número ou nome: "
                    read -r SEL
                    if [[ "$SEL" =~ ^[0-9]+$ ]]; then
                        local idx=$(( SEL - 1 ))
                        if [[ "$idx" -ge 0 && "$idx" -lt "${#IFACES[@]}" ]]; then
                            NET_INTERFACE="${IFACES[$idx]}"; break
                        else
                            echo -e "  ${R}Número fora do intervalo (1-${#IFACES[@]}).${N}"
                        fi
                    elif ip link show "$SEL" &>/dev/null; then
                        NET_INTERFACE="$SEL"; break
                    else
                        echo -e "  ${R}Interface '$SEL' não encontrada.${N}"
                    fi
                done
            fi

            # IP / CIDR
            if [ -n "$P_IP" ]; then
                IP_ADDRESS="$P_IP"
                _cidr_valido "$IP_ADDRESS" || exit 1
                echo -e "  IP/máscara       : ${G}$IP_ADDRESS${N}  ${DIM}(parâmetro)${N}"
            else
                echo -e "  ${DIM}Formato aceito: IP/prefixo — ex: 192.168.1.100/24${N}"
                _perguntar "IP/máscara" "" _cidr_valido
                IP_ADDRESS="$RESP"
            fi

            # Gateway — sugere .1 da mesma rede
            local ip_host="${IP_ADDRESS%/*}"
            local net_base; net_base=$(echo "$ip_host" | cut -d. -f1-3)

            if [ -n "$P_GW" ]; then
                GATEWAY="$P_GW"
                echo -e "  Gateway          : ${G}$GATEWAY${N}  ${DIM}(parâmetro)${N}"
            else
                _perguntar "Gateway" "${net_base}.1" _ip_valido
                GATEWAY="$RESP"
            fi

            # DNS primário
            if [ -n "$P_DNS1" ]; then
                DNS_PRIMARY="$P_DNS1"
                echo -e "  DNS primário     : ${G}$DNS_PRIMARY${N}  ${DIM}(parâmetro)${N}"
            else
                _perguntar "DNS primário" "8.8.8.8" _ip_valido
                DNS_PRIMARY="$RESP"
            fi

            # DNS secundário (opcional)
            if [ -n "$P_DNS2" ]; then
                DNS_SECONDARY="$P_DNS2"
                echo -e "  DNS secundário   : ${G}$DNS_SECONDARY${N}  ${DIM}(parâmetro)${N}"
            else
                printf "  DNS secundário   [8.8.4.4] (Enter para pular): "
                read -r DNS_SECONDARY
                DNS_SECONDARY="${DNS_SECONDARY:-8.8.4.4}"
                if [ -n "$DNS_SECONDARY" ] && ! _ip_valido "$DNS_SECONDARY"; then
                    echo -e "  ${R}IP inválido — DNS secundário ignorado.${N}"
                    DNS_SECONDARY=""
                fi
            fi
        else
            echo -e "  ${DIM}Usando DHCP — sem alteração na rede.${N}"
            NET_INTERFACE=""; IP_ADDRESS=""; GATEWAY=""; DNS_PRIMARY=""; DNS_SECONDARY=""
        fi

        # ── RESUMO ─────────────────────────────────────────────────
        echo ""
        echo -e "  ${C}╔══════════════════════════════════════════════════════╗"
        echo -e "  ║                   RESUMO FINAL                       ║"
        echo -e "  ╠══════════════════════════════════════════════════════╣${N}"
        printf "  ${C}║${N}  %-18s ${G}%-32s${N} ${C}║${N}\n" "Hostname"        "$HOSTNAME_NOVO"
        printf "  ${C}║${N}  %-18s ${G}%-32s${N} ${C}║${N}\n" "Usuário"         "$USUARIO_NOVO"
        printf "  ${C}║${N}  %-18s ${G}%-32s${N} ${C}║${N}\n" "Serviço/Pasta"   "/opt/projetos/$SERVICE_HOSTED"
        printf "  ${C}║${N}  %-18s ${G}%-32s${N} ${C}║${N}\n" "Domínio público" "$DOMINIO_PUBLICO"
        printf "  ${C}║${N}  %-18s ${G}%-32s${N} ${C}║${N}\n" "Domínio local"   "$DOMINIO_LOCAL"
        if [[ "$STATIC_IP" =~ ^[Ss]$ ]]; then
            printf "  ${C}║${N}  %-18s ${G}%-32s${N} ${C}║${N}\n" "Interface"   "$NET_INTERFACE"
            printf "  ${C}║${N}  %-18s ${G}%-32s${N} ${C}║${N}\n" "IP/máscara"  "$IP_ADDRESS"
            printf "  ${C}║${N}  %-18s ${G}%-32s${N} ${C}║${N}\n" "Gateway"     "$GATEWAY"
            printf "  ${C}║${N}  %-18s ${G}%-32s${N} ${C}║${N}\n" "DNS"         "$DNS_PRIMARY ${DNS_SECONDARY}"
        else
            printf "  ${C}║${N}  %-18s ${Y}%-32s${N} ${C}║${N}\n" "Rede"        "DHCP (automático)"
        fi
        echo -e "  ${C}╚══════════════════════════════════════════════════════╝${N}"
        echo ""
        printf "  Confirmar e aplicar?  ${G}[s]${N} Aplicar  ${Y}[n]${N} Redigitar  ${R}[q]${N} Sair : "
        read -r CONFIRMA

        case "$CONFIRMA" in
            [Ss]) return 0 ;;
            [Qq]) echo -e "\n${Y}Abortado sem alterações.${N}"; exit 0 ;;
            *)    echo -e "\n${Y}Redigitando...${N}"; sleep 1 ;;
        esac
    done
}

# ==============================================================================
# PROVISIONAMENTO
# ==============================================================================

passo() { echo -e "\n${C}┌─ $1 ${N}"; }
ok()    { echo -e "${G}└─ OK${N}"; }

configura_vm() {
    passo "[1/6] USUÁRIOS E HOSTNAME"

    local USUARIO_ANTIGO
    USUARIO_ANTIGO=$(awk -F: '$3 == 1000 {print $1}' /etc/passwd)

    # Cria novo usuário se não existir
    if ! id "$USUARIO_NOVO" &>/dev/null; then
        adduser --disabled-password --gecos "" "$USUARIO_NOVO"
    fi
    echo "$USUARIO_NOVO:$PASS_ROOT" | chpasswd
    usermod -aG sudo "$USUARIO_NOVO"
    echo "root:$PASS_ROOT" | chpasswd

    # Hostname
    hostnamectl set-hostname "$HOSTNAME_NOVO"
    echo "$HOSTNAME_NOVO" > /etc/hostname

    # /etc/hosts — remove entradas antigas, adiciona nova
    local OLD_HOST
    OLD_HOST=$(hostname 2>/dev/null || true)
    sed -i "/127\.0\.1\.1/d" /etc/hosts
    [ -n "$OLD_HOST" ] && sed -i "/$OLD_HOST/d" /etc/hosts
    echo "127.0.1.1 $HOSTNAME_NOVO.$DOMINIO_PUBLICO $HOSTNAME_NOVO.$DOMINIO_LOCAL $HOSTNAME_NOVO" >> /etc/hosts

    # Remove usuário legado (uid 1000 diferente)
    if [ -n "$USUARIO_ANTIGO" ] && [ "$USUARIO_ANTIGO" != "$USUARIO_NOVO" ]; then
        echo "  Removendo usuário antigo: $USUARIO_ANTIGO"
        deluser --remove-home "$USUARIO_ANTIGO" > /dev/null 2>&1 || true
    fi
    ok
}

configura_rede_estatica() {
    if ! [[ "$STATIC_IP" =~ ^[Ss]$ ]]; then
        passo "[2/6] REDE via DHCP (sem alterações)"
        ok; return
    fi

    passo "[2/6] IP ESTÁTICO — $NET_INTERFACE: $IP_ADDRESS"

    if [ -d "/etc/netplan" ] && ls /etc/netplan/*.yaml &>/dev/null; then
        local NETPLAN_FILE
        NETPLAN_FILE=$(ls /etc/netplan/*.yaml | head -1)
        cp "$NETPLAN_FILE" "${NETPLAN_FILE}.bak.$(date +%s)"

        # gateway4 foi depreciado; usa routes
        cat > "$NETPLAN_FILE" <<EOF
network:
  version: 2
  renderer: networkd
  ethernets:
    $NET_INTERFACE:
      dhcp4: no
      addresses:
        - $IP_ADDRESS
      routes:
        - to: default
          via: $GATEWAY
      nameservers:
        addresses: [$DNS_PRIMARY${DNS_SECONDARY:+, $DNS_SECONDARY}]
EOF
        chmod 600 "$NETPLAN_FILE"
        netplan apply
        echo "  Configurado via NetPlan."

    elif [ -f "/etc/network/interfaces" ]; then
        local MASK PREFIX
        PREFIX="${IP_ADDRESS#*/}"
        MASK=$(_cidr_para_mascara "$PREFIX")
        cat >> /etc/network/interfaces <<EOF

# Estático — gerado pelo provisioner
auto $NET_INTERFACE
iface $NET_INTERFACE inet static
    address ${IP_ADDRESS%/*}
    netmask $MASK
    gateway $GATEWAY
    dns-nameservers $DNS_PRIMARY${DNS_SECONDARY:+ $DNS_SECONDARY}
EOF
        systemctl restart networking 2>/dev/null || \
            { ifdown "$NET_INTERFACE" 2>/dev/null; ifup "$NET_INTERFACE" 2>/dev/null; } || true
        echo "  Configurado via /etc/network/interfaces."
    else
        echo -e "  ${R}Nenhum sistema de rede suportado encontrado (netplan / interfaces).${N}"
    fi

    # resolv.conf como fallback
    cat > /etc/resolv.conf <<EOF
nameserver $DNS_PRIMARY
${DNS_SECONDARY:+nameserver $DNS_SECONDARY}
EOF
    ok
}

atualiza_sistema() {
    passo "[3/6] ATUALIZAÇÃO DO SISTEMA"
    export DEBIAN_FRONTEND=noninteractive
    apt-get update -q
    apt-get -y -q \
        -o Dpkg::Options::="--force-confdef" \
        -o Dpkg::Options::="--force-confold" \
        upgrade
    ok
}

instala_docker() {
    passo "[4/6] INSTALAÇÃO DO DOCKER"

    if command -v docker &>/dev/null; then
        echo "  Docker já instalado — pulando."
        ok; return
    fi

    export DEBIAN_FRONTEND=noninteractive
    apt-get install -y -q ca-certificates curl gnupg lsb-release

    mkdir -m 0755 -p /etc/apt/keyrings
    if [ ! -f /etc/apt/keyrings/docker.gpg ]; then
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
            | gpg --dearmor --yes -o /etc/apt/keyrings/docker.gpg
    fi

    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
        | tee /etc/apt/sources.list.d/docker.list > /dev/null

    apt-get update -q
    apt-get install -y -q \
        -o Dpkg::Options::="--force-confdef" \
        -o Dpkg::Options::="--force-confold" \
        docker-ce docker-ce-cli containerd.io \
        docker-buildx-plugin docker-compose-plugin

    systemctl enable --now docker
    usermod -aG docker "$USUARIO_NOVO"
    ok
}

configura_ambiente() {
    passo "[5/6] AMBIENTE E TIMEZONE"
    timedatectl set-timezone America/Sao_Paulo

    local CAMINHO="/opt/projetos/$SERVICE_HOSTED"
    mkdir -p "$CAMINHO"
    touch "$CAMINHO/deploy.sh"
    chmod +x "$CAMINHO/deploy.sh"
    chown -R "$USUARIO_NOVO":"$USUARIO_NOVO" /opt/projetos
    echo "  Criado: $CAMINHO"
    ok
}

configura_banner() {
    passo "[6/6] BANNER SSH E MOTD"

    # Desativa update-motd dinâmico
    chmod -x /etc/update-motd.d/* 2>/dev/null || true
    rm -f /run/motd.dynamic && touch /run/motd.dynamic

    cat > /etc/issue.net <<'EOF_BAN'
=============================================================================
          #     #     #     ######  #     #  #  #     #  #####    #
          #     #    # #    #     # ##    #  #  ##    # #     #   #
          #     #   #   #   #     # # #   #  #  # #   # #         #
          #  #  #  #     #  ######  #  #  #  #  #  #  # #  ####   #
          #  #  #  #######  #   #   #   # #  #  #   # # #     #   #
          #  #  #  #     #  #    #  #    ##  #  #    ## #     #
           ## ##   #     #  #     # #     #  #  #     #  #####    #
=============================================================================
EOF_BAN

    # Info de rede para o MOTD
    if [[ "$STATIC_IP" =~ ^[Ss]$ ]]; then
        IP_INFO="Estático: ${IP_ADDRESS%/*}  |  GW: $GATEWAY  |  DNS: $DNS_PRIMARY"
    else
        IP_INFO="DHCP: $(ip -4 addr show | grep -oP '(?<=inet\s)\d+(\.\d+){3}' \
            | grep -v 127.0.0.1 | head -1)"
    fi

    cat > /etc/motd <<EOF_MOTD
$(printf '\e[1;31m')
##############################################################################
#                   AVISO CRITICO DE SEGURANCA — LEIA AGORA                  #
##############################################################################
$(printf '\e[0m')$(printf '\e[1;33m')ATENCAO: Este sistema e de uso RESTRITO.$(printf '\e[0m')
$(printf '\e[0;33m')Toda atividade e registrada e monitorada.$(printf '\e[0m')
$(printf '\e[1;36m')======================= SYSTEM STATUS ===========================$(printf '\e[0m')
$(printf '\e[1;32m') [+] HOSTNAME   : $(printf '\e[0m')$HOSTNAME_NOVO
$(printf '\e[1;32m') [+] OS         : $(printf '\e[0m')$(grep PRETTY_NAME /etc/os-release | cut -d'"' -f2)
$(printf '\e[1;32m') [+] KERNEL     : $(printf '\e[0m')$(uname -r)
$(printf '\e[1;32m') [+] DATA       : $(printf '\e[0m')$(date '+%d/%m/%Y %H:%M:%S %Z')
$(printf '\e[1;32m') [+] REDE       : $(printf '\e[0m')$IP_INFO
$(printf '\e[1;32m') [+] DNS        : $(printf '\e[0m')$(grep nameserver /etc/resolv.conf 2>/dev/null | awk '{print $2}' | tr '\n' ' ')
$(printf '\e[1;32m') [+] PROJETO    : $(printf '\e[0m')/opt/projetos/$SERVICE_HOSTED
$(printf '\e[1;36m')=================================================================$(printf '\e[0m')
$(printf '\e[1;36m')==================== PARTITION STATUS ===========================$(printf '\e[0m')
$(printf '\e[1;32m') [+]$(printf '\e[0m')
$(lsblk)
$(printf '\e[1;36m')=================================================================$(printf '\e[0m')
$(printf '\e[1;31m') >>> VOCE ESTA SENDO VIGIADO. NAO FAÇA MERDA. <<< $(printf '\e[0m')
EOF_MOTD

    # SSH banner
    cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
    sed -i '/^Banner/d' /etc/ssh/sshd_config
    echo "Banner /etc/issue.net" >> /etc/ssh/sshd_config

    systemctl restart ssh 2>/dev/null || systemctl restart sshd 2>/dev/null || true
    ok
}

finaliza() {
    echo ""
    echo -e "${G}  ╔══════════════════════════════════════════════════════╗"
    echo -e "  ║       PROVISIONAMENTO CONCLUÍDO COM SUCESSO!         ║"
    echo -e "  ║                                                      ║"
    echo -e "  ║   Reiniciando em 5 segundos...                       ║"
    echo -e "  ╚══════════════════════════════════════════════════════╝${N}"
    echo ""
    # Remove o próprio script
    rm -f -- "$0" 2>/dev/null || true
    sleep 5
    reboot
}

# ==============================================================================
# FLUXO PRINCIPAL
# ==============================================================================
coletar_informacoes    # ← Tudo perguntado AQUI, antes de tocar em qualquer coisa

echo ""
echo -e "${Y}  ▸ INICIANDO PROVISIONAMENTO — NÃO DESLIGUE A MÁQUINA${N}"

banner_exec_demo
configura_vm
configura_rede_estatica
atualiza_sistema
instala_docker
configura_ambiente
configura_banner
finaliza

