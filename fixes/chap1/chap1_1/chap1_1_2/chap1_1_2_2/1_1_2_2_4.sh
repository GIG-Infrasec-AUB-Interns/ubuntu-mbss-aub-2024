#!/usr/bin/bash

# 1.1.2.2.4 [REMEDIATION] Ensure noexec option set on /dev/shm partition

{
    echo "[REMEDIATION] Ensuring noexec option set on /dev/shm partition (1.1.2.2.4)..."

    # Check if /dev/shm is a separate partition
    findmnt_output=$(findmnt -kn /dev/shm)

    if [[ -z "$findmnt_output" ]]; then
        echo "/dev/shm is not a separate partition. Skipping remediation."
    else
        echo "/dev/shm is a separate partition. Proceeding with remediation."

        # Backup /etc/fstab before making changes
        cp /etc/fstab /etc/fstab.bak.$(date +%F-%T)

        # Ensure noexec option is set for /dev/shm in /etc/fstab
        if grep -q ' /dev/shm ' /etc/fstab; then
            echo "Updating /etc/fstab to include noexec option for /dev/shm."
            sed -i '/ \/dev\/shm / s/\(.*\)defaults\(.*\)/\1defaults,noexec\2/' /etc/fstab
            sed -i '/ \/dev\/shm / s/\(.*\)rw,nosuid,nodev\(.*\)/\1rw,nosuid,nodev,noexec\2/' /etc/fstab
        else
            echo "/dev/shm entry not found in /etc/fstab. Adding entry with noexec option."
            echo "tmpfs /dev/shm tmpfs defaults,rw,nosuid,nodev,noexec,relatime,size=2G 0 0" >> /etc/fstab
        fi

        # Remount /dev/shm with the updated options
        mount -o remount /dev/shm

        echo "noexec option has been set on /dev/shm and remounted successfully."
    fi

    # Uncomment the lines below to run the test script if needed
    # TEST_SCRIPT="$(realpath tests/chap1/chap1_1/chap1_1_2/chap1_1_2_1/1_1_2_1_2.sh)"
    # if [[ -f "$TEST_SCRIPT" ]]; then
    #     chmod +x "$TEST_SCRIPT"
    #     "$TEST_SCRIPT"
    # else
    #     echo "Error: $TEST_SCRIPT is not found."
    # fi

    echo "For more information, please visit https://downloads.cisecurity.org/#/"
}
