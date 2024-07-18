#!/bin/bash
source utils.sh
{
    # Run sshd -T command and grep for ClientAliveInterval and ClientAliveCountMax
    output=$(sshd -T | grep -Pi -- '(clientaliveinterval|clientalivecountmax)')

    # Check if both ClientAliveInterval and ClientAliveCountMax are present in output
    if [[ $output =~ clientaliveinterval[[:space:]]+([0-9]+) && $output =~ clientalivecountmax[[:space:]]+([0-9]+) ]]; then
        interval="${BASH_REMATCH[1]}"
        countmax="${BASH_REMATCH[2]}"
        if (( interval_value > 0 && countmax_value > 0 )); then
            echo "Audit Result: Pass"
        else
            echo "Audit Result: Fail - ClientAliveInterval or ClientAliveCountMax is not greater than 0."
            #Remediation 
            runFix "5.1.7" fixes/chap5/chap5_1/5_1_7.sh
        fi

    else
        echo "Audit Result: Fail"
        #Remediation currently not working
        runFix "5.1.7" fixes/chap5/chap5_1/5_1_7.sh
    fi
}