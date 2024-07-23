#!/usr/bin/bash
source utils.sh

# 5.1.18 Ensure sshd MaxStartups is configured

{
    output=$(sshd -T | awk '$1 ~ /^\s*maxstartups/{split($2, a, ":");{if(a[1] > 10 || a[2] > 30 || a[3] > 60) print $0}}')

    if [[ -z "$output" ]]; then
        echo "Audit Result: Pass"
    else
        echo "Audit Result: Fail"

        # Remediation
        runFix "5.1.18" fixes/chap5/chap5_1/chap5_1/5_1_18.sh
    fi
}