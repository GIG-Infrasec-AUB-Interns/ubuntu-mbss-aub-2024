#! /usr/bin/bash
source utils.sh
# 5.2.1 Ensure sudo is installed

{
output=$(dpkg-query -s sudo &>/dev/null && echo "sudo is installed")

if [[ "$output" == "sudo is installed" ]]; then
    echo "Audit Result: Pass"

else
    echo "Audit Result: Fail"

    #Remediation 
    runFix "5.2.1" fixes/chap5/chap5_2/5_2_1.sh  
fi
}