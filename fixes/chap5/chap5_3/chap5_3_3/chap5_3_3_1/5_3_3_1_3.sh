#!/usr/bin/bash
source utils.sh

{
    echo "[REMEDIATION] Ensure password failed attempts lockout includes root account (5.3.3.1.3)..."

    # Ensure even_deny_root is enabled
    if ! grep -q "even_deny_root" /etc/security/faillock.conf; then
        echo "even_deny_root" >> /etc/security/faillock.conf
    fi

    # Set root_unlock_time to 60 seconds or more if not already set
    if grep -q "root_unlock_time" /etc/security/faillock.conf; then
        sed -i 's/^\s*root_unlock_time\s*=\s*[0-9]\+/root_unlock_time = 60/' /etc/security/faillock.conf
    else
        echo "root_unlock_time = 60" >> /etc/security/faillock.conf
    fi

    # Remove incorrect root_unlock_time settings from PAM configuration files
    profile_files=$(grep -Pl -- '\bpam_faillock\.so\h+([^#\n\r]+\h+)?(even_deny_root|root_unlock_time)' /usr/share/pam-configs/*)
    for file in $profile_files; do
        sed -i 's/^\s*\(auth.*pam_faillock\.so.*\)\(\s\+even_deny_root\s*=\s*\d*\)\?\(\s\+root_unlock_time\s*=\s*[0-9]\+\)\(.*\)$/\1\4/' "$file"
    done

    # Update PAM configuration
    pam-auth-update --enable faillock

    echo "Remediation successful"
}
