#!/usr/bin/bash
source utils.sh

{
    echo "[REMEDIATION] Ensure password number of changed characters is configured (5.3.3.2.1)..."

    sed -ri 's/^\s*difok\s*=/# &/' /etc/security/pwquality.conf
    [ ! -d /etc/security/pwquality.conf.d/ ] && mkdir /etc/security/pwquality.conf.d/
    printf '\n%s' "difok = 2" > /etc/security/pwquality.conf.d/50-pwdifok.conf

    grep_query=$(grep -Pl -- '\bpam_pwquality\.so\h+([^#\n\r]+\h+)?difok\b' /usr/share/pamconfigs/*)

    for file in $grep_query; do
        sed -ri 's/^\h*pam_pwquality\.so\h+([^#\n\r]+\h+)?difok\b/# &/' "$file"
    done
    
    echo "Remediation successful"
}
