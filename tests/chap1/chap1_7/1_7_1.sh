#!/usr/bin/bash
source utils.sh

{
    echo "Ensuring GDM is removed for servers (1.7.1)..."

    dpkg_output=$(dpkg-query -s gdm3 &>/dev/null && echo "gdm3 is installed")
    
    if [[ -z $dpkg_output ]]; then
        echo "Audit Result: PASS"
    else
        echo "Audit Result: FAIL"

        runFix "1.7.1" fixes/chap1/chap1_7/1_7_1.sh
    fi
}