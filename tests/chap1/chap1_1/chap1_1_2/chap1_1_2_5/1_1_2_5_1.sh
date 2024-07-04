#!/usr/bin/bash

# 1.1.2.5.1 Ensure separate partition exists for /var/tmp

{
    echo "Ensuring separate partition exists for /var/tmp (1.1.2.5.1)..."

    findmnt_output=$(findmnt -kn /var/tmp)

    if [[ -n "$findmnt_output" ]]; then
        echo "/var/tmp is mounted as a separate partition."
        echo "Output from findmnt:"
        echo "$findmnt_output"
        echo "Audit Result: PASS"
    else
        echo "/var/tmp is NOT mounted as a separate partition."
        echo "Audit Result: FAIL"
    fi
}
