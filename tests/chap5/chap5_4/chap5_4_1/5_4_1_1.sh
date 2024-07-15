#! /usr/bin/bash
source utils.sh
source globals.sh

{
    echo "Ensure password expiration is configured (5.4.1.1)..."

    max_days_flag=0
    max_days_user_flag=0

    max_days_output=$(grep -Pi -- '^\h*PASS_MAX_DAYS\h+\d+\b' /etc/login.defs)
    max_days=$(echo "$max_days_output" | grep -oP '\d+') # extract number
    

    if [[ $max_days -le $SET_PASS_MAX_DAYS ]]; then
        echo "Maximum number of days a password may be used is $PASS_MAX_DAYS days or less."
    else
        echo -e "The following users do not conform to site policy:\n$users_pass_over_max"
        max_days_flag=1
    fi

    users_pass_over_max=$(awk -F: '($2~/^\$.+\$/) {if($5 > 365 || $5 < 1)print "User: " $1 " PASS_MAX_DAYS: " $5}' /etc/shadow)

    if [[ -z $users_pass_over_max ]]; then
        echo "All users conform to site policy! (all passwords expire within 365 days or less)"
    else
        echo "The following users do not conform to site policy \n $users_pass_over_max"
        max_days_user_flag=1
    fi

    if [[ $max_days_flag -eq 1 ]] || [[ $max_days_user_flag -eq 1 ]]; then
        echo "FAIL"
        runFix "5.4.1.1" fixes/chap5/chap5_4/chap5_4_1/5_4_1_1.sh
    else
        echo "PASS"
    fi

}