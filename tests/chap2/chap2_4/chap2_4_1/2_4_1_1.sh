#!/usr/bin/bash
source utils.sh

{
    echo "Ensuring cron daemon is enabled and active (2.4.1.1)..."
    systemctl_1=$(systemctl list-unit-files | awk '$1~/^crond?\.service/{print $2}')
    systemctl_2=$(systemctl list-units | awk '$1~/^crond?\.service/{print $3}')
    
    echo "Output from systemctl_1:"
    echo "$systemctl_1"
    echo "Output from systemctl_2:"
    echo "$systemctl_2"

    if [[ "$systemctl_1" == "enabled" ]] && [[ "$systemctl_2" == "active" ]]; then
        echo "Audit Result: PASS"
    else
        echo "Audit Result: FAIL"
        runFix "2.4.1.1" fixes/chap2/chap2_4/chap2_4_1/2_4_1_1.sh
    fi
}