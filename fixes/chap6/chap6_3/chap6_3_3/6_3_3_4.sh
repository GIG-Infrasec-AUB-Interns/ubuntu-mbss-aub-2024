#! /usr/bin/bash
source utils.sh
# 6.3.3.4 [REMEDIATION] Ensure events that modify date and time information are collected

{
    echo "[REMEDIATION] Ensuring events that modify date and time information are collected (6.3.3.4)..."

    rules=(
        "-a always,exit -F arch=b64 -S adjtimex,settimeofday,clock_settime -k time-change"
        "-a always,exit -F arch=b32 -S adjtimex,settimeofday,clock_settime -k time-change"
        "-w /etc/localtime -p wa -k time-change"
    )
    newRule /etc/audit/rules.d/50-time-change.rules "${rules[@]}"

    echo "Events that modify date and time information are now collected."
}