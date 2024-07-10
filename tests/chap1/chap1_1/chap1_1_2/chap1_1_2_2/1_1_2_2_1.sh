#! /usr/bin/bash
source utils.sh

# 1.1.2.2.1 Ensure /dev/shm is a separate partition

{
    echo "Ensuring /dev/shm is a separate partition (1.1.2.2.1)..."

    findmnt_output=$(findmnt -kn /dev/shm)

    if [[ -n "$findmnt_output" ]]; then
        echo "/dev/shm is mounted as a separate partition."
        echo "Output from findmnt:"
        echo "$findmnt_output"
        echo "Audit Result: PASS"
    else
        echo "/dev/shm is NOT mounted as a separate partition."
        echo "Audit Result: FAIL"
        runFix "1.1.2.2.1" fixes/chap1/chap1_1/chap1_1_2/chap1_1_2_2/1_1_2_2_1.sh
    fi
}