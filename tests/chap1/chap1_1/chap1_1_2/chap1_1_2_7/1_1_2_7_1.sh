#!/usr/bin/bash

# 1.1.2.7.1 Ensure separate partition exists for /var/log/audit

{
    echo "Ensuring separate partition exists for /var/log/audit (1.1.2.7.1)..."

    findmnt_output=$(findmnt -kn /var/log/audit)

    if [[ -n "$findmnt_output" ]]; then
        echo "/var/log is mounted as a separate partition."
        echo "Output from findmnt:"
        echo "$findmnt_output"
        echo "Audit Result: PASS"
    else
        echo "/var/log is NOT mounted as a separate partition."
        echo "Audit Result: FAIL"
    fi
}
