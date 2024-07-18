#!/usr/bin/bash
source utils.sh
source globals.sh

{
    echo "Ensure password history remember is configured (5.3.3.3.1)..."
    fail_flag=0

    # Check if pam_pwhistory is configured with remember=24 or more
    grep_query=$(grep -Psi -- '^\h*password\h+[^#\n\r]+\h+pam_pwhistory\.so\h+([^#\n\r]+\h+)?remember=\d+\b' /etc/pam.d/common-password)

    if [[ -n "$grep_query" && $(echo "$grep_query" | grep -Eo 'remember=[0-9]+' | grep -Eo '[0-9]+') -ge 24 ]]; then
        echo "PASS: pam_pwhistory is configured correctly. Output is:"
        echo "$grep_query"
    else    
        echo "FAIL: pam_pwhistory is not configured correctly."
        fail_flag=1
    fi

    if [[ $fail_flag -eq 0 ]]; then
        echo "Overall Result: PASS"
    else
        echo "Overall Result: FAIL"
        runFix "5.3.3.3.1" fixes/chap5/chap5_3/chap5_3_3/chap5_3_5/5_3_3_3_1.sh
    fi
}
