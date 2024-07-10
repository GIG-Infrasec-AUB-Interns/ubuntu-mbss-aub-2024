#! /usr/bin/bash

# 6.2.1.2.4 [REMEDIATION] Ensure systemd-journal-remote service is not in use

{
    echo "[REMEDIATION] Ensuring systemd-journal-remote service is not in use (6.2.1.2.4)..."

    systemctl stop systemd-journal-remote.socket systemd-journal-remote.service 
    systemctl mask systemd-journal-remote.socket systemd-journal-remote.service

    echo "systemd-journal-remote service is no longer in use."
}