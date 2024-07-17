#!/usr/bin/bash
source utils.sh

{
    echo "Ensure password unlock time is configured (5.3.3.1.2)..."

    audit_result=true

    # Check faillock.conf for unlock_time setting
    faillock_conf_check=$(grep -Pi -- '^\h*unlock_time\h*=\h*(0|9[0-9][0-9]|[1-9][0-9]{3,})\b' /etc/security/faillock.conf)
    if [[ ! "$faillock_conf_check" =~ "unlock_time" ]]; then
        echo "FAIL: unlock_time setting in /etc/security/faillock.conf is not configured or less than 900"
        audit_result=false
    fi

    # Check common-auth for incorrect unlock_time settings
    common_auth_check=$(grep -Pi -- '^\h*auth\h+(requisite|required|sufficient)\h+pam_faillock\.so\h+([^#\n\r]+\h+)?unlock_time\h*=\h*([1-9]|[1-9][0-9]|[1-8][0-9][0-9])\b' /etc/pam.d/common-auth)
    if [[ "$common_auth_check" ]]; then
        echo "FAIL: unlock_time setting in /etc/pam.d/common-auth is incorrectly configured"
        audit_result=false
    fi

    if $audit_result; then
        echo "Audit Result: PASS"
    else
        echo "Audit Result: FAIL"
        runFix "5.3.3.1.2" fixes/chap5/chap5_3/chap5_3_3_1_2.sh
    fi
}
