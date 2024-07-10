#! /usr/bin/bash

{
    echo "[REMEDIATION] Ensuring dns server services are not in use (2.1.4)..."

    read -p "Does your system have dns server services dependencies? (Y/N)" ANSWER
    case "$ANSWER" in
        [Yy]*)
            echo "Aborting removal of dns server services..."
            systemctl stop bind9.service
            systemctl mask bind9.service
            echo "Stopped and masked dns server services instead."
            ;;
        *)
            echo "Removing dns server services..."
            systemctl stop bind9.service
            apt purge bind9
            echo "Removed dns server services successfully."
            ;;
    esac
}