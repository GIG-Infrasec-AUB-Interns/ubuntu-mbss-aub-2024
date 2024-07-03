#! /usr/bin/bash

# 1.1.2.1.3 Ensure nosuid option set on /tmp partition

{
    echo "Ensure nosuid option set on /tmp partition (1.1.2.1.3)..."
    findmnt_output=$(findmnt -kn /tmp | grep -v nosuid)

    if [[ -z "$findmnt_output" ]]; then
        echo "Output from findmnt:"
        echo "$findmnt_output"
        echo "Audit Result: PASS"
    else
        echo "Output from findmnt:"
        echo "$findmnt_output"
        echo "Audit Result: FAIL"

        read -p "Run remediation script for Test 1.1.2.1.3? (Y/N): " ANSWER
        case "$ANSWER" in
            [Yy]*)
                echo "Commencing remediation for Test 1.1.2.1.3..."
                
                FIXES_SCRIPT="$(realpath fixes/chap1/chap1_1/chap1_1_2/chap1_1_2_1/1_1_2_1_3.sh)"
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