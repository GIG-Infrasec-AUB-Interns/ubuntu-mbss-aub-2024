#!/usr/bin/bash
source utils.sh

{
    echo "[REMEDIATION] Ensuring permissions on /etc/cron.monthly/ are configured (2.4.1.6)..."

    echo "Setting ownership and permissions on /etc/cron.monthly/..."
    chown root:root /etc/cron.monthly/
    chmod og-rwx /etc/cron.monthly/
    
    echo "Remediation successful."
}
