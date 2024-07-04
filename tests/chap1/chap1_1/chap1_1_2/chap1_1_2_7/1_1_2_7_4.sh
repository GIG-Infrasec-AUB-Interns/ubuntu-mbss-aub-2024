#! /usr/bin/bash

# 1.1.2.7.4 Ensure noexec option set on /var/log/audit partition

{
    echo "Ensuring noexec option set on /var/log/audit partition (1.1.2.7.4)..."
    findmnt_output=$(findmnt -kn /var/log/audit | grep -v 'noexec')

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