#! /usr/bin/bash

# 1.3.1.2 [REMEDIATION] Ensure AppArmor is enabled in the bootloader configuration

{
    echo "[REMEDIATION] Ensure AppArmor is enabled in the bootloader configuration (1.3.1.2)..."
    # Add apparmor=1 and security=apparmor parameters to the GRUB_CMDLINE_LINUX= line
    sudo sed -i 's/^GRUB_CMDLINE_LINUX=.*/GRUB_CMDLINE_LINUX="apparmor=1 security=apparmor"/' /etc/default/grub
    sudo apt purge grub-legacy
    sudo apt install grub-efi
    sudo grub-install
    sudo update-grub

    echo "Remediation completed. AppArmor is now enabled in the bootloader configuration."
    echo "For more information, please visit https://downloads.cisecurity.org/#/"
}