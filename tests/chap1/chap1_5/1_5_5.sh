#!/usr/bin/bash

{
    echo "Ensuring Automatic Error Reporting is not enabled  (1.5.5)..."

    dpkg_output=$(dpkg-query -s apport &> /dev/null && grep -Psi -- '^\h*enabled\h*=\h*[^0]\b' /etc/default/apport)
    
    if [[ -z $dpkg_output ]]; then
        echo "Audit Result: PASS"
    else
        echo "Audit Result: FAIL"

        # Remediation
        read -p "Run remediation script for Test 1.5.5? (Y/N): " ANSWER
        case "$ANSWER" in
            [Yy]*)
                echo "Commencing remediation for Test 1.5.5..."

                FIXES_SCRIPT="$(realpath fixes/chap1/chap1_5/1_5_5.sh)"
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