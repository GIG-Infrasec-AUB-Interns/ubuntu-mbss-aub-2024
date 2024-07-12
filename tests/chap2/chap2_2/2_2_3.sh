#! /usr/bin/bash
source utils.sh

{
    echo "Ensuring talk client is not installed (2.2.3)..."

    echo "Verifying talk client is not installed..."

    dpkg_output=$(dpkg-query -s talk &>/dev/null && echo "talk is installed")

    if [[ -z "$dpkg_output" ]]; then
        echo "Output from dpkg:"
        echo "$dpkg_output"
        echo "Audit Result: PASS"
    else
        echo "Output from dpkg:"
        echo "$dpkg_output"
        echo "Audit Result: FAIL"
        runFix "2.2.3" fixes/chap2/chap2_2/2_2_3.sh
    fi
}
