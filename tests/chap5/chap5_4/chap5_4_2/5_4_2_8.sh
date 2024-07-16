#! /usr/bin/bash
source utils.sh
source globals.sh

{
    echo "Ensure accounts without a valid login shell are locked (5.4.2.8)..."

    l_valid_shells="^($(awk -F\/ '$NF != "nologin" {print}' /etc/shells | sed -rn '/^\//{s,/,\\\\/,g;p}' | paste -s -d '|' - ))$" 
    script_output=$(
        while IFS= read -r l_user; do 
            passwd -S "$l_user" | awk '$2 !~ /^L/ {print "Account: \"" $1 "\" does not have a valid login shell and is not locked"}' 
        done < <(awk -v pat="$l_valid_shells" -F: '($1 != "root" && $(NF) !~ pat) {print $1}' /etc/passwd) 
    )

    if [[ -z $script_output ]]; then
        echo "PASS"
    else
        echo "FAIL"
        echo "Script output:"
        echo "$script_output"
        runFix "5.4.2.8" fixes/chap5/chap5_4/chap5_4_2/5_4_2_8.sh
    fi
}
