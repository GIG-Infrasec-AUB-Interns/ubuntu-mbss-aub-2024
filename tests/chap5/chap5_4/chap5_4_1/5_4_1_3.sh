#!/usr/bin/bash
source utils.sh
source globals.sh

{
    echo "Ensure password expiration warning days is configured (5.4.1.3)..."

    warn_age_flag=0
    warn_age_user_flag=0

    # Check the PASS_WARN_AGE value in /etc/login.defs
    warn_age_output=$(grep -Pi -- '^\h*PASS_WARN_AGE\h+\d+\b' /etc/login.defs)
    warn_age=$(echo "$warn_age_output" | grep -oP '\d+') # extract number
    
    if [[ $warn_age -ge $SET_WARN_AGE ]]; then
        echo "PASS: The number of days a warning is given before a password expires is $warn_age days."
    else
        echo "FAIL: The number of days a warning is given before a password expires is less than $SET_WARN_AGE days!"
        warn_age_flag=1
    fi

    # Check user password warning age in /etc/shadow
    users_pass_less_warn_age=$(awk -F: '($2~/^\$.+\$/) {if($6 < '$SET_WARN_AGE')print "User: " $1 " PASS_WARN_AGE: " $6}' /etc/shadow)

    if [[ -z $users_pass_less_warn_age ]]; then
        echo "All users conform to site policy! (all users are given warnings $SET_WARN_AGE days (or more) before a password expires)"
    else
        echo "The following users do not conform to site policy \n $users_pass_less_warn_age"
        warn_age_user_flag=1
    fi

    if [[ $warn_age_flag -eq 1 ]] || [[ $warn_age_user_flag -eq 1 ]]; then
        echo "FAIL"
        runFix "5.4.1.3" fixes/chap5/chap5_4/chap5_4_1/5_4_1_3.sh
    else
        echo "PASS"
    fi
}
