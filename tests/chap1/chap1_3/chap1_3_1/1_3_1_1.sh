#! /usr/bin/bash
# 1.3.1.1 Ensure AppArmor is installed

{
    echo "Ensuring AppArmor is installed (1.3.1.1)..."
    apparmor_output=$(dpkg-query -s apparmor &>/dev/null && echo "apparmor is installed")
    apparmor_utils_output=$(dpkg-query -s apparmor-utils &>/dev/null && echo "apparmor-utils is installed")

    if ([[ "$apparmor_output"=="apparmor is installed" ]] && [[ "$apparmor_utils_output"=="apparmor-utils is installed" ]]);
    then
        echo "AppArmor audit output:"
        echo "$apparmor_output"
        echo "AppArmor-utils audit output:"
        echo "$apparmor_utils_output"
        echo "Audit Result: PASS"
    else    
        echo "AppArmor audit output:"
        echo "$apparmor_output"
        echo "AppArmor-utils audit output:"
        echo "$apparmor_utils_output"
        echo "Audit Result: FAIL"

        # Remediation
        read -p "Run remediation script for Test 1.3.1.1? (Y/N): " ANSWER
        case "$ANSWER" in
            [Yy]*)
                echo "Commencing remediation for Test 1.3.1.1..."

                FIXES_SCRIPT="$(realpath fixes/chap1/chap1_3/chap1_3_1/1_3_1_1.sh)"
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