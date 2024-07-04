#! /usr/bin/bash

# 1.1.2.1.4 [REMEDIATION] Ensure noexec option set on /tmp partition

{
    echo "[REMEDIATION] Ensuring noexec option set on /tmp partition (1.1.2.1.3)..."

    # check if /tmp is a separate partition
    findmnt_output=$(findmnt -kn /tmp)

    if [[ -z "$findmnt_output" ]]; then
        echo "/tmp is not a separate partition. Skipping remediation."
    else
        echo "/tmp is a separate partition. Proceeding with remediation."

        # Backup /etc/fstab before making changes
        cp /etc/fstab /etc/fstab.bak.$(date +%F-%T)

        # Ensure nosuid option is set for /tmp in /etc/fstab
        if grep -q ' /tmp ' /etc/fstab; then
            echo "Updating /etc/fstab to include noexec option for /tmp."
            sed -i '/ \/tmp / s/\(.*\)defaults\(.*\)/\1defaults,noexec\2/' /etc/fstab
        else
            echo "/tmp entry not found in /etc/fstab. Adding entry with nosuid option."
            echo "tmpfs /tmp tmpfs defaults,rw,nosuid,nodev,noexec,relatime,size=2G 0 0" >> /etc/fstab
        fi

        # Remount /tmp with the updated options
        mount -o remount /tmp

        echo "noexec option has been set on /tmp and remounted successfully."
    
    fi

    # # run tests to check if remediation was successful
    # TEST_SCRIPT="$(realpath tests/chap1/chap1_1/chap1_1_2/chap1_1_2_1/1_1_2_1_3.sh)"
    # if [ -f "$TEST_SCRIPT" ]; then
    #     chmod +x "$TEST_SCRIPT"
    #     "$TEST_SCRIPT"
    # else
    #     echo "Error: $TEST_SCRIPT is not found."
    # fi
    echo "For more information, please visit https://downloads.cisecurity.org/#/"
}
