#!/usr/bin/bash
source utils.sh
source globals.sh

{
    echo "Ensure minimum password length is configured (5.3.3.2.2)..."
    fail_flag=0

    grep_query=$(grep -Psi -- '^\h*minlen\h*=\h*(1[4-9]|[2-9][0-9]|[1-9][0-9]{2,})\b'/etc/security/pwquality.conf /etc/security/pwquality.conf.d/*.conf)
    pw_length=$(echo "$grep_query" | awk -F '=' '{print $2}' | tr -d ' ')

    if [[ "$pw_length" -ge $SET_MINPW_LENGTH ]]; then # set to 14 in globals.sh
        echo "PASS"
    else    
        echo "FAIL: Minimum password length is less than $SET_MINPW_LENGTH."
        echo "$grep_query"
        fail_flag=1
    fi

    grep_query2=$(grep -Psi -- '^\h*password\h+(requisite|required|sufficient)\h+pam_pwquality\.so\h+([^#\n\r]+\h+)?minlen\h*=\h*([0-9]|1[0-3])\b' /etc/pam.d/system-auth /etc/pam.d/common-password)

    if [[ -z "$grep_query2" ]]; then
        echo "PASS"
    else
        echo "FAIL: minlen is not set OR is less than $SET_MINPW_LENGTH."
        echo "$grep_query2"
        fail_flag=1
    fi

    if [[ $fail_flag -eq 0 ]]; then
        echo "PASS"
    else
        echo "FAIL"
        runFix "5.3.3.2.2" fixes/chap5/chap5_3/chap5_3_3/chap5_3_3_2/5_3_3_2_2.sh
    fi
}
