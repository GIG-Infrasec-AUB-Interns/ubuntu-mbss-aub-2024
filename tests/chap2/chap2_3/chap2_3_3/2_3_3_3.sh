#!/usr/bin/bash
source utils.sh

{
    echo "Ensuring chrony is enabled and running (2.3.3.3)..."
    systemctl_1=$(systemctl is-enabled chrony.service)
    systemctl_2=$(systemctl is-active chrony.service)
    
    echo "Output from systemctl_1:"
    echo "$systemctl_1"
    echo "Output from systemctl_2:"
    echo "$systemctl_2"

    if [[ "$systemctl_1" == "enabled" ]] && [[ "$systemctl_2" == "active" ]]; then
        echo "Audit Result: PASS"
    else
        echo "Audit Result: FAIL"
        runFix "2.3.3.3" fixes/chap2/chap2_3/chap2_3_3/2_3_3_3.sh
    fi
}