#!/usr/bin/bash
source utils.sh

{
    echo "Ensure pam_pwhistory module is enabled (5.3.2.4)..."

    audit_result=true

    pwhistory_check=$(grep -P -- '\bpam_pwhistory\.so\b' /etc/pam.d/common-password)

    if [[ ! "$pwhistory_check" =~ "pam_pwhistory.so" ]]; then
        echo "FAIL: pam_pwhistory.so is not enabled in /etc/pam.d/common-password"
        audit_result=false
    fi

    if $audit_result; then
        echo "Audit Result: PASS"
    else
        echo "Audit Result: FAIL"
        runFix "5.3.2.4" fixes/chap5/chap5_3/chap5_3_2_4.sh
    fi
}
