#! /usr/bin/bash

# 1.1.2.1.1 Ensure /tmp is a separate partition

{
    echo "Ensuring /tmp is a separate partition (1.1.2.1.1)..."

    findmnt_output=$(findmnt -kn /tmp)
    systemctl_output=$(systemctl is-enabled tmp.mount 2>/dev/null)

    expected_output="/tmp tmpfs tmpfs rw,nosuid,nodev,noexec"
    expected_generated="generated"
    expected_disabled="disabled"
    expected_masked="masked"

    if [[ -n "$findmnt_output" ]]; then
        echo "/tmp is mounted as a separate partition."
        echo "Output from findmnt:"
        echo "$findmnt_output"
        
        if [[ "$systemctl_output" == "generated" || "$systemctl_output" == "enabled" || "$systemctl_output" == "static" ]]; then
            echo "systemd will mount /tmp partition at boot time."
            echo "Output from systemctl:"
            echo "$systemctl_output"
            echo "Audit Result: PASS"
        else
            echo "systemd will NOT mount /tmp partition at boot time."
            echo "Output from systemctl:"
            echo "$systemctl_output"
            echo "Audit Result: FAIL"
        fi
    else
        echo "/tmp is NOT mounted as a separate partition."
        echo "Audit Result: FAIL"
    fi
}