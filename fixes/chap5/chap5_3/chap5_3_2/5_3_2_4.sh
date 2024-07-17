#!/usr/bin/bash
source utils.sh

{
    echo "[REMEDIATION] Ensure pam_pwhistory module is enabled (5.3.2.4)..."

    # Check if a profile for pam_pwhistory exists
    pwhistory_profile_check=$(grep -P -- '\bpam_pwhistory\.so\b' /usr/share/pam-configs/*)

    if [[ "$pwhistory_profile_check" =~ "pam_pwhistory.so" ]]; then
        profile_name=$(echo "$pwhistory_profile_check" | awk -F: '{print $1}' | xargs -n 1 basename)
        pam-auth-update --enable "$profile_name"
    else
        # Creating the pam_pwhistory profile
        pwhistory_profile=$(cat <<EOF
Name: pwhistory password history checking
Default: yes
Priority: 1024
Password-Type: Primary
Password:
 requisite pam_pwhistory.so remember=24 enforce_for_root try_first_pass use_authtok
EOF
        )
        echo "$pwhistory_profile" > /usr/share/pam-configs/pwhistory

        # Updating PAM configuration
        pam-auth-update --enable pwhistory
    fi

    echo "Remediation successful"
}
