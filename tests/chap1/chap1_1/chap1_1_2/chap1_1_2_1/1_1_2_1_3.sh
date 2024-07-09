#! /usr/bin/bash
source utils.sh

# 1.1.2.1.3 Ensure nosuid option set on /tmp partition

{
    echo "Ensure nosuid option set on /tmp partition (1.1.2.1.3)..."
    findmnt_output=$(findmnt -kn /tmp | grep -v nosuid)

    if [[ -z "$findmnt_output" ]]; then
        echo "Output from findmnt:"
        echo "$findmnt_output"
        echo "Audit Result: PASS"
    else
        echo "Output from findmnt:"
        echo "$findmnt_output"
        echo "Audit Result: FAIL"

        runFix "1.1.2.1.3" fixes/chap1/chap1_1/chap1_1_2/chap1_1_2_1/1_1_2_1_3.sh
    fi
}