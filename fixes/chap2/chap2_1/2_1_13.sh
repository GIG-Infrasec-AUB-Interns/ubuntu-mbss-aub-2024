#! /usr/bin/bash

{
    echo "[REMEDIATION] Ensuring rsync services are not in use (2.1.13)..."

    read -p "Does your system have rsync services dependencies? (Y/N)" ANSWER
    case "$ANSWER" in
        [Yy]*)
            echo "Aborting removal of rsync services..."
            systemctl stop rsync.service
            systemctl mask rsync.service
            echo "Stopped and masked rsync services instead."
            ;;
        *)
            echo "Removing rsync services..."
            systemctl stop rsync.service
            apt purge rsync
            echo "Removed rsync services successfully."
            ;;
    esac
}