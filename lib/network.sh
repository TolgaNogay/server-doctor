#!/usr/bin/env bash

# WCR-Doctor Ağ Analiz Modülü

run_network_analysis() {
    print_header "Ağ Analizi"
    print_progress 1
    
    local ip_addr=$(hostname -I | awk '{print $1}')
    local ext_ip=$(curl -s --max-time 3 https://api.ipify.org || echo "Bilinmiyor")
    local gateway=$(ip route | awk '/default/ {print $3}')
    local dns_servers=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}' | xargs)
    
    print_boxed "AĞ BİLGİLERİ" "$CYAN"
    echo -e "${BOLD}Yerel IP:${RESET}      $ip_addr"
    echo -e "${BOLD}Dış IP:${RESET}        $ext_ip"
    echo -e "${BOLD}Ağ Geçidi:${RESET}     $gateway"
    echo -e "${BOLD}DNS Sunucuları:${RESET} $dns_servers"
    echo ""
    
    print_boxed "BAĞLANTI TESTİ (Ping)" "$YELLOW"
    if ping -c 3 -W 2 1.1.1.1 >/dev/null 2>&1; then
        print_success "İnternet bağlantısı BAŞARILI (Cloudflare DNS'e erişilebiliyor)."
    else
        print_error "İnternet bağlantısı HATALI (1.1.1.1'e ulaşılamadı)."
    fi
    echo ""
}
