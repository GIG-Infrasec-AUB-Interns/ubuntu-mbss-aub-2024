#! /usr/bin/bash

# 1.1.2.2.3 [REMEDIATION] Ensure nosuid option set on /dev/shm partition

{
    echo "[REMEDIATION] Ensuring nosuid option set on /dev/shm partition (1.1.2.2.3)..."

    # check if /dev/shm is a separate partition
    findmnt_output=$(findmnt -kn /dev/shm)

    if [[ -z "$findmnt_output" ]]; then
        echo "/dev/shm is not a separate partition. Skipping remediation."
    else
        echo "/dev/shm is a separate partition. Proceeding with remediation."

        # Backup /etc/fstab before making changes
        cp /etc/fstab /etc/fstab.bak.$(date +%F-%T)

        # Ensure nodev option is set for /dev/shm in /etc/fstab
        if grep -q ' /dev/shm ' /etc/fstab; then
            echo "Updating /etc/fstab to include nosuid option for /dev/shm."
            sed -i '/ \/dev/shm / s/\(.*\)defaults\(.*\)/\1defaults,nosuid\2/' /etc/fstab
        else
            echo "/dev/shm entry not found in /etc/fstab. Adding entry with nosuid option."
            echo "tmpfs /dev/shm tmpfs defaults,rw,nosuid,nodev,noexec,relatime,size=2G 0 0" >> /etc/fstab
        fi

        # Remount /tmp with the updated options
        mount -o remount /dev/shm

        echo "nodev option has been set on /dev/shm and remounted successfully."
    
    fi

    # # run tests to check if remediation was successful
    # TEST_SCRIPT="$(realpath tests/chap1/chap1_1/chap1_1_2/chap1_1_2_1/1_1_2_1_2.sh)"
    # if [ -f "$TEST_SCRIPT" ]; then
    #     chmod +x "$TEST_SCRIPT"
    #     "$TEST_SCRIPT"
    # else
    #     echo "Error: $TEST_SCRIPT is not found."
    # fi
    echo "For more information, please visit https://downloads.cisecurity.org/#/"
}