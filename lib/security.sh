#!/usr/bin/env bash

# WCR-Doctor Güvenlik Analizi Modülü

run_security_analysis() {
    print_header "Güvenlik ve Firewall Analizi"
    print_progress 1
    
    # 1. UFW Kontrolü
    local ufw_status="Kurulu Değil"
    local ufw_color=$RED
    if command -v ufw >/dev/null 2>&1; then
        if sudo ufw status | grep -q "Status: active" || sudo ufw status | grep -q "Durum: etkin"; then
            ufw_status="Aktif"
            ufw_color=$GREEN
        else
            ufw_status="Pasif"
            ufw_color=$YELLOW
        fi
    fi

    # 2. Fail2Ban Kontrolü
    local f2b_status="Kurulu Değil"
    local f2b_color=$RED
    if command -v fail2ban-client >/dev/null 2>&1; then
        if systemctl is-active --quiet fail2ban; then
            f2b_status="Aktif"
            f2b_color=$GREEN
        else
            f2b_status="Pasif"
            f2b_color=$YELLOW
        fi
    fi

    # 3. SSH Root Login Kontrolü
    local ssh_root="Bilinmiyor"
    local ssh_color=$YELLOW
    if [ -f /etc/ssh/sshd_config ]; then
        # Sshd config might have PermitRootLogin commented out, which means default.
        if grep -q -E "^PermitRootLogin yes" /etc/ssh/sshd_config; then
            ssh_root="Açık (Riskli)"
            ssh_color=$RED
        elif grep -q -E "^PermitRootLogin no" /etc/ssh/sshd_config; then
            ssh_root="Kapalı (Güvenli)"
            ssh_color=$GREEN
        elif grep -q -E "^PermitRootLogin prohibit-password" /etc/ssh/sshd_config; then
            ssh_root="Sadece Anahtar (Güvenli)"
            ssh_color=$GREEN
        else
            ssh_root="Varsayılan"
            ssh_color=$YELLOW
        fi
    fi

    print_boxed "TEMEL GÜVENLİK DURUMU" "$CYAN"
    echo -e "${BOLD}Güvenlik Duvarı (UFW):${RESET} ${ufw_color}${ufw_status}${RESET}"
    echo -e "${BOLD}Fail2Ban Koruması:${RESET}     ${f2b_color}${f2b_status}${RESET}"
    echo -e "${BOLD}SSH Root Erişimi:${RESET}      ${ssh_color}${ssh_root}${RESET}"
    echo ""
}
