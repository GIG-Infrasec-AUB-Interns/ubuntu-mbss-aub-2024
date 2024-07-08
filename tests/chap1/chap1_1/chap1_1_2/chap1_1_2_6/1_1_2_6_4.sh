#! /usr/bin/bash

# 1.1.2.6.4 Ensure noexec option set on /var/log partition

{
    echo "Ensuring noexec option set on /var/log partition (1.1.2.6.4)..."
    findmnt_output=$(findmnt -kn /var/log | grep -v 'noexec')

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