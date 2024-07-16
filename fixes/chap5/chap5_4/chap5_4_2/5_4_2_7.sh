#!/usr/bin/bash
source utils.sh
source globals.sh

{
    echo "[REMEDIATION] Ensure system accounts do not have a valid login shell (5.4.2.7)..."

    l_valid_shells="^($( awk -F\/ '$NF != "nologin" {print}' /etc/shells | sed -rn '/^\//{s,/,\\\\/,g;p}' | paste -s -d '|' - ))$" 
    awk -v pat="$l_valid_shells" -F: '($1!~/^(root|halt|sync|shutdown|nfsnobody)$/ && ($3<'"$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)"' || $3 == 65534) && $(NF) ~ pat) {system ("usermod -s '"$(command -v nologin)"' " $1)}' /etc/passwd 
    
    echo "Remediation successful."
}
