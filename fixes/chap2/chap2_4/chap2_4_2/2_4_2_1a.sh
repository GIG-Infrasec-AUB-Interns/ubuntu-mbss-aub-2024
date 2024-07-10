#!/usr/bin/env bash

{
    echo "[REMEDIATION] Ensure at is restricted to authorized users (2.4.2.1)..."
    
    mkdir /etc/at.allow
    # Create the file if it doesn't exist
    # Change owner or user root
    # If group daemon exists, change to group daemon, else change group to root
    # Change mode to 640 or more restrictive

    echo "Remediation successful."
}
