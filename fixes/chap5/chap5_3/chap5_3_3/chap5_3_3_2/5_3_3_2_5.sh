#!/usr/bin/bash
source utils.sh
source globals.sh

{
    echo "[REMEDIATION] Ensure password maximum sequential characters is configured (5.3.3.2.5)..."

    sed -ri 's/^\s*maxsequence\s*=/# &/' /etc/security/pwquality.conf
    [ ! -d /etc/security/pwquality.conf.d/ ] && mkdir /etc/security/pwquality.conf.d/
    printf '\n%s' "maxsequence = $MAXSEQUENCE" > /etc/security/pwquality.conf.d/50-pwmaxsequence.conf

    grep_query=$(grep -Pl -- '\bpam_pwquality\.so\h+([^#\n\r]+\h+)?maxsequence\b' /usr/share/pam-configs/*)

    for file in $grep_query; do
        sed -ri 's/(maxsequence)=[^ ]+/& # commented out by script/' "$file"
    done

    echo "Remediation successful"
}
