#!/usr/bin/env bash

# WCR-Doctor Analiz Modülü

run_analysis() {
    print_header "Sunucu Analizi"
    print_progress 2
    
    # Bilgileri topla
    local hostname=$(hostname)
    local os=$(cat /etc/os-release | grep -E '^PRETTY_NAME=' | cut -d '"' -f 2)
    local kernel=$(uname -r)
    local uptime=$(uptime -p | sed 's/up //')
    local cpu_model=$(awk -F: '/model name/ {print $2; exit}' /proc/cpuinfo | sed 's/^ *//')
    local cpu_cores=$(nproc)
    local load_avg=$(cat /proc/loadavg | awk '{print $1", "$2", "$3}')
    
    # RAM Bilgileri
    local total_ram=$(free -m | awk '/^Mem:/{print $2}')
    local used_ram=$(free -m | awk '/^Mem:/{print $3}')
    local ram_percent=$((used_ram * 100 / total_ram))
    
    # Swap Bilgileri
    local total_swap=$(free -m | awk '/^Swap:/{print $2}')
    local used_swap=$(free -m | awk '/^Swap:/{print $3}')
    local swap_percent=0
    if [ "$total_swap" -gt 0 ]; then
        swap_percent=$((used_swap * 100 / total_swap))
    fi
    
    # Disk (Kök dizin)
    local disk_total=$(df -h / | awk 'NR==2 {print $2}')
    local disk_used=$(df -h / | awk 'NR==2 {print $3}')
    local disk_percent=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
    
    # IP
    local ip_addr=$(hostname -I | awk '{print $1}')
    
    # Sonuçları Göster
    print_boxed "SİSTEM BİLGİLERİ" "$CYAN"
    echo -e "${BOLD}Hostname:${RESET}     $hostname"
    echo -e "${BOLD}İşletim Sistemi:${RESET} $os"
    echo -e "${BOLD}Kernel:${RESET}       $kernel"
    echo -e "${BOLD}IP Adresi:${RESET}    $ip_addr"
    echo -e "${BOLD}Uptime:${RESET}       $uptime"
    echo ""
    
    print_boxed "DONANIM ve KAYNAK KULLANIMI" "$YELLOW"
    echo -e "${BOLD}CPU Model:${RESET}    $cpu_model ($cpu_cores Çekirdek)"
    echo -e "${BOLD}Yük (Load):${RESET}   $load_avg"
    
    # RAM Renklendirme
    local ram_color=$GREEN
    if [ "$ram_percent" -gt 85 ]; then ram_color=$RED; elif [ "$ram_percent" -gt 70 ]; then ram_color=$YELLOW; fi
    echo -e "${BOLD}RAM Kullanımı:${RESET} ${ram_color}${used_ram}MB / ${total_ram}MB (%${ram_percent})${RESET}"
    
    # Disk Renklendirme
    local disk_color=$GREEN
    if [ "$disk_percent" -gt 85 ]; then disk_color=$RED; elif [ "$disk_percent" -gt 75 ]; then disk_color=$YELLOW; fi
    echo -e "${BOLD}Disk Kullanımı:${RESET} ${disk_color}${disk_used} / ${disk_total} (%${disk_percent})${RESET}"
    
    echo -e "${BOLD}Swap Kullanımı:${RESET} ${used_swap}MB / ${total_swap}MB (%${swap_percent})"
    echo ""

    # Kritik Servislerin Durumu
    print_boxed "KRİTİK SERVİS DURUMLARI" "$BLUE"
    local services=("nginx" "apache2" "mysql" "postgresql" "docker" "ssh")
    
    for svc in "${services[@]}"; do
        if systemctl list-unit-files "${svc}.service" >/dev/null 2>&1 || systemctl list-unit-files "${svc}.socket" >/dev/null 2>&1; then
            if systemctl is-active --quiet "$svc"; then
                echo -e "${BOLD}${svc}:${RESET} \t${GREEN}Aktif${RESET}"
            else
                echo -e "${BOLD}${svc}:${RESET} \t${RED}Pasif / Kapalı${RESET}"
            fi
        fi
    done
    echo ""
}
