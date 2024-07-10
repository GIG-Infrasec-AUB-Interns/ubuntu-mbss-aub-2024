#! /usr/bin/bash

# 1.1.2.7.2 Ensure nodev option set on /var/log/audit partition

{
    echo "Ensuring nodev option set on /var/log/audit partition (1.1.2.7.2)..."
    findmnt_output=$(findmnt -kn /var/log/audit | grep -v 'nodev')

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