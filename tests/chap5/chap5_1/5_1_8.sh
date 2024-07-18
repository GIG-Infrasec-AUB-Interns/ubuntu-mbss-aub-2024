#! /usr/bin/bash
source utils.sh
# 5.1.8 Ensure sshd DisableForwarding is enabled

{
output=$( sshd -T | grep -i disableforwarding)

if [[ "$output" == "disableforwarding yes" ]]; then
    echo "Audit Result: Pass"

else
    echo "Audit Result: Fail"

    #Remediation 
    runFix "5.1.8" fixes/chap5/chap5_1/5_1_8.sh  
fi
}