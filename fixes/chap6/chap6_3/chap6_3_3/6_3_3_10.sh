#! /usr/bin/bash

# 6.3.3.10 [REMEDIATION] Ensure successful file system mounts are collected

{
    echo "[REMEDIATION] Ensuring successful file system mounts are collected (6.3.3.10)..."

    UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
    rules=(
        "-a always,exit -F arch=b32 -S mount -F auid>=$UID_MIN -F auid!=unset -k mounts"
        "-a always,exit -F arch=b64 -S mount -F auid>=$UID_MIN -F auid!=unset -k mounts"
    )
    [ -n "${UID_MIN}" ] && printf "${rules[@]}" >> /etc/audit/rules.d/50-mounts.rules || printf "ERROR: Variable 'UID_MIN' is unset.\n"

    augenrules --load
    if [[ $(auditctl -s | grep "enabled") =~ "2" ]]; then 
      printf "Reboot required to load rules\n"; 
    fi

    echo "Successful file system mounts are now collected."
}