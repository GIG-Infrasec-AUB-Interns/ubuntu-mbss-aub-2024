#! /usr/bin/bash

# 1.1.2.5.4 Ensure noexec option set on /var/tmp partition

{
    echo "Ensuring noexec option set on /var/tmp partition (1.1.2.5.4)..."
    findmnt_output=$(findmnt -kn /var/tmp | grep -v 'noexec')

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