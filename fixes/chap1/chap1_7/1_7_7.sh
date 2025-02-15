#!/usr/bin/bash

{
    echo "[REMEDIATION] Ensuring GDM disabling automatic mounting of removable media is not overridden (1.7.7)..."

    # Step 1: Create the file /etc/dconf/db/local.d/locks/00-media-automount with the required content
    LOCKS_FILE="/etc/dconf/db/local.d/locks/00-media-automount"

    echo "Creating $LOCKS_FILE with the required settings..."
    mkdir -p /etc/dconf/db/local.d/locks
    cat <<EOL > $LOCKS_FILE
[org/gnome/desktop/media-handling]
automount=false
automount-open=false
EOL

    echo "$LOCKS_FILE has been created with the required settings."

    # Step 2: Update the system databases
    echo "Updating the system databases..."
    dconf update

    echo "System databases have been updated. Users must log out and back in again before the system-wide settings take effect."
}
