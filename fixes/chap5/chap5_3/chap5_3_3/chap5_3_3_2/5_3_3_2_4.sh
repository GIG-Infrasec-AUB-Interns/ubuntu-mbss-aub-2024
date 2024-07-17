#!/usr/bin/bash
source utils.sh
source globals.sh

{
    echo "[REMEDIATION] Ensure password same consecutive characters is configured (5.3.3.2.4)..."

    sed -ri 's/^\s*maxrepeat\s*=/# &/' /etc/security/pwquality.conf
    [ ! -d /etc/security/pwquality.conf.d/ ] && mkdir /etc/security/pwquality.conf.d/
    printf '\n%s' "maxrepeat = $MAXREPEAT" > /etc/security/pwquality.conf.d/50-pwrepeat.conf

    grep_query=$(grep -Pl -- '\bpam_pwquality\.so\h+([^#\n\r]+\h+)?maxrepeat\b' /usr/share/pam-configs/*)

    for file in $grep_query; do
        sed -ri 's/(maxrepeat)=[^ ]+/& # commented out by script/' "$file"
    done

    echo "Remediation successful"
}
