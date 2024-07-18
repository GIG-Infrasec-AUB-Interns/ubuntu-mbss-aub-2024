#!/usr/bin/bash
source utils.sh
source globals.sh

{
    echo "[REMEDIATION] Ensure password history remember is configured (5.3.3.3.1)..."

    # Check for pam_pwhistory and modify the remember value if needed
    grep_query=$(awk '/Password-Type:/{ f = 1;next } /-Type:/{ f = 0 } f {if (/pam_pwhistory\.so/) print FILENAME}' /usr/share/pam-configs/*)

    for file in $grep_query; do
        sed -ri 's/(pam_pwhistory\.so.*)remember=\d+/\1remember=24/' "$file"
    done

    # Enable the modified profile
    pam-auth-update --enable pwhistory

    echo "Remediation successful"
}
