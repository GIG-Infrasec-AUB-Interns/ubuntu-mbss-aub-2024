#!/bin/bash
source utils.sh

# Get the iptables policies for INPUT, FORWARD, and OUTPUT chains
input_policy=$(iptables -L INPUT -n -v | grep -E '^Chain INPUT ' | awk '{print $4}')
forward_policy=$(iptables -L FORWARD -n -v | grep -E '^Chain FORWARD ' | awk '{print $4}')
output_policy=$(iptables -L OUTPUT -n -v | grep -E '^Chain OUTPUT ' | awk '{print $4}')

# Check if all policies are DROP or REJECT
if [[ ("$input_policy" == "DROP" || "$input_policy" == "REJECT") && \
      ("$forward_policy" == "DROP" || "$forward_policy" == "REJECT") && \
      ("$output_policy" == "DROP" || "$output_policy" == "REJECT") ]]; then
    echo "Audit Result: Pass"
else
    echo "Audit Result: Fail"
    #Remediation
    runFix "4.3.2.1" fixes/chap4/chap4_3/chap4_3_2/chap4_3_2_1.sh
