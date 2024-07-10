#!/usr/bin/bash
source utils.sh

{
    echo "[REMEDIATION] Ensuring systemd-timesyncd is enabled and running (2.3.2.2)..."
    echo "Unmasking systemd-timesyncd..."
    systemctl unmask systemd-timesyncd.service
    echo "Enabling systemd-timesyncd..."
    systemctl --now enable systemd-timesyncd.service
    
    echo "Enabled systemd-timesyncd daemon successfully."
}
