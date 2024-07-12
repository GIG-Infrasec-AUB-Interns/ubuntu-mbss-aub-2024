#! /usr/bin/bash

# 6.3.1.2 [REMEDIATION] Ensure auditd service is enabled and active

{
    echo "[REMEDIATION] Ensuring auditd service is enabled and active (6.3.1.2)..."

    systemctl unmask auditd 
    systemctl enable auditd 
    systemctl start auditd

    echo "auditd service is now enabled and active."
}