#!/usr/bin/bash
source utils.sh

# 5.1.15 Ensure sshd MACs are configured

{
output=$(sshd -T | grep -Pi -- 'macs\h+([^#\n\r]+,)?(hmac-md5|hmac-md5-96|hmac-ripemd160|hmac-sha1-96|umac-64@openssh\.com|hmac-md5-etm@openssh\.com|hmac-md5-96-etm@openssh\.com|hmac-ripemd160-etm@openssh\.com|hmac-sha1-96-etm@openssh\.com|umac-64-etm@openssh\.com|umac-128-etm@openssh\.com)\b')

if [[ -z "$output" ]]; then
    echo "Audit Result: Pass"
else
    echo "Audit Result: Fail"

    # Remediation
    runFix "5.1.15" fixes/chap5/chap5_1/chap5_1/5_1_15.sh
fi
}