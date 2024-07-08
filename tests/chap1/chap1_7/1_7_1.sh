#!/usr/bin/bash

{
    echo "Ensuring GDM is removed for servers (1.7.1)..."

    dpkg_output=$(dpkg-query -s gdm3 &>/dev/null && echo "gdm3 is installed")
    
    if [[ -z $dpkg_output ]]; then
        echo "Audit Result: PASS"
    else
        echo "Audit Result: FAIL"

        # Remediation
        read -p "Run remediation script for Test 1.7.1 (FOR SERVERS ONLY, removes GUI from the system)? (Y/N): " ANSWER
        case "$ANSWER" in
            [Yy]*)
                echo "Commencing remediation for Test 1.7.1..."

                FIXES_SCRIPT="$(realpath fixes/chap1/chap1_7/1_7_1.sh)"
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