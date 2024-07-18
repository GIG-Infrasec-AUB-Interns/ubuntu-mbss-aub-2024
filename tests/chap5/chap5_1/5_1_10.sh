#! /usr/bin/bash
source utils.sh
# 5.1.10 Ensure sshd HostbasedAuthentication is disabled 

{
output=$(sshd -T | grep hostbasedauthentication)

if [[ "$output" == "hostbasedauthentication no" ]]; then
    echo "Audit Result: Pass"

else
    echo "Audit Result: Fail"

    #Remediation 
    runFix "5.1.10" fixes/chap5/chap5_1/5_1_10.sh  
fi
}