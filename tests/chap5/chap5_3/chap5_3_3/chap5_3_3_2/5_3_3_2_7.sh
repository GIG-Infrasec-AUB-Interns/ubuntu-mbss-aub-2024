#!/usr/bin/bash
source utils.sh
source globals.sh

{
    echo "Ensure password quality checking is enforced (5.3.3.2.7)..."
    fail_flag=0

    # Check if enforcing is set to 0
    grep_query=$(grep -PHsi -- "^\h*enforcing\h*=${ENFORCING_VALUE}\b" /etc/security/pwquality.conf /etc/security/pwquality.conf.d/*.conf)
    
    if [[ -z "$grep_query" ]]; then
        echo "PASS: enforcing is not set to $ENFORCING_VALUE."
    else    
        echo "FAIL: enforcing is set to $ENFORCING_VALUE. Output is:"
        echo "$grep_query"
        fail_flag=1
    fi

    # Check PAM configuration
    grep_query2=$(grep -PHsi -- "^\h*password\h+[^#\n\r]+\h+pam_pwquality\.so\h+([^#\n\r]+\h+)?enforcing=${ENFORCING_VALUE}\b" /etc/pam.d/common-password)

    if [[ -z "$grep_query2" ]]; then
        echo "PASS: enforcing is not set to $ENFORCING_VALUE in PAM."
    else    
        echo "FAIL: enforcing is set to $ENFORCING_VALUE in PAM. Output is:"
        echo "$grep_query2"
        fail_flag=1
    fi

    if [[ $fail_flag -eq 0 ]]; then
        echo "Overall Result: PASS"
    else
        echo "Overall Result: FAIL"
        runFix "5.3.3.2.7" fixes/chap5/chap5_3/chap5_3_3/chap5_3_3_2/5_3_3_2_7.sh
    fi
}
