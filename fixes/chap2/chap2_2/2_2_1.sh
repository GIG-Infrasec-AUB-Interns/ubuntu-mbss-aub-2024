#! /usr/bin/bash

# 2.2.1 [REMEDIATION] Ensure NIS Client is not installed

{
    echo "[REMEDIATION] Ensure NIS Client is not installed (2.2.1)..."
    apt purge nis 
    echo "Removed NIS Client successfully."
}