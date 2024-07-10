#!/usr/bin/bash
source utils.sh

{
    echo "[REMEDIATION] Ensuring permissions on /etc/cron.weekly/ are configured (2.4.1.5)..."

    echo "Setting ownership and permissions on /etc/cron.weekly/..."
    chown root:root /etc/cron.weekly/
    chmod og-rwx /etc/cron.weekly/
    
    echo "Remediation successful."
}
