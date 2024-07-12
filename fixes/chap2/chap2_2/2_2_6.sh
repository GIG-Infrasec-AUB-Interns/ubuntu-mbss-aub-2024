#! /usr/bin/bash

# 2.2.6 [REMEDIATION] Ensure ftp client is not installed

{
    echo "[REMEDIATION] Ensure ftp client is not installed (2.2.6)..."
    apt purge ftp
    echo "Removed ftp client successfully."
}