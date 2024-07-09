#! /usr/bin/bash

# 1.1.2.3.3 Ensure nosuid option set on /home partition

{
    echo "Ensuring nodev option set on /home partition (1.1.2.3.3)..."
    findmnt_output=$(findmnt -kn /home | grep -v 'nosuid')

    if [[ -z "$findmnt_output" ]]; then
        echo "Output from findmnt:"
        echo "$findmnt_output"
        echo "Audit Result: PASS"
    else
        echo "Output from findmnt:"
        echo "$findmnt_output"
        echo "Audit Result: FAIL"
    fi
}