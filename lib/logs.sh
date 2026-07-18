#!/usr/bin/env bash

# WCR-Doctor Log Analiz Modülü

run_logs_analysis() {
    check_root
    
    print_header "Log Analizi"
    print_progress 2
    
    print_boxed "SİSTEM LOGLARI (/var/log)" "$CYAN"
    echo -e "En büyük 5 log dosyası:\n"
    
    # En büyük 5 dosyayı bulur
    find /var/log -type f -exec du -h {} + 2>/dev/null | sort -rh | head -n 5 | while read -r size file; do
        echo -e "${YELLOW}${size}${RESET} \t $file"
    done
    echo ""
    
    print_boxed "SYSTEMD JOURNAL" "$BLUE"
    local journal_size=$(journalctl --disk-usage | awk '{print $7 $8}')
    echo -e "${BOLD}Journal Boyutu:${RESET} ${YELLOW}${journal_size}${RESET}"
    echo ""
}
