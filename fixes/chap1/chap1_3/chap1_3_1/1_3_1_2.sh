#! /usr/bin/bash

# 1.3.1.2 [REMEDIATION] Ensure AppArmor is enabled in the bootloader configuration

{
    echo "[REMEDIATION] Ensure AppArmor is enabled in the bootloader configuration (1.3.1.1)..."
# Add apparmor=1 and security=apparmor parameters to the GRUB_CMDLINE_LINUX= line
if grep -q 'GRUB_CMDLINE_LINUX=' /etc/default/grub; then
    sed -i 's/\(^GRUB_CMDLINE_LINUX="\)/\1apparmor=1 security=apparmor /' /etc/default/grub
else
    echo 'GRUB_CMDLINE_LINUX="apparmor=1 security=apparmor"' >> /etc/default/grub
fi

# Update grub configuration
update-grub

echo "Remediation completed. AppArmor is now enabled in the bootloader configuration."
echo "For more information, please visit https://downloads.cisecurity.org/#/"
}