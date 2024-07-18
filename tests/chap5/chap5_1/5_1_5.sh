 
#! /usr/bin/bash

# 5.1.5 Ensure sshd Banner is configured

{
output=$( sshd -T | grep -Pi -- '^banner\h+\/\H+')

if [[ "$output" == "banner /etc/issue.net" ]]; then
    echo "Audit Result: Pass"
    echo "Banner configured"
else
    echo "Audit Result: Fail"

    #Remediation 
    runFix "5.1.5" fixes/chap5/chap5_1/5_1_5.sh  
fi
}