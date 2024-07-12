#!/usr/bin/bash
source utils.sh

{
    echo "Ensuring systemd-timesyncd is enabled and running (2.3.2.2)..."
    systemctl_1=$(systemctl is-enabled systemd-timesyncd.service)
    systemctl_2=$(systemctl is-active systemd-timesyncd.service)
    
    if [[ "$systemctl_1" == "enabled" ]] && [[ "$systemctl_2" == "active" ]]; then
        echo "Output from systemctl_1:"
        echo "$systemctl_1"
        echo "Output from systemctl_2:"
        echo "$systemctl_2"
        echo "Audit Result: PASS"
    else
        echo "Output from systemctl_1:"
        echo "$systemctl_1"
        echo "Output from systemctl_2:"
        echo "$systemctl_2"
        echo "Audit Result: FAIL"
        runFix "2.3.2.2" fixes/chap2/chap2_3/chap2_3_2/2_3_2_2.sh
    fi
}