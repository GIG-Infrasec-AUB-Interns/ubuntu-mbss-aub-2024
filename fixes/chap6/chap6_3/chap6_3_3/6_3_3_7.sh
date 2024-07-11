#! /usr/bin/bash

# 6.3.3.7 [REMEDIATION] Ensure unsuccessful file access attempts are collected

{
    echo "[REMEDIATION] Ensuring unsuccessful file access attempts are collected (6.3.3.7)..."

    UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs) 
    rules=(
        "-a always,exit -F arch=b64 -S creat,open,openat,truncate,ftruncate -F exit=-EACCES -F auid>=${UID_MIN} -F auid!=unset -k access" 
        "-a always,exit -F arch=b64 -S creat,open,openat,truncate,ftruncate -F exit=-EPERM -F auid>=${UID_MIN} -F auid!=unset -k access" 
        "-a always,exit -F arch=b32 -S creat,open,openat,truncate,ftruncate -F exit=-EACCES -F auid>=${UID_MIN} -F auid!=unset -k access" 
        "-a always,exit -F arch=b32 -S creat,open,openat,truncate,ftruncate -F exit=-EPERM -F auid>=${UID_MIN} -F auid!=unset -k access"
    )
    [ -n "${UID_MIN}" ] && printf "${rules[@]}" >> /etc/audit/rules.d/50-access.rules || printf "ERROR: Variable 'UID_MIN' is unset.\n"

    augenrules --load
    if [[ $(auditctl -s | grep "enabled") =~ "2" ]]; then 
      printf "Reboot required to load rules\n"; 
    fi

    echo "Unsuccessful file access attempts are now collected."
}