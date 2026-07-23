#!/usr/bin/env bash

# WCR-Doctor Process Analysis Module

run_process_analysis() {
    print_header "${TXT_PROC_TITLE}"
    print_progress 1
    
    print_boxed "${TXT_PROC_CPU}" "$RED"
    # CPU usage top 5
    ps -eo pid,%cpu,%mem,user,cmd --sort=-%cpu | head -n 6
    
    echo ""
    
    print_boxed "${TXT_PROC_RAM}" "$YELLOW"
    # RAM usage top 5
    ps -eo pid,%cpu,%mem,user,cmd --sort=-%mem | head -n 6
    
    echo ""
}
