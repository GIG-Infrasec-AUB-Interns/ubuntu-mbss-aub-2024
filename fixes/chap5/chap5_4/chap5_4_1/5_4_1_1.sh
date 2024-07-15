#! /usr/bin/bash
source utils.sh
source globals.sh

{
    echo "[REMEDIATION] Ensure password expiration is configured (5.4.1.1)..."

    # Set the PASS_MAX_DAYS parameter to conform to site policy in /etc/login.defs
    if grep -q "PASS_MAX_DAYS" /etc/login.defs; then
        sed -i "s/^PASS_MAX_DAYS.*/PASS_MAX_DAYS $SET_PASS_MAX_DAYS/" /etc/login.defs
    else
        echo "PASS_MAX_DAYS $SET_PASS_MAX_DAYS" >> /etc/login.defs
    fi

    # modify users with overlimit PASS_MAX_DAYS to be $SET_PASS_MAX_DAYS days 
    users_pass_over_max=$(awk -F: '($2~/^\$.+\$/) {if($5 > 365 || $5 < 1)print $1}' /etc/shadow)

    for user in $users_pass_over_max; do
        chage --maxdays $SET_PASS_MAX_DAYS $user # value editable in globals.sh
    end

}