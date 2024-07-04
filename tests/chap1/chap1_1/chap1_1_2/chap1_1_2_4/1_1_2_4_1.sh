#!/usr/bin/bash

# 1.1.2.4.1 Ensure separate partition exists for /var

{
    echo "Ensuring separate partition exists for /var (1.1.2.4.1)..."

    findmnt_output=$(findmnt -kn /var)

    if [[ -n "$findmnt_output" ]]; then
        echo "/var is mounted as a separate partition."
        echo "Output from findmnt:"
        echo "$findmnt_output"
        echo "Audit Result: PASS"
    else
        echo "/var is NOT mounted as a separate partition."
        echo "Audit Result: FAIL"
    fi
}
