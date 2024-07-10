#! /usr/bin/bash

# 2.2.4 [REMEDIATION] Ensure telnet client is not installed

{
    echo "[REMEDIATION] Ensure telnet client is not installed (2.2.4)..."
    apt purge telnet
    echo "Removed telnet client successfully."
}