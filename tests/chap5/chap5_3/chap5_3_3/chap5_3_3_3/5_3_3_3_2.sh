#!/usr/bin/bash
source utils.sh
source globals.sh

{
    echo "Ensure password history is enforced for the root user (5.3.3.3.2)..."
    fail_flag=0

    # Check if enforce_for_root is set for pam_pwhistory
    grep_query=$(grep -Psi -- '^\h*password\h+[^#\n\r]+\h+pam_pwhistory\.so\h+([^#\n\r]+\h+)?enforce_for_root\b' /etc/pam.d/common-password)

    if [[ -n "$grep_query" ]]; then
        echo "PASS: pam_pwhistory is enforcing for root. Output is:"
        echo "$grep_query"
    else    
        echo "FAIL: pam_pwhistory is not enforcing for root."
        fail_flag=1
    fi

    if [[ $fail_flag -eq 0 ]]; then
        echo "Overall Result: PASS"
    else
        echo "Overall Result: FAIL"
        runFix "5.3.3.3.2" fixes/chap5/chap5_3/chap5_3_3/chap5_3_5/5_3_3_3_2.sh
    fi
}
