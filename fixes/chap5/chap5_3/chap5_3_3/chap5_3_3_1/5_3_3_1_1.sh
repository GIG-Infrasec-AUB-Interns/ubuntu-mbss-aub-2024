#!/usr/bin/bash
source utils.sh

{
    echo "[REMEDIATION] Ensure password failed attempts lockout is configured (5.3.3.1.1)..."

    # Set deny setting in /etc/security/faillock.conf to 5
    if grep -q "^\s*#\?\s*deny\s*=" /etc/security/faillock.conf; then
        sed -i 's/^\s*#\?\s*deny\s*=.*/# deny = 5/' /etc/security/faillock.conf
    else
        echo "deny = 5" >> /etc/security/faillock.conf
    fi

    # Remove incorrect deny settings from PAM configuration files
    profile_files=$(grep -Pl -- '\bpam_faillock\.so\h+([^#\n\r]+\h+)?deny\b' /usr/share/pam-configs/*)
    for file in $profile_files; do
        sed -i 's/^\s*\(auth.*pam_faillock\.so.*\)\(\s\+deny\s*=\s*[0-9]\+\)\(.*\)$/\1\3/' "$file"
    done

    # Update PAM configuration
    pam-auth-update --enable faillock

    echo "Remediation successful"
}
