#!/usr/bin/bash
source utils.sh

{
    echo "[REMEDIATION] Ensuring permissions on /etc/cron.daily/ are configured (2.4.1.4)..."

    echo "Setting ownership and permissions on /etc/cron.daily/..."
    chown root:root /etc/cron.daily/
    chmod og-rwx /etc/cron.daily/
    
    echo "Remediation successful."
}
