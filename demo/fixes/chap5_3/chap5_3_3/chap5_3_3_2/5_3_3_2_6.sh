#!/usr/bin/bash
source utils.sh
source globals.sh

{
    echo "[REMEDIATION] Ensure password dictionary check is enabled (5.3.3.2.6)..."

    sed -ri 's/^\s*dictcheck\s*=/# &/' /etc/security/pwquality.conf /etc/security/pwquality.conf.d/*.conf

    grep_query=$(grep -Pl -- '\bpam_pwquality\.so\h+([^#\n\r]+\h+)?dictcheck\b' /usr/share/pam-configs/*)

    for file in $grep_query; do
        sed -ri 's/(dictcheck)=[^ ]+/& # commented out by script/' "$file"
    done

    echo "Remediation successful"
}
