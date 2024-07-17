#!/usr/bin/bash
source utils.sh

{
    echo "[REMEDIATION] Ensure pam_pwquality module is enabled (5.3.2.3)..."

    # Check if a profile for pam_pwquality exists
    pwquality_profile_check=$(grep -P -- '\bpam_pwquality\.so\b' /usr/share/pam-configs/*)

    if [[ "$pwquality_profile_check" =~ "pam_pwquality.so" ]]; then
        profile_name=$(echo "$pwquality_profile_check" | awk -F: '{print $1}' | xargs -n 1 basename)
        pam-auth-update --enable "$profile_name"
    else
        # Creating the pam_pwquality profile
        pwquality_profile=$(cat <<EOF
Name: Pwquality password strength checking
Default: yes
Priority: 1024
Conflicts: cracklib
Password-Type: Primary
Password:
 requisite pam_pwquality.so retry=3
Password-Initial:
 requisite
EOF
        )
        echo "$pwquality_profile" > /usr/share/pam-configs/pwquality

        # Updating PAM configuration
        pam-auth-update --enable pwquality
    fi

    echo "Remediation successful"
}
