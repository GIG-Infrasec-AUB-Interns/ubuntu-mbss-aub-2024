#!/usr/bin/bash
source utils.sh
source globals.sh

{
    echo "Ensure password dictionary check is enabled (5.3.3.2.6)..."
    fail_flag=0

    # Check if maxsequence is set to 3 or less
    grep_query=$(grep -Psi -- '^\h*dictcheck\h*=\h*0\b' /etc/security/pwquality.conf /etc/security/pwquality.conf.d/*.conf)
    
    if [[ -z "$grep_query" ]]; then
        echo "PASS"
    else    
        echo "FAIL. Output is the ff:"
        echo "$grep_query"
        fail_flag=1
    fi

    grep_query2=$(grep -Psi -- '^\h*password\h+(requisite|required|sufficient)\h+pam_pwquality\.so\h+([^#\n\r]+\h+)?dictcheck\h*=\h*0\b' /etc/pam.d/common-password)
    
    if [[ -z "$grep_query2" ]]; then
        echo "PASS"
    else    
        echo "FAIL. Output is the ff:"
        echo "$grep_query2"
        fail_flag=1
    fi

    if [[ $fail_flag -eq 0 ]]; then
        echo "Overall Result: PASS"
    else
        echo "Overall Result: FAIL"
        runFix "5.3.3.2.6" fixes/chap5/chap5_3/chap5_3_3/chap5_3_5/5_3_3_2_6.sh
    fi
}
