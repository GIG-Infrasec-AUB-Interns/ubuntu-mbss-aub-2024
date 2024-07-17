#!/usr/bin/env bash
source utils.sh
source globals.sh

{
    echo "[REMEDIATION] Ensure pam_unix does not include nullok (5.3.3.4.1)..."

    # Remove nullok from pam_unix lines
    grep_query=$(grep -PH -- '^\h*([^#\n\r]+\h+)?pam_unix\.so\h+([^#\n\r]+\h+)?nullok\b' /usr/share/pam-configs/*)

    for file in $grep_query; do
        sed -ri 's/\bnullok\b//g' "$file"
    done

    pam-auth-update --enable unix

    echo "Remediation successful. nullok removed from pam_unix lines."
}
