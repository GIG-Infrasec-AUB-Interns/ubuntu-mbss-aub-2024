#! /usr/bin/bash
source utils.sh

{
    echo "Ensuring chrony is running as user _chrony (2.3.3.2)..."
    ps_output=$(ps -ef | awk '(/[c]hronyd/ && $1!="_chrony") { print $1 }')

    echo "Output from ps:"
    echo "$ps_output"

    if [[ -z "$ps_output" ]]; then
        echo "Audit Result: PASS"
    else
        echo "Audit Result: FAIL"
        runFix "2.3.3.2" fixes/chap2/chap2_3/chap2_3_3/2_3_3_2.sh
    fi
}
