#!/usr/bin/bash
source utils.sh
source globals.sh

{
    echo "[REMEDIATION] Ensure password quality is enforced for the root user (5.3.3.2.8)..."

    # Create pwquality.conf.d directory if it doesn't exist
    [ ! -d /etc/security/pwquality.conf.d/ ] && mkdir /etc/security/pwquality.conf.d/

    # Add enforce_for_root setting
    printf '\n%s\n' "enforce_for_root" > /etc/security/pwquality.conf.d/50-pwroot.conf

    echo "Remediation successful"
}
