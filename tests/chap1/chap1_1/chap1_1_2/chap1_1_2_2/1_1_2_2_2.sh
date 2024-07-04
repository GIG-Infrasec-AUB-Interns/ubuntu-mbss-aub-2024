#! /usr/bin/bash

# 1.1.2.2.2 Ensure nodev option set on /dev/shm partition

{
    echo "Ensuring nodev option set on /dev/shm partition (1.1.2.2.2)..."
    findmnt_output=$(findmnt -kn /dev/shm | grep -v 'nodev')

    if [[ -z "$findmnt_output" ]]; then
        echo "Output from findmnt:"
        echo "$findmnt_output"
        echo "Audit Result: PASS"
    else
        echo "Output from findmnt:"
        echo "$findmnt_output"
        echo "Audit Result: FAIL"

        read -p "Run remediation script for Test 1.1.2.2.2? (Y/N): " ANSWER
        case "$ANSWER" in
            [Yy]*)
                echo "Commencing remediation for Test 1.1.2.2.2..."
                
                FIXES_SCRIPT="$(realpath fixes/chap1/chap1_1/chap1_1_2/chap1_1_2_1/1_1_2_2_2.sh)"
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
    fi
}