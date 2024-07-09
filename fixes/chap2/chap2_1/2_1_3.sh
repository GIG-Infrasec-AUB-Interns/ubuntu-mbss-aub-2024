#! /usr/bin/bash

{
    echo "[REMEDIATION] Ensuring dhcp server services are not in use (2.1.3)..."

    read -p "Does your system have dhcp server services dependencies (Y/N)" ANSWER
    case "$ANSWER" in
        [Yy]*)
            echo "Aborting removal of dhcp server services..."
            systemctl stop isc-dhcp-server.service isc-dhcp-server6.service
            systemctl mask isc-dhcp-server isc-dhcp-server6.service
            echo "Stopped and masked dhcp server services instead."
            ;;
        *)
            echo "Removing dhcp server services..."
            systemctl stop isc-dhcp-server.service isc-dhcp-server6.service
            apt purge isc-dhcp-server
            echo "Removed dhcp server services successfully."
            ;;
    esac
}