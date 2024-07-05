#! /usr/bin/bash

# 3.1.1  Ensure IPv6 status is identified

{
grep_output=$(grep -Pqs '^\h*0\b' /sys/module/ipv6/parameters/disable && echo -e "\n - IPv6 is enabled\n" || echo -e "\n - IPv6 is not enabled\n")

echo "grep output: [$grep_output]"

if [[ "$grep_output" == $'\n - IPv6 is enabled\n' ]]; then
    echo "Audit Result: Pass"
else
    echo "Audit Result: Fail"
fi
}