#! /usr/bin/bash
source utils.sh
# 5.1.21 Ensure sshd PermitUserEnvironment is disabled 

{
output=$(sshd -T | grep permituserenvironment)

if [[ "$output" == "permituserenvironment no" ]]; then
    echo "Audit Result: Pass"

else
    echo "Audit Result: Fail"

    #Remediation 
    runFix "5.1.21" fixes/chap5/chap5_1/chap5_1_1/5_1_21.sh  
fi
}