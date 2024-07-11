#! /usr/bin/bash
source utils.sh
# 6.3.3.5 [REMEDIATION] Ensure events that modify the system's network environment are collected

{
    echo "[REMEDIATION] Ensuring events that modify the system's network environment are collected (6.3.3.5)..."

    rules=(
        "-a always,exit -F arch=b64 -S sethostname,setdomainname -k system-locale" 
        "-a always,exit -F arch=b32 -S sethostname,setdomainname -k system-locale" 
        "-w /etc/issue -p wa -k system-locale" 
        "-w /etc/issue.net -p wa -k system-locale" 
        "-w /etc/hosts -p wa -k system-locale" 
        "-w /etc/networks -p wa -k system-locale" 
        "-w /etc/network/ -p wa -k system-locale" 
        "-w /etc/netplan/ -p wa -k system-locale"
    )
    newRule /etc/audit/rules.d/50-system_locale.rules "${rules[@]}"

    echo "Events that modify the system's network environment are now collected."
}