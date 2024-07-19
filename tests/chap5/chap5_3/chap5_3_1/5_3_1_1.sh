#!/usr/bin/bash
source utils.sh

{
    echo "Ensure latest version of pam is installed (5.3.1.1)..."

    query_output=$(dpkg-query -s libpam-runtime | grep -P -- '^(Status|Version)\b')
    
    if [[ $(echo "$query_output" | grep "Status: install ok installed") && $(echo "$query_output" | grep "Version" | awk '{print $2}') > "1.5.2-6" ]]; then
        echo "Audit Result: PASS"
    else
        echo "Audit Result: FAIL"
        runFix "5.3.1.1" fixes/chap5/chap5_3/chap5_3_1/5_3_1_1.sh
    fi
}
