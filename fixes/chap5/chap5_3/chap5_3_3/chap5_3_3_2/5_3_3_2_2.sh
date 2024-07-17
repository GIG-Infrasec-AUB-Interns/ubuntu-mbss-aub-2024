#!/usr/bin/bash
source utils.sh

{
    echo "[REMEDIATION] Ensure minimum password length is configured (5.3.3.2.2)..."

    sed -ri 's/^\s*minlen\s*=/# &/' /etc/security/pwquality.conf
    [ ! -d /etc/security/pwquality.conf.d/ ] && mkdir /etc/security/pwquality.conf.d/
    printf '\n%s' "minlen = 14" > /etc/security/pwquality.conf.d/50-pwlength.conf

    grep_query=$(grep -Pl -- '\bpam_pwquality\.so\h+([^#\n\r]+\h+)?minlen\b' /usr/share/pam-configs/)

    for file in $grep_query; do
        sed -ri 's/(\bpam_pwquality\.so\h+.*)minlen\b/# &/' "$file"
    done

    echo "Remediation successful"
}
