#!/usr/bin/bash

{
    echo "Ensuring prelink is not installed (1.5.4)..."

    dpkg_output=$(dpkg-query -s prelink &>/dev/null && echo "prelink is installed")

    if [[ -z $dpkg_output ]]; then
        echo "Audit Result: PASS"
    else
        echo "Audit Result: FAIL"

        # Remediation
        read -p "Run remediation script for Test 1.5.4? (Y/N): " ANSWER
        case "$ANSWER" in
            [Yy]*)
                echo "Commencing remediation for Test 1.5.4..."

                FIXES_SCRIPT="$(realpath fixes/chap1/chap1_5/1_5_4.sh)"
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