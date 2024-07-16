#!/usr/bin/bash
source utils.sh
source globals.sh

{
    echo "[REMEDIATION] Ensure default user shell timeout is configured (5.4.3.2)..."

    # Create or edit a file in /etc/profile.d
    TMOUT_FILE="/etc/profile.d/tmout.sh"
    
    echo "Creating/Updating $TMOUT_FILE..."
    {
        echo "TMOUT=900"
        echo "readonly TMOUT"
        echo "export TMOUT"
    } > "$TMOUT_FILE"

    # Ensure the configuration is applied to /etc/profile and /etc/bashrc
    echo "Updating /etc/profile and /etc/bashrc to remove any conflicting TMOUT settings..."
    
    for f in /etc/profile /etc/bashrc; do
        sed -i '/^\s*TMOUT=/d' "$f"
    done
    
    # Append TMOUT settings to /etc/profile and /etc/bashrc
    {
        echo "TMOUT=900"
        echo "readonly TMOUT"
        echo "export TMOUT"
    } >> /etc/profile
    echo "TMOUT settings added to $f."

    echo "Remediation successful."
}
