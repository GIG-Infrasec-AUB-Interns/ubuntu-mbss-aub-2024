#!/usr/bin/env bash
source utils.sh
source globals.sh

{
    echo "[REMEDIATION] Ensure pam_pwhistory includes use_authtok (5.3.3.3.3)..."

    grep_query=$(grep -PL -- '^\h*password\h+[^#\n\r]+\h+pam_pwhistory\.so\h+([^#\n\r]+\h+)?use_authtok\b' /etc/pam.d/common-password)

    if [[ -n "$grep_query" ]]; then
        echo "Updating pam_pwhistory configuration to include use_authtok..."
        
        awk '/^password/{found=1} found && /pam_pwhistory\.so/{print; print "    use_authtok"; found=0; next} 1' /etc/pam.d/common-password > /etc/pam.d/common-password.tmp && mv /etc/pam.d/common-password.tmp /etc/pam.d/common-password
    fi

    echo "Remediation successful"
}
