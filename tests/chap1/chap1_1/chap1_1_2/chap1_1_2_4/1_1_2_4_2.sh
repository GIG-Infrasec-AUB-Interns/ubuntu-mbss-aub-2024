#! /usr/bin/bash

# 1.1.2.4.2 Ensure nodev option set on /var partition

{
    echo "Ensuring nodev option set on /var partition (1.1.2.4.2)..."
    findmnt_output=$(findmnt -kn /var | grep -v 'nodev')

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