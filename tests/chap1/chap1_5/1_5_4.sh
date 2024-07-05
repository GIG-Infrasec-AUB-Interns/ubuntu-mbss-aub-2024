#!/usr/bin/bash

{
    dpkg_output=$(dpkg-query -s prelink &>/dev/null && echo "prelink is installed")

    if [[ -z $dpkg_output ]]; then
        echo "Audit Result: PASS"
    else
        echo "Audit Result: FAIL"
    fi
}