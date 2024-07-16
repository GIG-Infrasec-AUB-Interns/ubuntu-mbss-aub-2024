#! /usr/bin/bash
source utils.sh
source globals.sh

{
    echo "Ensure root is the only UID 0 account (5.4.2.1)..."

    root_output=$(awk -F: '($3 == 0) { print $1 }' /etc/passwd)

    if [[ $root_output == "root" ]]; then
        echo "PASS"
    else
        echo "FAIL"
        runFix "5.4.2.1" fixes/chap5/chap5_4/chap5_4_2/5_4_2_1.sh
    fi
}