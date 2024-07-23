#! /usr/bin/bash
source utils.sh
# 5.1.11 Ensure sshd IgnoreRhosts is enabled

{
output=$(sshd -T | grep ignorerhosts)

if [[ "$output" == "ignorerhosts yes" ]]; then
    echo "Audit Result: Pass"

else
    echo "Audit Result: Fail"

    #Remediation 
    runFix "5.1.11" fixes/chap5/chap5_1/chap5_1/5_1_11.sh  
fi
}