#!/usr/bin/bash
source utils.sh
source globals.sh

{
    echo "[REMEDIATION] Ensure root password is set (5.4.2.4)..."

    echo "Setting the password of root..."
    passwd root

    echo "Remediation successful."
}
