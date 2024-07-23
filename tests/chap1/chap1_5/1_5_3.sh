#!/usr/bin/bash
source utils.sh

{
    echo "Ensuring core dumps are restricted (1.5.3)..."
    fail_flag=0
    grep_output=$(grep -Ps -- '^\h*\*\h+hard\h+core\h+0\b' /etc/security/limits.conf /etc/security/limits.d/*)

    if [[ $grep_output | grep "* hard core 0" ]]; then
        echo "PASS: * hard core 0 is set"
    else
        echo "FAIL: * hard core 0 is NOT set"
        fail_flag=1
    fi

    






    if [[ $fail_flag -eq 1 ]]; then
        echo "Audit Result: PASS"
    else
        echo "Audit Result: FAIL"
        runFix "1.5.3" fixes/chap1/chap1_5/1_5_3.sh
    fi
}


    if [[ $fail_flag -eq 1 ]]; then
        echo "Audit Result: PASS"
    else
        echo "Audit Result: FAIL"
        runFix "1.5.3" fixes/chap1/chap1_5/1_5_3.sh
    fi
}