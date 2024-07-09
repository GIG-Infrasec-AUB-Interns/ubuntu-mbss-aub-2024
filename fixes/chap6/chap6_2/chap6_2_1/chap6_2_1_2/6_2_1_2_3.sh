#! /usr/bin/bash

# 6.2.1.2.3 [REMEDIATION] Ensure systemd-journal-upload is enabled and active

{
    echo "[REMEDIATION] Ensuring systemd-journal-upload is enabled and active (6.2.1.2.3)..."

    systemctl unmask systemd-journal-upload.service
    systemctl --now enable systemd-journal-upload.service

    echo "systemd-journal-upload is now enabled and active."
}