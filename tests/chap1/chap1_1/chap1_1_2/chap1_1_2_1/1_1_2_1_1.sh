#! /usr/bin/bash

# 1.1.2.1.1 Ensure /tmp is a separate partition

function runFix() {
    read -p "Run remediation script for Test 1.1.2.1.1? (Y/N): " ANSWER
        case "$ANSWER" in
            [Yy]*)
                echo "Commencing remediation for Test 1.1.2.1.1..."
                
                FIXES_SCRIPT="$(realpath fixes/chap1/chap1_1/chap1_1_2/chap1_1_2_1/1_1_2_1_1.sh)"
                if [ -f "$FIXES_SCRIPT" ]; then
                    chmod +x "$FIXES_SCRIPT"
                    "$FIXES_SCRIPT"
                else
                    echo "Error: $FIXES_SCRIPT is not found."
                fi
                echo "For more information, please visit https://downloads.cisecurity.org/#/"
                ;;
            *)
                echo "Remediation not commenced"
                echo "For more information, please visit https://downloads.cisecurity.org/#/"
                ;;
        esac
}

{
    echo "Ensuring /tmp is a separate partition (1.1.2.1.1)..."

    findmnt_output=$(findmnt -kn /tmp)
    systemctl_output=$(systemctl is-enabled tmp.mount 2>/dev/null)
    fstab_output=$(grep ' /tmp ' /etc/fstab)

    if [[ -n "$findmnt_output" ]]; then
        echo "/tmp is mounted as a separate partition."
        echo "Output from findmnt:"
        echo "$findmnt_output"

        if [[ -n "$systemctl_output" ]]; then
            if [[ "$systemctl_output" != "masked" || "$systemctl_output" != "disabled" ]]; then
                echo "systemd will mount /tmp partition at boot time."
                echo "Output from systemctl:"
                echo "$systemctl_output"
                echo "Audit Result: PASS"
            else
                echo "systemd will NOT mount /tmp partition at boot time."
                echo "Output from systemctl:"
                echo "$systemctl_output"
                echo "Audit Result: FAIL"
                runFix
            fi
        else
            echo "No explicit systemd unit found for /tmp."
            if [[ -n "$fstab_output" ]]; then
                echo "/tmp is configured in /etc/fstab:"
                echo "$fstab_output"
                echo "Audit Result: PASS"
            else
                echo "/tmp is not configured in /etc/fstab."
                echo "Audit Result: FAIL"
                runFix
            fi
        fi
    else
        echo "/tmp is NOT mounted as a separate partition."
        echo "Audit Result: FAIL"
        runFix
    fi
}