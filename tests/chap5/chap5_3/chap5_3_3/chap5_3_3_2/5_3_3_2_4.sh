#!/usr/bin/bash
source utils.sh
source globals.sh

{
    echo "Ensure password same consecutive characters is configured (5.3.3.2.4)..."
    fail_flag=0

    # Check if maxrepeat is set to 3 or less
    grep_query=$(grep -Psi -- '^\h*maxrepeat\h*=\h*[1-3]\b' /etc/security/pwquality.conf /etc/security/pwquality.conf.d/*.conf)
    maxrepeat_value=$(echo "$grep_query" | awk -F '=' '{print $2}' | tr -d ' ')

    if [[ "$maxrepeat_value" -gt 0 && "$maxrepeat_value" -le $MAXREPEAT ]]; then
        echo "PASS"
    else    
        echo "FAIL: maxrepeat is not set to 3 or less."
        echo "$grep_query"
        fail_flag=1
    fi

    # Check pam configuration
    grep_query2=$(grep -Psi -- '^\h*password\h+(requisite|required|sufficient)\h+pam_pwquality\.so\h+([^#\n\r]+\h+)?maxrepeat\h*=\h*(0|[4-9]|[1-9][0-9]+)\b' /etc/pam.d/common-password)

    if [[ -z "$grep_query2" ]]; then
        echo "PASS"
    else
        echo "FAIL: maxrepeat is set incorrectly."
        echo "$grep_query2"
        fail_flag=1
    fi

    if [[ $fail_flag -eq 0 ]]; then
        echo "Overall Result: PASS"
    else
        echo "Overall Result: FAIL"
        runFix "5.3.3.2.4" fixes/chap5/chap5_3/chap5_3_3/chap5_3_3_2/5_3_3_2_4.sh
    fi
}
