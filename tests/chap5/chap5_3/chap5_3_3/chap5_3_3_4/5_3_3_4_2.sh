#!/usr/bin/env bash
source utils.sh
source globals.sh

{
    echo "Ensure pam_unix does not include remember (5.3.3.4.2)..."
    fail_flag=0

    # Check for remember in pam_unix lines
    grep_query=$(grep -PH -- '^\h*[^#\n\r]+\h+pam_unix\.so\b' /etc/pam.d/common-{password,auth,account,session,session-noninteractive} | grep -Pv -- '\bremember=\d+\b')

    if [[ -z "$grep_query" ]]; then
        echo "FAIL. remember found in pam_unix configuration."
        fail_flag=1
    else
        echo "PASS. remember is not present."
    fi

    if [[ $fail_flag -eq 0 ]]; then
        echo "Overall Result: PASS"
    else
        echo "Overall Result: FAIL"
        runFix "5.3.3.4.2" fixes/chap5/chap5_3/chap5_3_3/chap5_3_5/5_3_3_4_2.sh
    fi
}
