#! /usr/bin/bash

# 6.3.3.20 [REMEDIATION] Ensure the audit configuration is immutable

{
    echo "[REMEDIATION] Ensuring the audit configuration is immutable (6.3.3.20)..."

    printf -- "-e 2" >> /etc/audit/rules.d/99-finalize.rules
    augenrules --load
    if [[ $(auditctl -s | grep "enabled") =~ "2" ]]; then 
      printf "Reboot required to load rules\n"; 
    fi

    echo "Kernel module loading unloading and modification is now collected."
}