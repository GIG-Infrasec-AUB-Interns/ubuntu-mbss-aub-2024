#! /usr/bin/bash
source utils.sh
# 5.1.9 Ensure sshd GSSAPIAuthentication is disabled

{
output=$(sshd -T | grep gssapiauthentication)

if [[ "$output" == "gssapiauthentication no" ]]; then
    echo "Audit Result: Pass"

else
    echo "Audit Result: Fail"

    #Remediation 
    runFix "5.1.9" fixes/chap5/chap5_1/5_1_9.sh  
fi
}