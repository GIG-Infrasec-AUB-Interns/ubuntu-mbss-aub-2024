#!/usr/bin/bash
source utils.sh
# 5.2.2 Ensure sudo commands use pty

{

    output=$(grep -rPi -- '^\s*Defaults\s+([^#\n\r]+,)?use_pty(,\s*\S+)*\s*(#.*)?$' /etc/sudoers* 2>/dev/null)
    output2=$(grep -rPi -- '^\h*Defaults\h+([^#\n\r]+,)?!use_pty(,\h*\h+\h*)*\h*(#.*)?$' /etc/sudoers*)
   
    if [[ "$output" == *"Defaults use_pty"* && -z "$output2" ]]; then
        echo "Audit Result: Pass"
    else
        echo "Audit Result: Fail"

        # Remediation
        runFix "5.2.2" fixes/chap5/chap5_2/5_2_2.sh  
    fi
}