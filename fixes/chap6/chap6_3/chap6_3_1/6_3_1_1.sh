#! /usr/bin/bash

# 6.3.1.1 [REMEDIATION] Ensure auditd packages are installed

{
    echo "[REMEDIATION] Ensuring auditd packages are installed (6.3.1.1)..."

    apt install auditd audispd-plugins

    echo "auditd and audispd-plugins installed successfully."
}