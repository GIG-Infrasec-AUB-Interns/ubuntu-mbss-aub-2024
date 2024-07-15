#! /usr/bin/bash
source utils.sh
source globals.sh

{
    echo "Ensure minimum password age is configured (5.4.1.2)..."

    min_days_flag=0
    min_days_user_flag=0

    min_days_output=$(grep -Pi -- '^\h*PASS_MIN_DAYS\h+\d+\b' /etc/login.defs)
    min_days=$(echo "$min_days_output" | grep -oP '\d+') # extract number
    

    if [[ $min_days -ge $SET_PASS_MIN_DAYS ]]; then
        echo "Minimum number of days between password changes is $min_days days or more."
    else
        echo "Minimum number of days between password changes is less than $SET_PASS_MIN_DAYS days!"
        min_days_flag=1
    fi

    users_pass_less_than_min=$(awk -F: '($2~/^\$.+\$/) {if($4 < 1)print "User: " $1 " PASS_MIN_DAYS: " $4}' /etc/shadow)

    if [[ -z $users_pass_less_than_min ]]; then
        echo "All users conform to site policy! (all passwords expire within $SET_PASS_MIN_DAYS days or more)"
    else
        echo "The following users do not conform to site policy \n $users_pass_over_max"
        min_days_user_flag=1
    fi

    if [[ $min_days_flag -eq 1 ]] || [[ $min_days_user_flag -eq 1 ]]; then
        echo "FAIL"
        runFix "5.4.1.2" fixes/chap5/chap5_4/chap5_4_1/5_4_1_2.sh
    else
        echo "PASS"
    fi
}