#! /usr/bin/bash
source utils.sh
# 6.3.3.14 [REMEDIATION] Ensure events that modify the system's Mandatory Access Controls are collected

{
    echo "[REMEDIATION] Ensuring events that modify the system's Mandatory Access Controls are collected (6.3.3.14)..."

    rules=(
        "-w /etc/apparmor/ -p wa -k MAC-policy" 
        "-w /etc/apparmor.d/ -p wa -k MAC-policy" 
    )
    newRule /etc/audit/rules.d/50-MAC-policy.rules "${rules[@]}"

    echo "Events that modify the system's Mandatory Access Controls are now collected."
}