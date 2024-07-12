#! /usr/bin/bash

{
    echo "[REMEDIATION] Ensuring tftp server services are not in use (2.1.16)..."

    read -p "Does your system have tftp server services dependencies? (Y/N)" ANSWER
    case "$ANSWER" in
        [Yy]*)
            echo "Aborting removal of tftp server services..."
            systemctl stop tftpd-hpa.service
            systemctl mask tftpd-hpa.service
            echo "Stopped and masked tftp server services instead."
            ;;
        *)
            echo "Removing tftp server services..."
            systemctl stop tftpd-hpa.service
            apt purge tftpd-hpa
            echo "Removed tftp server services successfully."
            ;;
    esac
}