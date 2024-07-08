#! /usr/bin/bash
source utils.sh

# 1.1.2.1.2 Ensure nodev option set on /tmp partition

{
    echo "Ensuring nodev option set on /tmp partition (1.1.2.1.2)..."
    findmnt_output=$(findmnt -kn /tmp | grep -v nodev)

    if [[ -z "$findmnt_output" ]]; then
        echo "Output from findmnt:"
        echo "$findmnt_output"
        echo "Audit Result: PASS"
    else
        echo "Output from findmnt:"
        echo "$findmnt_output"
        echo "Audit Result: FAIL"

        runFix "1.1.2.1.2" fixes/chap1/chap1_1/chap1_1_2/chap1_1_2_1/1_1_2_1_2.sh
    fi
}