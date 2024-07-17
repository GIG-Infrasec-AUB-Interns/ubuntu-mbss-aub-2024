#!/usr/bin/bash
source utils.sh

{
    echo "[REMEDIATION] Ensure latest version of pam is installed (5.3.1.1)..."
    
    apt update
    apt upgrade -y libpam-runtime

    echo "Remediation successful"
}
