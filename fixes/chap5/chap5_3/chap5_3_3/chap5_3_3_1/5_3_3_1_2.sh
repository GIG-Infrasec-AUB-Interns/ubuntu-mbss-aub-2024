#!/usr/bin/bash
source utils.sh
source globals.sh
{
    echo "[REMEDIATION] Ensure password unlock time is configured (5.3.3.1.2)..."

    # Set unlock_time setting in /etc/security/faillock.conf
    if grep -q "^\s*#\?\s*unlock_time\s*=" /etc/security/faillock.conf; then
        sed -i 's/^\s*#\?\s*unlock_time\s*=.*/# unlock_time = $SET_UNLOCK_TIME/' /etc/security/faillock.conf
    else
        echo "# unlock_time = $SET_UNLOCK_TIME" >> /etc/security/faillock.conf
    fi

    # Remove incorrect unlock_time settings from PAM configuration files
    profile_files=$(grep -Pl -- '\bpam_faillock\.so\h+([^#\n\r]+\h+)?unlock_time\b' /usr/share/pam-configs/*)
    for file in $profile_files; do
        sed -i 's/^\s*\(auth.*pam_faillock\.so.*\)\(\s\+unlock_time\s*=\s*[0-9]\+\)\(.*\)$/\1\3/' "$file"
    done

    # Update PAM configuration
    pam-auth-update --enable faillock

    echo "Remediation successful"
}
