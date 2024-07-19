#!/usr/bin/bash
source utils.sh
source globals.sh

{
    echo "[REMEDIATION] Ensure pam_unix includes use_authtok (5.3.3.4.4)..."

    grep_query=$(awk '/Password-Type:/{ f = 1;next } /-Type:/{ f = 0 } f {if (/pam_unix\.so/) print FILENAME}' /usr/share/pam-configs/*)

    for file in $grep_query; do
        if ! grep -q 'use_authtok' "$file"; then
            sed -i 's/\(pam_unix\.so\)/\1 use_authtok/' "$file"
        fi
    done
    
    pam-auth-update --enable unix
    echo "Remediation successful"
}
