#!/usr/bin/bash

# 1.1.2.3.1 Ensure separate partition exists for /home

{
    echo "Ensuring separate partition exists for /home (1.1.2.3.1)..."

    findmnt_output=$(findmnt -kn /home)

    if [[ -n "$findmnt_output" ]]; then
        echo "/home is mounted as a separate partition."
        echo "Output from findmnt:"
        echo "$findmnt_output"
        echo "Audit Result: PASS"
    else
        echo "/home is NOT mounted as a separate partition."
        echo "Audit Result: FAIL"
    fi
}
