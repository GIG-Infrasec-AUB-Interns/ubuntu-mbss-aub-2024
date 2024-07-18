#!/usr/bin/bash
source utils.sh
source globals.sh

{
    echo "[REMEDIATION] Ensure pam_unix includes a strong password hashing algorithm (5.3.3.4.3)..."

    grep_query=$(awk '/Password-Type:/{ f = 1;next } /-Type:/{ f = 0 } f {if (/pam_unix\.so/) print FILENAME}' /usr/share/pam-configs/*)

    for file in $grep_query; do
        sed -ri 's/(pam_unix\.so.*)(md5|bigcrypt|sha256|blowfish|gost_yescrypt)/\1yescrypt/' "$file"
    done
    
    pam-auth-update --enable unix
    echo "Remediation successful"
}
