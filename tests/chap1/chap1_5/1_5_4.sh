#!/usr/bin/bash
source utils.sh

{
    echo "Ensuring prelink is not installed (1.5.4)..."

    dpkg_output=$(dpkg-query -s prelink &>/dev/null && echo "prelink is installed")

    if [[ -z $dpkg_output ]]; then
        echo "Audit Result: PASS"
    else
        echo "Audit Result: FAIL"

        runFix "1.5.4" fixes/chap1/chap1_5/1_5_4.sh

    fi
}