#!/usr/bin/bash
source utils.sh
source globals.sh

{
    echo "[REMEDIATION] Ensure accounts without a valid login shell are locked (5.4.2.8)..."

    l_valid_shells="^($(awk -F\/ '$NF != "nologin" {print}' /etc/shells | sed -rn '/^\//{s,/,\\\\/,g;p}' | paste -s -d '|' - ))$" 
    
    while IFS= read -r l_user; do 
        passwd -S "$l_user" | awk '$2 !~ /^L/ {system ("usermod -L " $1)}' 
    done < <(awk -v pat="$l_valid_shells" -F: '($1 != "root" && $(NF) !~ pat) {print $1}' /etc/passwd)     
    
    echo "Remediation successful."
}
