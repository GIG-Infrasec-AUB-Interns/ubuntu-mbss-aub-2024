#!/usr/bin/bash
source utils.sh
source globals.sh

{
    echo "[REMEDIATION] Ensure password quality checking is enforced (5.3.3.2.7)..."

    # Comment out any enforcing = 0 settings
    sed -ri "s/^\s*enforcing\s*=${ENFORCING_VALUE}/# &/" /etc/security/pwquality.conf /etc/security/pwquality.conf.d/*.conf

    # Remove enforcing=0 from PAM configuration
    grep_query=$(grep -Pl -- "\bpam_pwquality\.so\h+([^#\n\r]+\h+)?enforcing=${ENFORCING_VALUE}\b" /usr/share/pam-configs/*)

    for file in $grep_query; do
        sed -ri "s/(enforcing)=${ENFORCING_VALUE}/# &/" "$file"
    done

    echo "Remediation successful"
}
