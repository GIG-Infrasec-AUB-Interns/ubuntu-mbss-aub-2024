#!/usr/bin/env bash
source utils.sh
source globals.sh

{
    echo "[REMEDIATION] Ensure pam_unix does not include remember (5.3.3.4.2)..."

    # Remove remember from pam_unix lines
    grep_query=$(grep -PH -- '^\h*([^#\n\r]+\h+)?pam_unix\.so\h+([^#\n\r]+\h+)?remember\b' /usr/share/pam-configs/*)

    for file in $grep_query; do
        sed -ri 's/\bremember=\d+\b//g' "$file"
    done
    pam-auth-update --enable unix
    
    echo "Remediation successful. remember removed from pam_unix lines."
}
