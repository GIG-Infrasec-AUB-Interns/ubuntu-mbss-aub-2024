#! /usr/bin/bash

{
    echo "[REMEDIATION] Ensuring ftp server services are not in use (2.1.6)..."

    read -p "Does your system have ftp server services OR vsftpd package dependencies? (Y/N)" ANSWER
    case "$ANSWER" in
        [Yy]*)
            echo "Aborting removal of ftp server services..."
            systemctl stop vsftpd.service
            systemctl mask vsftpd.service
            echo "Stopped and masked ftp server services instead."
            ;;
        *)
            echo "Removing ftp server services..."
            systemctl stop vsftpd.service
            apt purge vsftpd
            echo "Removed ftp server services successfully."
            ;;
    esac
}