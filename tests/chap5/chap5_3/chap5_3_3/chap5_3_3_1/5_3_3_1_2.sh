#!/usr/bin/bash
source utils.sh
source globals.sh

{
    echo "Ensure password unlock time is configured (5.3.3.1.2)..."

    audit_result=true

    # Check faillock.conf for unlock_time setting
    faillock_conf_check=$(grep -Pi -- '^\h*#*\s*unlock_time\s*=\s*(0|9[0-9][0-9]|[1-9][0-9]{3,})\b' /etc/security/faillock.conf)
    unlock_time_value=$(echo "$faillock_conf_check" | awk -F '=' '{print $2}' | tr -d ' ')

    if [[ ! "$unlock_time_value" =~ ^[0-9]+$ ]] || [[ "$unlock_time_value" -lt "$SET_UNLOCK_TIME" ]]; then
        echo "FAIL: unlock_time setting in /etc/security/faillock.conf is not configured or less than $SET_UNLOCK_TIME"
        audit_result=false
    fi

    # Check common-auth for incorrect unlock_time settings
    common_auth_check=$(grep -Pi -- '^\s*auth\s+(requisite|required|sufficient)\s+pam_faillock\.so\s+([^#\n\r]+\s+)?unlock_time\s*=\s*([1-9]|[1-9][0-9]|[1-8][0-9][0-9])\b' /etc/pam.d/common-auth)
    if [[ "$common_auth_check" ]]; then
        echo "FAIL: unlock_time setting in /etc/pam.d/common-auth is incorrectly configured"
        audit_result=false
    fi

    if $audit_result; then
        echo "Audit Result: PASS"
    else
        echo "Audit Result: FAIL"
        runFix "5.3.3.1.2" fixes/chap5/chap5_3/chap5_3_3/chap5_3_3_1/5_3_3_1_2.sh
    fi
}
