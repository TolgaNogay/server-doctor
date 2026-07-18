#!/usr/bin/env bash

# WCR-Doctor Çekirdek (Core) Modülü

# Root yetkisi gerektiren işlemlerde kontrol
check_root() {
    if [ "$EUID" -ne 0 ]; then
        print_error "Bu işlem root (sudo) yetkisi gerektirmektedir!"
        exit 1
    fi
}

# Komut varlığını kontrol etme
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# İnsan okuyabilir boyut hesaplama (Byte -> KB, MB, GB)
human_readable_size() {
    local bytes=$1
    if [[ $bytes -lt 1024 ]]; then
        echo "${bytes} B"
    elif [[ $bytes -lt 1048576 ]]; then
        echo "$((bytes / 1024)) KB"
    elif [[ $bytes -lt 1073741824 ]]; then
        echo "$((bytes / 1048576)) MB"
    else
        echo "$((bytes / 1073741824)) GB"
    fi
}

# Kullanıcıdan (E/h) onayı alma
ask_confirmation() {
    local prompt="$1"
    local default="${2:-Y}"
    local reply
    
    if [[ "$default" == "Y" || "$default" == "y" ]]; then
        prompt+=" [Y/n] "
    else
        prompt+=" [y/N] "
    fi
    
    echo -n -e "${YELLOW}${prompt}${RESET}"
    read -r reply
    
    if [[ -z "$reply" ]]; then
        reply=$default
    fi
    
    if [[ "$reply" =~ ^[Yy]$ ]]; then
        return 0
    else
        return 1
    fi
}
