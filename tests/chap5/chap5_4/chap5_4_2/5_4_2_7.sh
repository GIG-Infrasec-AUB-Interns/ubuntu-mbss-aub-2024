#! /usr/bin/bash
source utils.sh
source globals.sh

{
    echo "Ensure system accounts do not have a valid login shell (5.4.2.7)..."

    l_valid_shells="^($(awk -F\/ '$NF != "nologin" {print}' /etc/shells | sed -rn '/^\//{s,/,\\\\/,g;p}' | paste -s -d '|' - ))$" 
    script_output=$(awk -v pat="$l_valid_shells" -F: '($1!~/^(root|halt|sync|shutdown|nfsnobody)$/ && ($3<'"$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)"' || $3 == 65534) && $(NF) ~ pat) {print "Service account: \"" $1 "\" has a valid shell: " $7}' /etc/passwd)

    if [[ -z $script_output ]]; then
        echo "PASS"
    else
        echo "FAIL"
        echo "Script output:"
        echo "$script_output"
        runFix "5.4.2.7" fixes/chap5/chap5_4/chap5_4_2/5_4_2_7.sh
    fi
}