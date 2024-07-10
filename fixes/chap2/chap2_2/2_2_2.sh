#! /usr/bin/bash

# 2.2.2 [REMEDIATION] Ensure rsh client is not installed

{
    echo "[REMEDIATION] Ensure rsh client is not installed (2.2.2)..."
    apt purge rsh-client
    echo "Removed rsh client successfully."
}