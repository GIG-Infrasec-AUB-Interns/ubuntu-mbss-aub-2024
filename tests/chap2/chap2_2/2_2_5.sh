#! /usr/bin/bash
source utils.sh

{
    echo "Ensuring ldap client is not installed (2.2.5)..."

    echo "Verifying ldap client is not installed..."

    dpkg_output=$(dpkg-query -s ldap-utils &>/dev/null && echo "ldap-utils is installed")

    if [[ -z "$dpkg_output" ]]; then
        echo "Output from dpkg:"
        echo "$dpkg_output"
        echo "Audit Result: PASS"
    else
        echo "Output from dpkg:"
        echo "$dpkg_output"
        echo "Audit Result: FAIL"
        runFix "2.2.5" fixes/chap2/chap2_2/2_2_5.sh
    fi
}
