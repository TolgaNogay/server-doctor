#!/usr/bin/env bash

# WCR-Doctor Rapor ve Puanlama Modülü

generate_report() {
    print_header "Sunucu Sağlık Raporu ve Puanlama"
    print_progress 1
    
    local score=100
    
    # 1. RAM Kontrolü
    local total_ram=$(free -m | awk '/^Mem:/{print $2}')
    local used_ram=$(free -m | awk '/^Mem:/{print $3}')
    local ram_percent=0
    if [ "$total_ram" -gt 0 ]; then
        ram_percent=$((used_ram * 100 / total_ram))
    fi
    if [ "$ram_percent" -gt 90 ]; then
        score=$((score - 15))
    elif [ "$ram_percent" -gt 80 ]; then
        score=$((score - 5))
    fi
    
    # 2. Disk Kontrolü
    local disk_percent=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
    if [ "$disk_percent" -gt 90 ]; then
        score=$((score - 20))
    elif [ "$disk_percent" -gt 80 ]; then
        score=$((score - 10))
    fi
    
    # 3. CPU Yük Kontrolü
    local cores=$(nproc)
    local load1=$(cat /proc/loadavg | awk '{print $1}')
    # Bash ondalıklı sayılarla çalışamaz, bu yüzden basit bir string kontrolü yapıyoruz veya ondalığı atıyoruz
    local load_int=${load1%.*}
    if [ "$load_int" -ge "$cores" ]; then
        score=$((score - 10))
    fi
    
    # Puanın eksiye düşmemesi için
    if [ "$score" -lt 0 ]; then score=0; fi
    
    # Renk Belirleme
    local score_color=$GREEN
    local status_text="Mükemmel"
    
    if [ "$score" -lt 50 ]; then
        score_color=$RED
        status_text="Kritik Durumda - Acil Bakım Gerekli"
    elif [ "$score" -lt 80 ]; then
        score_color=$YELLOW
        status_text="Uyarı - İyileştirme Yapılabilir"
    fi
    
    # Raporu Bas
    print_boxed "GENEL SAĞLIK DURUMU" "$score_color"
    echo -e "${BOLD}Sunucu Puanı:${RESET} ${score_color}${score} / 100${RESET}"
    echo -e "${BOLD}Durum:${RESET}        ${status_text}"
    echo ""
    echo -e "${GRAY}* Puanlama; anlık CPU yükü, RAM ve Disk doluluğu üzerinden hesaplanmıştır.${RESET}"
    echo ""
}
