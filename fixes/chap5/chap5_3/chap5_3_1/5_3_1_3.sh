#!/usr/bin/bash
source utils.sh

{
    echo "[REMEDIATION] Ensure libpam-pwquality is installed (5.3.1.3)..."

    apt install libpam-pwquality

    echo "Remediation successful"
}
