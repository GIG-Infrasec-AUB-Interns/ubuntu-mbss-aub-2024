#! /usr/bin/bash

# 1.1.2.2.1 [REMEDIATION] Ensure /dev/shm is a separate partition

{
    echo "[REMEDIATION] Ensuring /dev/shm is a separate partition (1.1.2.2.1)..."

    # Backup /etc/fstab before making changes
    cp /etc/fstab /etc/fstab.bak.$(date +%F-%T)

    # Check if /dev/shm is already configured in /etc/fstab
    if grep -q ' /dev/shm ' /etc/fstab; then
        echo "Updating /etc/fstab to include nosuid,nodev,noexec options for /dev/shm."
        sed -i '/ \/dev\/shm / s/\(.*\)defaults\(.*\)/\1defaults,rw,nosuid,nodev,noexec,relatime,size=2G\2/' /etc/fstab
    else
        echo "Adding entry to /etc/fstab with nosuid,nodev,noexec options for /dev/shm."
        echo "tmpfs /dev/shm tmpfs defaults,rw,nosuid,nodev,noexec,relatime,size=2G 0 0" >> /etc/fstab
    fi

    # Remount /dev/shm with the updated options
    mount -o remount /dev/shm

    echo "/dev/shm has been mounted as a separate partition with the appropriate options."

    # Optional: Uncomment and use the lines below to run tests to check if remediation was successful
    # TEST_SCRIPT="$(realpath tests/chap1/chap1_1/chap1_1_2/chap1_1_2_2/1_1_2_2_1.sh)"
    # if [ -f "$TEST_SCRIPT" ]; then
    #     chmod +x "$TEST_SCRIPT"
    #     "$TEST_SCRIPT"
    # else
    #     echo "Error: $TEST_SCRIPT is not found."
    # fi

    echo "For more information, please visit https://downloads.cisecurity.org/#/"
}