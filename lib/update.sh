#!/usr/bin/env bash

# WCR-Doctor Update Module

run_update() {
    print_header "WCR-Doctor Güncelleme / Update"
    echo -e "${GRAY}GitHub üzerinden en güncel versiyon kontrol ediliyor... / Checking for updates from GitHub...${RESET}"
    
    if [ -d "/opt/wcr-doctor/.git" ]; then
        cd "/opt/wcr-doctor" || exit
        git reset --hard HEAD >/dev/null 2>&1
        if git pull origin main | grep -q "Already up to date"; then
            echo -e "${GREEN}Zaten en güncel sürümü kullanıyorsunuz! / You are already using the latest version!${RESET}"
        else
            echo -e "${GREEN}Güncelleme tamamlandı! / Update completed!${RESET}"
            echo -e "${YELLOW}Lütfen 'wcr-doctor' yazarak aracı yeniden başlatın. / Please restart the tool by typing 'wcr-doctor'.${RESET}"
        fi
    else
        echo -e "${RED}Git deposu bulunamadı. Lütfen aracı baştan kurun: / Git repository not found. Please reinstall:${RESET}"
        echo -e "curl -fsSL https://nogay.tr/install.sh | sudo bash"
    fi
    exit 0
}
