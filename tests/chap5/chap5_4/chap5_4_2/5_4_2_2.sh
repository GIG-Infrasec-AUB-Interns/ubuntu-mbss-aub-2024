#! /usr/bin/bash
source utils.sh
source globals.sh

{
    echo "Ensure root is the only GID 0 account (5.4.2.2)..."

    gid_0_users=$(awk -F: '($1 !~ /^(sync|shutdown|halt|operator)/ && $4=="0") {print $1":"$4}' /etc/passwd )

    if [[ $gid_0_users == "root:0" ]]; then
        echo "PASS"
    else
        echo "FAIL"
        echo "Accounts with GID 0:"
        echo "$gid_0_users"
        runFix "5.4.2.2" fixes/chap5/chap5_4/chap5_4_2/5_4_2_2.sh
    fi
}