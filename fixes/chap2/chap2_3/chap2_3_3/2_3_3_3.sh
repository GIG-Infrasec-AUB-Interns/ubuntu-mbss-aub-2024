#!/usr/bin/bash
source utils.sh

{
    echo "[REMEDIATION] Ensuring chrony is enabled and running (2.3.3.3)..."

    echo "Unmasking chrony..."
    systemctl unmask chrony.service
    echo "Enabling chrony..."
    systemctl --now enable chrony.service
    
    echo "Enabled chrony daemon successfully."
}
