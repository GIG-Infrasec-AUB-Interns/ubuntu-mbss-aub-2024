#!/usr/bin/bash

{
    echo "[REMEDIATION] Ensuring GDM screen locks cannot be overridden..."

    # create the file /etc/dconf/db/local.d/locks/screensaver with the required content
    LOCKS_FILE="/etc/dconf/db/local.d/locks/screensaver"

    echo "Creating $LOCKS_FILE with the required settings..."
    mkdir -p /etc/dconf/db/local.d/locks
    cat <<EOL > $LOCKS_FILE
# Lock desktop screensaver settings
/org/gnome/desktop/session/idle-delay
/org/gnome/desktop/screensaver/lock-delay
EOL

    echo "$LOCKS_FILE has been created with the required settings."

    # Step 2: Update the system databases
    echo "Updating the system databases..."
    dconf update

    echo "System databases have been updated. Users must log out and back in again before the system-wide settings take effect."
}
