#!/usr/bin/bash
source utils.sh

{
    echo "[REMEDIATION] Ensuring permissions on /etc/crontab are configured (2.4.1.2)..."

    echo "Setting ownership and permissions on /etc/crontab..."
    chown root:root /etc/crontab
    chmod og-rwx /etc/crontab
    
    echo "Remediation successful."
}
