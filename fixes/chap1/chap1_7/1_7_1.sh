#! /usr/bin/bash

# 1.7.1 [REMEDIATION] Ensuring GDM is removed for servers

{
    echo "[REMEDIATION] Ensuring GDM is removed for servers (1.7.1)..."

    apt purge gdm3
    apt autoremove gdm3

    echo "Remediation finished successfully."
}