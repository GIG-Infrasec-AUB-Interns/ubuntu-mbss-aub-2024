#!/usr/bin/bash
source utils.sh
source globals.sh

{
    echo "Ensure minimum password length is configured (5.3.3.2.2)..."
    fail_flag=0

    # Extract the minlen value from the configuration files
    grep_query=$(grep -Pi -- '^\h*minlen\h*=\h*\d+\b' /etc/security/pwquality.conf /etc/security/pwquality.conf.d/*.conf)
    pw_length=$(echo "$grep_query" | awk -F '=' '{print $2}' | tr -d ' ')

    if [[ -n "$pw_length" && "$pw_length" -ge $SET_MINPW_LENGTH ]]; then
        echo "PASS: Minimum password length is set to $pw_length."
    else    
        echo "FAIL: Minimum password length is less than $SET_MINPW_LENGTH."
        echo "$grep_query"
        fail_flag=1
    fi

    # Check for minlen settings in PAM configuration files
    grep_query2=$(grep -Pi -- '^\h*password\h+(requisite|required|sufficient)\h+pam_pwquality\.so\h+([^#\n\r]+\h+)?minlen\h*=\h*([0-9]|1[0-3])\b' /etc/pam.d/system-auth /etc/pam.d/common-password)

    if [[ -z "$grep_query2" ]]; then
        echo "PASS: No incorrect minlen settings found in PAM configuration."
    else
        echo "FAIL: minlen is not set OR is less than $SET_MINPW_LENGTH in PAM configuration."
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
