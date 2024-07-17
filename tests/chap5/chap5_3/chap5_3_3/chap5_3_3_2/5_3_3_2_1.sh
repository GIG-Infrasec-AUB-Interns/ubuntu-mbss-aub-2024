#!/usr/bin/bash
source utils.sh

{
    echo "Ensure password number of changed characters is configured (5.3.3.2.1)..."
    fail_flag=0

    grep_query=$(grep -Psi -- '^\h*difok\h*=\h*([2-9]|[1-9][0-9]+)\b' /etc/security/pwquality.conf /etc/security/pwquality.conf.d/*.conf)
    difok_value=$(echo "$grep_query" | awk -F '=' '{print $2}' | tr -d ' ')

    if [[ "$difok_value" -ge 2 ]]; then
        echo "PASS"
    else    
        echo "FAIL: difok option is NOT set to 2 or more."
        echo "$grep_query"
        fail_flag=1
    fi

    grep_query2=$(grep -Psi -- '^\h*password\h+(requisite|required|sufficient)\h+pam_pwquality\.so\h+([^#\n\r]+\h+)?difok\h*=\h*([0-1])\b' /etc/pam.d/common-password)

    if [[ -z "$grep_query2" ]]; then
        echo "PASS"
    else
        echo "FAIL: difok option is NOT set to 2 or more."
        echo "$grep_query2"
        fail_flag=1
    fi

    if [[ $grep_query -eq 0 ]]; then
        echo "PASS"
    else
        echo "FAIL"
        runFix "5.3.3.2.1" fixes/chap5/chap5_3/chap5_3_3/chap5_3_3_2/5_3_3_2_1.sh
    fi
}
