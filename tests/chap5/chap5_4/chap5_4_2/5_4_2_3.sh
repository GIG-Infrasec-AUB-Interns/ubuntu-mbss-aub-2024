#! /usr/bin/bash
source utils.sh
source globals.sh

{
    echo "Ensure group root is the only GID 0 group (5.4.2.3)..."

    gid_0_groups=$(awk -F: '$3=="0"{print $1":"$3}' /etc/group)

    if [[ $gid_0_groups == "root:0" ]]; then
        echo "PASS"
    else
        echo "FAIL"
        runFix "5.4.2.3" fixes/chap5/chap5_4/chap5_4_2/5_4_2_3.sh
    fi
}