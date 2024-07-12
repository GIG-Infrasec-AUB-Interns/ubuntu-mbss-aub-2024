#! /usr/bin/bash
source utils.sh
# 6.3.3.12 [REMEDIATION] Ensure login and logout events are collected

{
    echo "[REMEDIATION] Ensuring login and logout events are collected (6.3.3.12)..."

    rules=(
        "-w /var/log/lastlog -p wa -k logins" 
        "-w /var/run/faillock -p wa -k logins" 
    )
    newRule /etc/audit/rules.d/50-login.rules "${rules[@]}"

    echo "Login and logout events are now collected."
}