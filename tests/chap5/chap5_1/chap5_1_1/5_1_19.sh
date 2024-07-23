#! /usr/bin/bash
source utils.sh
# 5.1.19 Ensure sshd PermitEmptyPasswords is disabled

{
output=$(sshd -T | grep permitemptypasswords)

if [[ "$output" == "permitemptypasswords no" ]]; then
    echo "Audit Result: Pass"

else
    echo "Audit Result: Fail"

    #Remediation 
    runFix "5.1.19" fixes/chap5/chap5_1/chap5_1_1/5_1_19.sh  
fi
}