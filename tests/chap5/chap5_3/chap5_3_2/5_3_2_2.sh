#!/usr/bin/bash
source utils.sh

{
    echo "Ensure pam_faillock module is enabled (5.3.2.2)..."

    audit_result=true

    auth_check=$(grep -P -- '\bpam_faillock\.so\b' /etc/pam.d/common-auth)
    account_check=$(grep -P -- '\bpam_faillock\.so\b' /etc/pam.d/common-account)

    if [[ ! "$auth_check" =~ "pam_faillock.so preauth" ]]; then
        echo "FAIL: pam_faillock.so preauth is not enabled in /etc/pam.d/common-auth"
        audit_result=false
    fi

    if [[ ! "$auth_check" =~ "pam_faillock.so authfail" ]]; then
        echo "FAIL: pam_faillock.so authfail is not enabled in /etc/pam.d/common-auth"
        audit_result=false
    fi

    if [[ ! "$account_check" =~ "pam_faillock.so" ]]; then
        echo "FAIL: pam_faillock.so is not enabled in /etc/pam.d/common-account"
        audit_result=false
    fi

    if $audit_result; then
        echo "Audit Result: PASS"
    else
        echo "Audit Result: FAIL"
        runFix "5.3.2.2" fixes/chap5/chap5_3/chap5_3_2_2.sh
    fi
}
