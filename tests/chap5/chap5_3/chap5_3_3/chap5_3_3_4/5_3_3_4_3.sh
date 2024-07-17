#!/usr/bin/bash
source utils.sh
source globals.sh

{
    echo "Ensure pam_unix includes a strong password hashing algorithm (5.3.3.4.3)..."
    fail_flag=0

    grep_query=$(grep -PH -- '^\h*password\h+[^#\n\r]+\h+pam_unix\.so\h+([^#\n\r]+\h+)?(sha512|yescrypt)\b' /etc/pam.d/common-password)

    if [[ -z "$grep_query" ]]; then
        echo "FAIL. No strong password hashing algorithm found."
        fail_flag=1
    else    
        echo "PASS"
    fi

    if [[ $fail_flag -eq 0 ]]; then
        echo "Overall Result: PASS"
    else
        echo "Overall Result: FAIL"
        runFix "5.3.3.4.3" fixes/chap5/chap5_3/chap5_3_3/chap5_3_3_4/5_3_3_4_3.sh
    fi
}
