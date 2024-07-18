#!/usr/bin/bash
source utils.sh
source globals.sh

{
    echo "[REMEDIATION] Ensure password complexity is configured (5.3.3.2.3)..."

    sed -ri 's/^\s*minclass\s*=/# &/' /etc/security/pwquality.conf
    sed -ri 's/^\s*[dulo]credit\s*=/# &/' /etc/security/pwquality.conf
    [ ! -d /etc/security/pwquality.conf.d/ ] && mkdir /etc/security/pwquality.conf.d/
    
    printf '\n%s\n' "minclass = $MINCLASS" > /etc/security/pwquality.conf.d/50-pwcomplexity.conf
    printf '%s\n' "dcredit = $DCREDIT" >> /etc/security/pwquality.conf.d/50-pwcomplexity.conf
    printf '%s\n' "ucredit = $UCREDIT" >> /etc/security/pwquality.conf.d/50-pwcomplexity.conf
    printf '%s\n' "lcredit = $LCREDIT" >> /etc/security/pwquality.conf.d/50-pwcomplexity.conf
    printf '%s\n' "ocredit = $OCREDIT" >> /etc/security/pwquality.conf.d/50-pwcomplexity.conf

    grep_query=$(grep -Pl -- '\bpam_pwquality\.so\h+([^#\n\r]+\h+)?(minclass|[dulo]credit)\b' /usr/share/pam-configs/*)

    for file in $grep_query; do
        sed -ri 's/(minclass|[dulo]credit)=[^ ]+/& # commented out by script/' "$file"
    done

    echo "Remediation successful"
}
