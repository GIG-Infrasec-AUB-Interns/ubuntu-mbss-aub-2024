#!/usr/bin/bash
source utils.sh
source globals.sh

{
    echo "Ensure all users last password change date is in the past (5.4.1.6)..."
    script_output=$(
        while IFS= read -r l_user; do 
            l_change=$(date -d "$(chage --list $l_user | grep '^Last password change' | cut -d: -f2 | grep -v 'never$')" +%s) 
            if [[ "$l_change" -gt "$(date +%s)" ]]; then 
                echo "User: \"$l_user\" last password change was \"$(chage --list $l_user | grep '^Last password change' | cut -d: -f2)\"" 
            fi 
        done < <(awk -F: '$2~/^\$.+\$/{print $1}' /etc/shadow) 
    )
    
    if [[ -z $script_output ]]; then
        echo "PASS"
    else
        echo "FAIL"
        echo "Investigate any users with a password change date in the future and correct them."
        echo "Manually locking the account, expiring the password, or resetting the password manually may be appropriate."
    fi
}
