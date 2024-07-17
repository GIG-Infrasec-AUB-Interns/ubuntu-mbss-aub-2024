#!/usr/bin/env bash
source utils.sh
source globals.sh

{
    echo "Ensure pam_unix does not include nullok (5.3.3.4.1)..."
    fail_flag=0

    # Check for nullok in pam_unix lines
    grep_query=$(grep -PH -- '^\h*[^#\n\r]+\h+pam_unix\.so\b' /etc/pam.d/common-{password,auth,account,session,session-noninteractive} | grep -Pv -- '\bnullok\b')

    if [[ -z "$grep_query" ]]; then
        echo "FAIL. nullok found in pam_unix configuration."
        fail_flag=1
    else
        echo "PASS. nullok is not present."
    fi

    if [[ $fail_flag -eq 0 ]]; then
        echo "Overall Result: PASS"
    else
        echo "Overall Result: FAIL"
        runFix "5.3.3.4.1" fixes/chap5/chap5_3/chap5_3_3/chap5_3_3_4/5_3_3_4_1.sh
    fi
}
