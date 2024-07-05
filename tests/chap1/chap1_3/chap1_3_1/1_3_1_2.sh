#!/usr/bin/bash
# 1.3.1.2 Ensure AppArmor is enabled in the bootloader configuration

{
    echo "Ensuring AppArmor is enabled in the bootloader configuration (1.3.1.2)..."
    apparmor_param_output=$(grep "^\s*linux" /boot/grub/grub.cfg | grep -v "apparmor=1")
    security_param_output=$(grep "^\s*linux" /boot/grub/grub.cfg | grep -v "security=apparmor")

    if [[ -z "$apparmor_param_output" ]] && [[ -z "$security_param_output" ]]; then
        echo "apparmor=1 and security=apparmor parameters set"
        echo "Audit Result: PASS"
    else    
        echo "apparmor=1 and security=apparmor parameters not set!"
        echo "AppArmor param output:"
        echo "$apparmor_param_output"
        echo "Security param output:"
        echo "$security_param_output"
        echo "Audit Result: FAIL"

        # Remediation
        read -p "Run remediation script for Test 1.3.1.2? (Y/N): " ANSWER
        case "$ANSWER" in
            [Yy]*)
                echo "Commencing remediation for Test 1.3.1.2..."
                sudo sed -i 's/^GRUB_CMDLINE_LINUX=.*/GRUB_CMDLINE_LINUX="apparmor=1 security=apparmor"/' /etc/default/grub
                sudo apt purge grub-legacy
                sudo apt install grub-efi
                sudo grub-install
                sudo update-grub
                echo "Remediation complete. Please reboot your system."
                ;;
            *)
                echo "Remediation not commenced"
                echo "For more information, please visit https://downloads.cisecurity.org/#/"
                ;;
        esac
    fi
}
