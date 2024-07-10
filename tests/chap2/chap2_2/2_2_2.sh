#! /usr/bin/bash
source utils.sh

{
    echo "Ensuring rsh client is not installed (2.2.2)..."

    echo "Verifying rsh client is not installed..."

    dpkg_output=$(dpkg-query -s rsh-client &>/dev/null && echo "rsh-client is installed")

    if [[ -z "$dpkg_output" ]]; then
        echo "Output from dpkg:"
        echo "$dpkg_output"
        echo "Audit Result: PASS"
    else
        echo "Output from dpkg:"
        echo "$dpkg_output"
        echo "Audit Result: FAIL"
        runFix "2.2.2" fixes/chap2/chap2_2/2_2_2.sh
    fi
}
