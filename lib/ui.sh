#!/usr/bin/env bash

# WCR-Doctor Kullanıcı Arayüzü (UI) Modülü

# Renk Tanımlamaları
if [ -t 1 ]; then
    # Sleek dark mode / OpenCode style colors
    GREEN="\033[38;5;114m"   # Soft Green
    YELLOW="\033[38;5;179m"  # Soft Yellow/Gold
    RED="\033[38;5;167m"     # Soft Red
    BLUE="\033[38;5;111m"    # Soft Blue
    GRAY="\033[38;5;242m"    # Mid Gray
    CYAN="\033[38;5;73m"     # Soft Cyan
    BOLD="\033[1m"
    RESET="\033[0m"
else
    GREEN=""
    YELLOW=""
    RED=""
    BLUE=""
    GRAY=""
    CYAN=""
    BOLD=""
    RESET=""
fi

# ASCII Logo
print_logo() {
    clear
    echo -e "${CYAN}${BOLD}"
    cat << 'EOF'
   ▗▖ ▗▖ ▗▄▄▖▗▄▄▖      ▗▄▖ ▗▖  ▗▖▗▄▄▄▖
   ▐▌ ▐▌▐▌   ▐▌ ▐▌    ▐▌ ▐▌▐▛▚▖▐▌▐▌   
   ▐▌ ▐▌▐▌   ▐▛▀▚▖    ▐▌ ▐▌▐▌ ▝▜▌▐▛▀▀▘
   ▐▙█▟▌▝▚▄▄▖▐▌ ▐▌    ▝▚▄▞▘▐▌  ▐▌▐▙▄▄▖
EOF
    echo -e "${RESET}"
    echo -e "   ${BOLD}WCR-Doctor (v${VERSION:-1.0.0})${RESET}"
    echo -e "   ${GRAY}https://wcr.one${RESET}"
    echo ""
}

# Kutu Çizimi (Boxed Text)
print_boxed() {
    local text="$1"
    local color="${2:-$GREEN}"
    local padding=2
    local text_length=${#text}
    local box_width=$((text_length + padding * 2))

    local top_border="┌"
    local bottom_border="└"
    local empty_line="│"
    local i

    for ((i = 0; i < box_width; i++)); do
        top_border+="─"
        bottom_border+="─"
    done
    top_border+="┐"
    bottom_border+="┘"

    echo -e "${color}${top_border}"
    echo -e "│ ${RESET}${text}${color} │"
    echo -e "${bottom_border}${RESET}"
}

# Başlık Yazdırma
print_header() {
    echo -e "\n${BLUE}${BOLD}==> $1 ${RESET}\n"
}

# Başarı, Uyarı, Hata Mesajları
print_success() {
    echo -e "${GREEN}[✔] $1${RESET}"
}

print_warning() {
    echo -e "${YELLOW}[!] $1${RESET}"
}

print_error() {
    echo -e "${RED}[✖] $1${RESET}"
}

print_info() {
    echo -e "${CYAN}[i] $1${RESET}"
}

# Basit Progress Bar
print_progress() {
    local duration=$1
    local width=40
    local progress=0
    local step=$((duration * 10 / width))
    
    echo -n -e "${GRAY}İşleniyor: [${RESET}"
    for ((i = 0; i < width; i++)); do
        sleep "0.${step}"
        echo -n -e "${GREEN}#${RESET}"
    done
    echo -e "${GRAY}] Bitti!${RESET}"
}
