#!/usr/bin/bash
source utils.sh

# 5.1.14 Ensure sshd LogLevel is configured

{
output=$(sshd -T | grep loglevel)

loglevel=$(echo "$output" | awk '{print $2}')

if [[ "$loglevel" == "VERBOSE" || "$loglevel" == "INFO" ]]; then
    echo "Audit Result: Pass"
else
    echo "Audit Result: Fail"

    # Remediation
    runFix "5.1.14" fixes/chap5/chap5_1/chap5_1/5_1_14.sh
fi
}