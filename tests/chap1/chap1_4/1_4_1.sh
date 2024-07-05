#! /usr/bin/bash
# 1.4.1 Ensure bootloader password is set

{
    echo "Ensuring bootloader password is set (1.4.1)..."
    
    grep_output=$(grep "^set superusers" /boot/grub/grub.cfg)
    awk_output=$(awk -F. '/^\s*password/ {print $1"."$2"."$3}' /boot/grub/grub.cfg)

    if [[ -z "$grep_output" || -z "$awk_output" ]]; then
        echo "Bootloader password not set!"
        echo "Superuser in GRUB check output:"
        echo "$grep_output"
        echo "Check if password is set for GRUB Superuser output:"
        echo "$awk_output"
        echo "Audit Result: FAIL"

        # Remediation
        read -p "Run remediation script for Test 1.4.1? (Y/N): " ANSWER
        case "$ANSWER" in
            [Yy]*)
                echo "Commencing remediation for Test 1.4.1..."

                FIXES_SCRIPT="$(realpath fixes/chap1/chap1_4/1_4_1.sh)"
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
    else
        echo "Superuser in GRUB check output:"
        echo "$grep_output"
        echo "Check if password is set for GRUB Superuser output:"
        echo "$awk_output"
        echo "Audit Result: PASS"
    fi
}