#!/usr/bin/bash
source utils.sh

{
 if grep -Pqs '^\h*0\b' /sys/module/ipv6/parameters/disable; then
    ipv6check=true
 else
    ipv6check=false
 fi

 if $ipv6check; then
    # Get the iptables policies for INPUT, FORWARD, and OUTPUT chains
    input_policy=$(ip6tables -L INPUT -n -v | grep -E '^Chain INPUT ' | awk '{print $4}')
    forward_policy=$(ip6tables -L FORWARD -n -v | grep -E '^Chain FORWARD ' | awk '{print $4}')
    output_policy=$(ip6tables -L OUTPUT -n -v | grep -E '^Chain OUTPUT ' | awk '{print $4}')

    # Check if all policies are DROP or REJECT
    if [[ ("$input_policy" == "DROP" || "$input_policy" == "REJECT") && \
        ("$forward_policy" == "DROP" || "$forward_policy" == "REJECT") && \
        ("$output_policy" == "DROP" || "$output_policy" == "REJECT") ]]; then
        echo "Audit Result: Pass"
    else
        echo "Audit Result: Fail"
        #Remediation
        runFix "4.3.3.1" fixes/chap4/chap4_3/chap4_3_3/chap4_3_3_1.sh
    fi
}
