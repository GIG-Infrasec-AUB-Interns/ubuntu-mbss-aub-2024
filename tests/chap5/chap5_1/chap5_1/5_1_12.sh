#! /usr/bin/bash
source utils.sh
# 5.1.12 Ensure sshd KexAlgorithms is configured

{
    output=$(sshd -T | grep -Pi -- 'kexalgorithms\h+([^#\n\r]+,)?(diffie-hellman-group1-sha1|diffie-hellman-group14-sha1|diffie-hellman-group-exchange-sha1)\b')

    weak_kex='diffie-hellman-group1-sha1|diffie-hellman-group14-sha1|diffie-hellman-group-exchange-sha1'


    if echo "$output" | grep -Eq "$weak_kex"; then
        echo "Audit Result: Fail"
        echo "Weak Key Exchange Algorithms detected: "
        echo "$output" | grep -E "$weak_kex"
        #Remediation 
        runFix "5.1.12" fixes/chap5/chap5_1/chap5_1/5_1_12.sh
    else
        echo "Audit Result: Pass"
    fi
}