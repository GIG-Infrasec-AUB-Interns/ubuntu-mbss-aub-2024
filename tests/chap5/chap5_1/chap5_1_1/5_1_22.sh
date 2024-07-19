#! /usr/bin/bash
source utils.sh
# 5.1.22 Ensure sshd UsePAM is enabled

{
output=$(sshd -T | grep -i usepam)

if [[ "$output" == "usepam yes" ]]; then
    echo "Audit Result: Pass"

else
    echo "Audit Result: Fail"

    #Remediation 
    runFix "5.1.22" fixes/chap5/chap5_1/chap5_1_1/5_1_22.sh  
fi
}