#!/usr/bin/bash
source utils.sh

# 5.1.16 Ensure sshd MaxAuthTries is configured

{
    output=$(sshd -T | grep maxauthtries)

    max_auth_tries=$(echo "$output" | awk '{print $2}')

    if [[ "$max_auth_tries" -le 4 ]]; then
        echo "Audit Result: Pass"
    else
        echo "Audit Result: Fail"

        # Remediation
        runFix "5.1.16" fixes/chap5/chap5_1/chap5_1/5_1_16.sh  
    fi
}