#! /usr/bin/bash

# 1.1.2.5.3 Ensure nosuid option set on /var/tmp partition

{
    echo "Ensuring nodev option set on /var/tmp partition (1.1.2.5.3)..."
    findmnt_output=$(findmnt -kn /var/tmp | grep -v 'nosuid')

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