#! /usr/bin/bash

# 1.1.2.1.1 [REMEDIATION] Ensure /tmp is a separate partition

{
    echo "[REMEDIATION] Ensuring /tmp is a separate partition (1.1.2.1.1)..."

    systemctl unmask tmp.mount

    # Edit /etc/fstab to configure /tmp mount options
    # Here's an example of using tmpfs with specific options
    echo "tmpfs /tmp tmpfs defaults,rw,nosuid,nodev,noexec,relatime,size=2G 0 0" >> /etc/fstab

    # Alternatively, for a disk or volume, replace tmpfs with the appropriate <device> and <fstype>
    # Example: <device> /tmp <fstype> defaults,nodev,nosuid,noexec 0 0
    # Replace <device> and <fstype> with actual values relevant to your environment

    # run tests to check if remediation was successful
    TEST_SCRIPT="$(realpath tests/chap1/chap1_1/chap1_1_2/chap1_1_2_1/1_1_2_1_1.sh)"
    if [ -f "$TEST_SCRIPT" ]; then
        chmod +x "$TEST_SCRIPT"
        "$TEST_SCRIPT"
    else
        echo "Error: $TEST_SCRIPT is not found."
    fi
    echo "For more information, please visit https://downloads.cisecurity.org/#/"
}