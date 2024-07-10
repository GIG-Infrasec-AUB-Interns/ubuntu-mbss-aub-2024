#! /usr/bin/bash
source utils.sh

{
    echo "Ensuring NIS Client is not installed (2.2.1)..."

    echo "Verifying NIS Client is not installed..."

    dpkg_output=$(dpkg-query -s nis &>/dev/null && echo "nis is installed")

    if [[ -z "$dpkg_output" ]]; then
        echo "Output from dpkg:"
        echo "$dpkg_output"
        echo "Audit Result: PASS"
    else
        echo "Output from dpkg:"
        echo "$dpkg_output"
        echo "Audit Result: FAIL"
        runFix "2.2.1" fixes/chap2/chap2_2/2_2_1.sh
    fi
}
