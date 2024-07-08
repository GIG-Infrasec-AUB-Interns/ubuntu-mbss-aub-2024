#! /usr/bin/bash
source utils.sh

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

        runFix "1.4.1" fixes/chap1/chap1_4/1_4_1.sh.sh

    else
        echo "Superuser in GRUB check output:"
        echo "$grep_output"
        echo "Check if password is set for GRUB Superuser output:"
        echo "$awk_output"
        echo "Audit Result: PASS"
    fi
}