#! /usr/bin/bash

# 6.2.1.1.1 [REMEDIATION] Ensure journald service is enabled and active

{
    echo "[REMEDIATION] Ensuring journald service is enabled and active (6.2.1.1.1)..."

    systemctl unmask systemd-journald.service
    systemctl start systemd-journald.service

    echo "journald service is now enabled and active."
    echo "For more information, please visit https://downloads.cisecurity.org/#/"
}