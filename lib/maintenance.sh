#!/usr/bin/env bash

# WCR-Doctor Güvenli Bakım Modülü

run_maintenance() {
    check_root
    
    print_header "Güvenli Bakım İşlemleri"
    
    print_warning "DİKKAT: Bu işlem sunucuda yer açmak için kullanılmayan kaynakları silecektir."
    print_info "- Çalışan containerlar silinmez."
    print_info "- Aktif veriler/volume'lar silinmez."
    print_info "- rm -rf / gibi tehlikeli komutlar kullanılmaz."
    echo ""
    
    if ! ask_confirmation "Bakıma başlamak istiyor musunuz?"; then
        echo -e "${YELLOW}İşlem iptal edildi.${RESET}"
        return 0
    fi
    
    # Öncesi disk kullanımını al (Kök dizin için /)
    local disk_before=$(df / | awk 'NR==2 {print $3}') # KB cinsinden
    
    # 1. APT Temizliği
    print_header "1. Paket (APT) Temizliği"
    if command_exists apt-get; then
        echo -e "${GRAY}Kullanılmayan paketler kaldırılıyor...${RESET}"
        apt-get autoremove -y -qq >/dev/null
        echo -e "${GRAY}Apt önbelleği temizleniyor...${RESET}"
        apt-get autoclean -y -qq >/dev/null
        print_success "APT temizliği tamamlandı."
    else
        print_info "Sistem APT desteklemiyor, atlanıyor."
    fi
    
    # 2. Journal Temizliği
    print_header "2. Systemd Journal Temizliği"
    if command_exists journalctl; then
        echo -e "${GRAY}Eski loglar temizleniyor (Son 7 gün bırakılıyor)...${RESET}"
        journalctl --vacuum-time=7d >/dev/null 2>&1
        print_success "Journal temizliği tamamlandı."
    else
        print_info "Systemd Journal bulunamadı, atlanıyor."
    fi
    
    # 3. Docker Temizliği
    print_header "3. Docker Temizliği"
    if command_exists docker; then
        echo -e "${GRAY}Kullanılmayan (dangling) imajlar siliniyor...${RESET}"
        docker image prune -a -f >/dev/null 2>&1
        
        echo -e "${GRAY}Kullanılmayan volume'lar siliniyor...${RESET}"
        docker volume prune -f >/dev/null 2>&1
        
        echo -e "${GRAY}Durdurulmuş container'lar siliniyor...${RESET}"
        docker container prune -f >/dev/null 2>&1
        
        echo -e "${GRAY}Docker build cache temizleniyor...${RESET}"
        docker builder prune -f >/dev/null 2>&1
        
        print_success "Docker temizliği tamamlandı."
    else
        print_info "Docker bulunamadı, atlanıyor."
    fi
    
    # Sonrası disk kullanımını al
    local disk_after=$(df / | awk 'NR==2 {print $3}') # KB cinsinden
    local saved_kb=$((disk_before - disk_after))
    
    echo ""
    print_boxed "BAKIM TAMAMLANDI" "$GREEN"
    
    if [ "$saved_kb" -gt 0 ]; then
        local saved_human=$(human_readable_size $((saved_kb * 1024)))
        echo -e "${BOLD}Kazanılan Disk Alanı:${RESET} ${GREEN}${saved_human}${RESET}"
    else
        echo -e "${BOLD}Kazanılan Disk Alanı:${RESET} Yok veya çok az."
    fi
    echo ""
}
