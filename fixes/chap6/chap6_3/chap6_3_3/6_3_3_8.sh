#! /usr/bin/bash
source utils.sh
# 6.3.3.8 [REMEDIATION] Ensure events that modify user/group information are collected

{
    echo "[REMEDIATION] Ensuring events that modify user/group information are collected (6.3.3.8)..."

    rules=(
        "-w /etc/group -p wa -k identity" 
        "-w /etc/passwd -p wa -k identity" 
        "-w /etc/gshadow -p wa -k identity" 
        "-w /etc/shadow -p wa -k identity" 
        "-w /etc/security/opasswd -p wa -k identity" 
        "-w /etc/nsswitch.conf -p wa -k identity" 
        "-w /etc/pam.conf -p wa -k identity" 
        "-w /etc/pam.d -p wa -k identity"
    )
    newRule /etc/audit/rules.d/50-identity.rules "${rules[@]}"

    echo "Events that modify user/group information are now collected."
}