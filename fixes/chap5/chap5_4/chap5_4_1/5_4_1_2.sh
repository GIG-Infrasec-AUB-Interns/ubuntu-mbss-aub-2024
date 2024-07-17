#! /usr/bin/bash
source utils.sh
source globals.sh

{
    echo "[REMEDIATION] Ensure minimum password age is configured (5.4.1.2)..."

    # Set the PASS_MAX_DAYS parameter to conform to site policy in /etc/login.defs
    if grep -q "PASS_MIN_DAYS" /etc/login.defs; then
        sed -i "s/^PASS_MIN_DAYS.*/PASS_MIN_DAYS $SET_PASS_MIN_DAYS/" /etc/login.defs
    else
        echo "PASS_MIN_DAYS $SET_PASS_MIN_DAYS" >> /etc/login.defs
    fi

    # modify users with less than PASS_MIN_DAYS to be $SET_PASS_MIN_DAYS days 
    awk -F: '($2~/^\$.+\$/) {if($4 < 1)system ("chage --mindays '$SET_PASS_MIN_DAYS' " $1)}' /etc/shadow
    echo "Remediation successful."
}