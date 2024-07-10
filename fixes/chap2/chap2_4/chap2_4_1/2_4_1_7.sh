#!/usr/bin/bash
source utils.sh

{
    echo "[REMEDIATION] Ensuring permissions on /etc/cron.d/ are configured (2.4.1.7)..."

    echo "Setting ownership and permissions on /etc/cron.d/..."
    chown root:root /etc/cron.d/
    chmod og-rwx /etc/cron.d/
    
    echo "Remediation successful."
}
