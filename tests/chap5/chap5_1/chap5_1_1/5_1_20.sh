#! /usr/bin/bash
source utils.sh
# 5.1.20 Ensure sshd PermitRootLogin is disabled

{
output=$(sshd -T | grep permitrootlogin)

if [[ "$output" == "permitrootlogin no" ]]; then
    echo "Audit Result: Pass"

else
    echo "Audit Result: Fail"

    #Remediation 
    runFix "5.1.20" fixes/chap5/chap5_1/chap5_1_1/5_1_20.sh  
fi
}