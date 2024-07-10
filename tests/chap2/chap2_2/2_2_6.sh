#! /usr/bin/bash
source utils.sh

{
    echo "Ensuring ftp client is not installed (2.2.6)..."

    echo "Verifying ftp client is not installed..."

    dpkg_output=$(dpkg-query -s ftp &>/dev/null && echo "ftp is installed")

    if [[ -z "$dpkg_output" ]]; then
        echo "Output from dpkg:"
        echo "$dpkg_output"
        echo "Audit Result: PASS"
    else
        echo "Output from dpkg:"
        echo "$dpkg_output"
        echo "Audit Result: FAIL"
        runFix "2.2.6" fixes/chap2/chap2_2/2_2_6.sh
    fi
}
