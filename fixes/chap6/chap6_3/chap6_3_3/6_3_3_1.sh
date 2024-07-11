#! /usr/bin/bash

# 6.3.3.1 [REMEDIATION] Ensure changes to system administration scope (sudoers) is collected

{
    echo "[REMEDIATION] Ensuring changes to system administration scope (sudoers) is collected (6.3.3.1)..."

    printf '%s\n' "-w /etc/sudoers -p wa -k scope" "-w /etc/sudoers.d -p wa -k scope" >> /etc/audit/rules.d/50-scope.rules
    augenrules --load
    if [[ $(auditctl -s | grep "enabled") =~ "2" ]]; then 
        printf "Reboot required to load rules\n"; 
    fi

    echo "Changes to system administration scope (sudoers) is now collected."
}