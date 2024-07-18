#! /usr/bin/bash
source utils.sh
# 6.3.3.11 [REMEDIATION] Ensure session initiation information is collected

{
    echo "[REMEDIATION] Ensuring session initiation information is collected (6.3.3.11)..."

    rules=(
        "-w /var/run/utmp -p wa -k session" 
        "-w /var/log/wtmp -p wa -k session" 
        "-w /var/log/btmp -p wa -k session" 
    )
    newRule /etc/audit/rules.d/50-session.rules "${rules[@]}"

    echo "Events that modify user/group information are now collected."
}