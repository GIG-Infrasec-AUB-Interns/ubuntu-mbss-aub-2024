#! /usr/bin/bash

# 1.1.2.2.1 Ensure /dev/shm is a separate partition

function runFix() {
    read -p "Run remediation script for Test 1.1.2.2.1? (Y/N): " ANSWER
        case "$ANSWER" in
            [Yy]*)
                echo "Commencing remediation for Test 1.1.2.2.1..."
                
                FIXES_SCRIPT="$(realpath fixes/chap1/chap1_1/chap1_1_2/chap1_1_2_2/1_1_2_2_1.sh)"
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
    echo "Ensuring /dev/shm is a separate partition (1.1.2.2.1)..."

    findmnt_output=$(findmnt -kn /dev/shm)

    if [[ -n "$findmnt_output" ]]; then
        echo "/dev/shm is mounted as a separate partition."
        echo "Output from findmnt:"
        echo "$findmnt_output"
        echo "Audit Result: PASS"
    else
        echo "/dev/shm is NOT mounted as a separate partition."
        echo "Audit Result: FAIL"
        runFix
    fi
}