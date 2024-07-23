#!/usr/bin/bash
source utils.sh

# 5.1.17 Ensure sshd MaxSessions is configured

{
    output=$(sshd -T | grep -i maxsessions)
    grep_output=$(grep -Psi -- '^\h*MaxSessions\h+\"?(1[1-9]|[2-9][0-9]|[1-9][0-9][0-9]+)\b' /etc/ssh/sshd_config /etc/ssh/sshd_config.d/*.conf)
    max_sessions=$(echo "$output" | awk '{print $2}')

    if [[ "$max_sessions" -le 10 && -z "$grep_output" ]]; then
        echo "Audit Result: Pass"
    else
        echo "Audit Result: Fail"

        # Remediation
        runFix "5.1.17" fixes/chap5/chap5_1/chap5_1/5_1_17.sh  
    fi
}