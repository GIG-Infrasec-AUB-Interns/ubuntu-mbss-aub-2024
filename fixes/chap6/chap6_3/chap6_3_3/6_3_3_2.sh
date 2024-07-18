#! /usr/bin/bash
source utils.sh
# 6.3.3.2 [REMEDIATION] Ensure actions as another user are always logged

{
    echo "[REMEDIATION] Ensuring actions as another user are always logged (6.3.3.2)..."

    rules=(
        "-a always,exit -F arch=b64 -C euid!=uid -F auid!=unset -S execve -k user_emulation"
        "-a always,exit -F arch=b32 -C euid!=uid -F auid!=unset -S execve -k user_emulation"
    )
    newRule /etc/audit/rules.d/50-user_emulation.rules "${rules[@]}"

    echo "Actions as another user are always logged now."
}