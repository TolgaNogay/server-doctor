#!/usr/bin/env bash

# WCR-Doctor Docker Analiz Modülü

run_docker_analysis() {
    print_header "Docker Analizi"
    
    if ! command_exists docker; then
        print_error "Docker sistemde yüklü değil veya bulunamadı!"
        return 1
    fi
    
    print_progress 1
    
    # Docker Bilgilerini Topla
    local docker_version=$(docker -v | awk '{print $3}' | tr -d ',')
    local running_containers=$(docker ps -q | wc -l)
    local all_containers=$(docker ps -a -q | wc -l)
    local stopped_containers=$((all_containers - running_containers))
    
    local image_count=$(docker images -q | wc -l)
    local volume_count=$(docker volume ls -q | wc -l)
    
    # Çıktı
    print_boxed "DOCKER ÖZETİ" "$BLUE"
    echo -e "${BOLD}Docker Sürümü:${RESET}       $docker_version"
    echo -e "${BOLD}Çalışan Container:${RESET}   ${GREEN}${running_containers}${RESET}"
    echo -e "${BOLD}Duran Container:${RESET}     ${YELLOW}${stopped_containers}${RESET}"
    echo -e "${BOLD}Toplam İmaj Sayısı:${RESET}  $image_count"
    echo -e "${BOLD}Toplam Volume Sayısı:${RESET} $volume_count"
    echo ""
    
    # Sistem Disk Kullanımı Özeti (docker system df)
    print_boxed "DOCKER DİSK KULLANIMI" "$CYAN"
    # Docker daemon ile haberleşme yetkisi sorunu olmaması için root kontrolü yararlı olabilir ama docker root olmadan da çalışıyorsa sorun yok.
    docker system df | grep -v "TYPE" | while read -r line; do
        type=$(echo "$line" | awk '{print $1}')
        total=$(echo "$line" | awk '{print $2}')
        active=$(echo "$line" | awk '{print $3}')
        size=$(echo "$line" | awk '{print $4 $5}')
        reclaimable=$(echo "$line" | awk '{print $6 $7}')
        
        echo -e "${BOLD}${type}:${RESET} ${size} (Geri Kazanılabilir: ${YELLOW}${reclaimable}${RESET})"
    done
    echo ""
}
