#!/usr/bin/bash
source utils.sh
source globals.sh

{
    echo "Ensure inactive password lock is configured (5.4.1.5)..."
    inactive_flag=0
    inactive_user_flag=0
    
    inactive_output=$(useradd -D | grep INACTIVE)
    inactive_value=$(echo $inactive_output | grep -oP '\d+')

    if [[ $inactive_value -ge $SET_INACTIVEPW_LOCK || $inactive_value -lt 0 ]]; then
        inactive_flag=1
        echo "Inactive value is more than $SET_INACTIVEPW_LOCK days! ($inactive_value)"
    else
        echo "Inactive value correctly set to $inactive_value"
    fi

    # check inactive value of users
    inactive_user_output=$(awk -F: '($2~/^\$.+\$/) {if($7 > 45 || $7 < 0)print "User: " $1 " INACTIVE: " $7}' /etc/shadow)

    if [[ -z $inactive_user_output ]]; then
        echo "All users conform to site policy! (Inactive value correctly set to $inactive_value or less)"
    else
        echo -e "The following users do not conform to site policy \n $inactive_user_output"
        inactive_user_flag=1
    fi

    if [[ $inactive_flag -eq 1 ]] || [[ $inactive_user_flag -eq 1 ]]; then
        echo "FAIL"
        runFix "5.4.1.5" fixes/chap5/chap5_4/chap5_4_1/5_4_1_5.sh
    else
        echo "PASS"
    fi
}
