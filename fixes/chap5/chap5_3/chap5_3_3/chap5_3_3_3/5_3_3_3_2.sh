#!/usr/bin/bash
source utils.sh
source globals.sh

{
    echo "[REMEDIATION] Ensure password history is enforced for the root user (5.3.3.3.2)..."

    # Check for pam_pwhistory and modify to add enforce_for_root if needed
    grep_query=$(awk '/Password-Type:/{ f = 1;next } /-Type:/{ f = 0 } f {if (/pam_pwhistory\.so/) print FILENAME}' /usr/share/pam-configs/*)

    for file in $grep_query; do
        # Check if enforce_for_root already exists
        if ! grep -q 'enforce_for_root' "$file"; then
            sed -ri 's/(pam_pwhistory\.so.*)/\1 enforce_for_root/' "$file"
        fi
    done

    # Enable the modified profile
    pam-auth-update --enable pwhistory

    echo "Remediation successful"
}
