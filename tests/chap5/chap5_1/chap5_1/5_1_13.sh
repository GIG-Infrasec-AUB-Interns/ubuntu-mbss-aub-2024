#! /usr/bin/bash
source utils.sh
# 5.1.13 Ensure sshd LoginGraceTime is configured

{
output=$(sshd -T | grep logingracetime)

login_grace_time=$(echo "$output" | awk '{print $2}')

if [[ "$login_grace_time" -ge 1 && "$login_grace_time" -le 60 ]]; then
    echo "Audit Result: Pass"
else
    echo "Audit Result: Fail"

    # Remediation
    runFix "5.1.13" fixes/chap5/chap5_1/chap5_1/5_1_13.sh  
fi
}