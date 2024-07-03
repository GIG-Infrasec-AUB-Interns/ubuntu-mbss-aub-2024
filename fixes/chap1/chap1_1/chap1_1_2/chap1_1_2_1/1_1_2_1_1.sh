#! /usr/bin/bash

# 1.1.2.1.1 [REMEDIATION] Ensure /tmp is a separate partition

{
    echo "[REMEDIATION] Ensuring /tmp is a separate partition (1.1.2.1.1)..."

    # unmask tmp.mount
    systemctl unmask tmp.mount

    # Check if /tmp is already configured in /etc/fstab
    if ! grep -q ' /tmp ' /etc/fstab; then
        # If not, add the tmpfs entry to /etc/fstab
        echo "Adding /tmp mount options to /etc/fstab..."
        echo "tmpfs /tmp tmpfs defaults,rw,nosuid,nodev,noexec,relatime,size=2G 0 0" >> /etc/fstab
    else
        echo "/tmp is already configured in /etc/fstab."
    fi

    # Ensure the /tmp mount is active
    mount -o remount /tmp || mount /tmp

    # Check if the mount was successful
    if mountpoint -q /tmp; then
        echo "/tmp is successfully mounted."
    else
        echo "Error: /tmp failed to mount."
    fi

    # # run tests to check if remediation was successful
    # TEST_SCRIPT="$(realpath tests/chap1/chap1_1/chap1_1_2/chap1_1_2_1/1_1_2_1_1.sh)"
    # if [ -f "$TEST_SCRIPT" ]; then
    #     chmod +x "$TEST_SCRIPT"
    #     "$TEST_SCRIPT"
    # else
    #     echo "Error: $TEST_SCRIPT is not found."
    # fi
    echo "For more information, please visit https://downloads.cisecurity.org/#/"
}