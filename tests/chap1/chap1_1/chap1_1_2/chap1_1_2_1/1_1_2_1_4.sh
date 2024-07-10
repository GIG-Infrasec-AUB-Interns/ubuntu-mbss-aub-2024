#! /usr/bin/bash
source utils.sh

# 1.1.2.1.4 Ensure noexec option set on /tmp partition

{
    echo "Ensure noexec option set on /tmp partition (1.1.2.1.4)..."
    findmnt_output=$(findmnt -kn /tmp | grep -v noexec)

    if [[ -z "$findmnt_output" ]]; then
        echo "Output from findmnt:"
        echo "$findmnt_output"
        echo "Audit Result: PASS"
    else
        echo "Output from findmnt:"
        echo "$findmnt_output"
        echo "Audit Result: FAIL"

        runFix "1.1.2.1.1" fixes/chap1/chap1_1/chap1_1_2/chap1_1_2_1/1_1_2_1_1.sh
    fi
}