#! /usr/bin/bash

# 6.2.1.2.1 Ensure systemd-journal-remote is installed

{
    echo "[REMEDIATION] Ensuring systemd-journal-remote is installed (6.2.1.2.1)..."

    apt install systemd-journal-remote

    echo "systemd-journal-remote installed successfully."
}