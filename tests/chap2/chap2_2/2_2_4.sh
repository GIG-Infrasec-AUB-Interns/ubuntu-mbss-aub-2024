#! /usr/bin/bash
source utils.sh

{
    echo "Ensuring telnet client is not installed (2.2.4)..."

    echo "Verifying telnet client is not installed..."

    dpkg_output=$(dpkg-query -s telnet &>/dev/null && echo "telnet is installed")

    if [[ -z "$dpkg_output" ]]; then
        echo "Output from dpkg:"
        echo "$dpkg_output"
        echo "Audit Result: PASS"
    else
        echo "Output from dpkg:"
        echo "$dpkg_output"
        echo "Audit Result: FAIL"
        runFix "2.2.4" fixes/chap2/chap2_2/2_2_4.sh
    fi
}
