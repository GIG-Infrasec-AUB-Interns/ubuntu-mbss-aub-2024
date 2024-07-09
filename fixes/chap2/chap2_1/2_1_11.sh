#! /usr/bin/bash

{
    echo "[REMEDIATION] Ensuring print server services are not in use (2.1.11)..."

    read -p "Does your system have print server services (cups.socket and/or cups.service) \n OR does your system print to both local and network printers? (Y/N)" ANSWER
    case "$ANSWER" in
        [Yy]*)
            echo "Aborting removal of print server services..."
            systemctl stop cups.socket cups.service
            systemctl mask cups.socket cups.service
            echo "Stopped and masked print server services instead."
            ;;
        *)
            echo "Removing print server services..."
            systemctl stop cups.socket cups.service
            apt purge cups
            echo "Removed print server services successfully."
            ;;
    esac
}