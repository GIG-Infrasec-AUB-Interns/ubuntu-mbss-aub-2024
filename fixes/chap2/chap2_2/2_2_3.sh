#! /usr/bin/bash

# 2.2.3 [REMEDIATION] Ensure talk client is not installed

{
    echo "[REMEDIATION] Ensure talk client is not installed (2.2.3)..."
    apt purge talk
    echo "Removed talk client successfully."
}