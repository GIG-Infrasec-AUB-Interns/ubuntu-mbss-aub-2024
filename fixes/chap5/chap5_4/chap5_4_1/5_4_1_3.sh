#!/usr/bin/bash
source utils.sh
source globals.sh

{
    echo "[REMEDIATION] Ensure password expiration warning days is configured (5.4.1.3)..."

    # Set the PASS_WARN_AGE parameter to conform to site policy in /etc/login.defs
    if grep -q "PASS_WARN_AGE" /etc/login.defs; then
        sed -i "s/^PASS_WARN_AGE.*/PASS_WARN_AGE $SET_WARN_AGE/" /etc/login.defs
    else
        echo "PASS_WARN_AGE $SET_WARN_AGE" >> /etc/login.defs
    fi

    # Modify users with PASS_WARN_AGE less than $SET_WARN_AGE
    awk -F: '($2~/^\$.+\$/) {if($6 < '$SET_WARN_AGE')system ("chage --warndays '$SET_WARN_AGE' " $1)}' /etc/shadow

    echo "[REMEDIATION COMPLETE] Password expiration warning days settings updated."
}
