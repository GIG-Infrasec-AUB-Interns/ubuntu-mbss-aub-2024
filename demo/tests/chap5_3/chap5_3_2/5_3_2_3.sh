#!/usr/bin/bash
source utils.sh

{
    echo "Ensure pam_pwquality module is enabled (5.3.2.3)..."

    audit_result=true

    pwquality_check=$(grep -P -- '\bpam_pwquality\.so\b' /etc/pam.d/common-password)

    if [[ ! "$pwquality_check" =~ "pam_pwquality.so" ]]; then
        echo "FAIL: pam_pwquality.so is not enabled in /etc/pam.d/common-password"
        audit_result=false
    fi

    if $audit_result; then
        echo "Audit Result: PASS"
    else
        echo "Audit Result: FAIL"
        runFix "5.3.2.3" fixes/chap5/chap5_3/chap5_3_2_3.sh
    fi
}
