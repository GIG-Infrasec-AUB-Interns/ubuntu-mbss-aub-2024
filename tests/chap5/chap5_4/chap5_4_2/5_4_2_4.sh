#! /usr/bin/bash
source utils.sh
source globals.sh

{
    echo "Ensure root password is set (5.4.2.4)..."

    rootpw_output=$(passwd -S root | awk '$2 ~ /^P/ {print "User: \"" $1 "\" Password is set"}')

    if [[ $rootpw_output == 'User: "root" Password is set' ]]; then
        echo "PASS"
    else
        echo "FAIL"
        echo "Script output:"
        echo "$rootpw_output"
        runFix "5.4.2.4" fixes/chap5/chap5_4/chap5_4_2/5_4_2_4.sh
    fi
}