#!/usr/bin/bash
source utils.sh

{
    echo "Ensure password failed attempts lockout is configured (5.3.3.1.1)..."

    audit_result=true

    # Check faillock.conf for deny setting
    faillock_conf_check=$(grep -Pi -- '^\h*deny\h*=\h*[1-5]\b' /etc/security/faillock.conf)
    if [[ ! "$faillock_conf_check" =~ "deny" ]]; then
        echo "FAIL: deny setting in /etc/security/faillock.conf is not configured or greater than 5"
        audit_result=false
    fi

    # Check common-auth for incorrect deny settings
    common_auth_check=$(grep -Pi -- '^\h*auth\h+(requisite|required|sufficient)\h+pam_faillock\.so\h+([^#\n\r]+\h+)?deny\h*=\h*(0|[6-9]|[1-9][0-9]+)\b' /etc/pam.d/common-auth)
    if [[ "$common_auth_check" ]]; then
        echo "FAIL: deny setting in /etc/pam.d/common-auth is incorrectly configured"
        audit_result=false
    fi

    if $audit_result; then
        echo "Audit Result: PASS"
    else
        echo "Audit Result: FAIL"
        runFix "5.3.3.1.1" fixes/chap5/chap5_3/chap5_3_3/chap5_3_3_1/5_3_3_1_1.sh
    fi
}
