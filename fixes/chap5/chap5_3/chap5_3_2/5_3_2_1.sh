#!/usr/bin/bash
source utils.sh

{
    echo "[REMEDIATION] Ensure pam_unix module is enabled (5.3.2.1)..."

    pam-auth-update --enable unix

    echo "Remediation successful"
}
