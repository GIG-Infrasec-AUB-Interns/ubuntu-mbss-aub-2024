#!/usr/bin/bash
source utils.sh

{
    echo "[REMEDIATION] Ensuring permissions on /etc/cron.hourly/ are configured (2.4.1.3)..."

    echo "Setting ownership and permissions on /etc/cron.hourly/..."
    chown root:root /etc/cron.hourly/
    chmod og-rwx /etc/cron.hourly/
    
    echo "Remediation successful."
}
