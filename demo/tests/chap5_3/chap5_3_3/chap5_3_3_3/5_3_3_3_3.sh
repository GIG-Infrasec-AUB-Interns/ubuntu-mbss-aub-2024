#!/usr/bin/env bash
source utils.sh
source globals.sh

{
    echo "Ensure pam_pwhistory includes use_authtok (5.3.3.3.3)..."
    fail_flag=0

    # Check if use_authtok is present
    grep_query=$(grep -Psi -- '^\h*password\h+[^#\n\r]+\h+pam_pwhistory\.so\h+([^#\n\r]+\h+)?use_authtok\b' /etc/pam.d/common-password)

    if [[ -z "$grep_query" ]]; then
        echo "FAIL. use_authtok is not present in pam_pwhistory configuration."
        fail_flag=1
    else
        echo "PASS. use_authtok is present."
    fi

    if [[ $fail_flag -eq 0 ]]; then
        echo "Overall Result: PASS"
    else
        echo "Overall Result: FAIL"
        runFix "5.3.3.3.3" fixes/chap5/chap5_3/chap5_3_3/chap5_3_5/5_3_3_3_3.sh
    fi
}
