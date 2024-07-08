#!/usr/bin/bash
source utils.sh

{
    echo "Ensuring Automatic Error Reporting is not enabled  (1.5.5)..."

    dpkg_output=$(dpkg-query -s apport &> /dev/null && grep -Psi -- '^\h*enabled\h*=\h*[^0]\b' /etc/default/apport)
    
    if [[ -z $dpkg_output ]]; then
        echo "Audit Result: PASS"
    else
        echo "Audit Result: FAIL"
        
        runFix "1.5.5" fixes/chap1/chap1_5/1_5_5.sh
    fi
}