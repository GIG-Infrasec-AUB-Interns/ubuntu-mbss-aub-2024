#!/usr/bin/bash
source utils.sh

{
    echo "[REMEDIATION] Ensure libpam-modules is installed (5.3.1.2)..."

    apt update
    apt upgrade -y libpam-modules

    echo "Remediation successful"
}
