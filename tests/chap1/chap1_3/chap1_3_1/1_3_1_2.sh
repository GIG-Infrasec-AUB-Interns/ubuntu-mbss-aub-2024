#!/usr/bin/bash
source utils.sh

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

        runFix "1.3.1.2" fixes/chap1/chap1_3/chap1_3_1/1_3_1_2.sh
    fi
}
