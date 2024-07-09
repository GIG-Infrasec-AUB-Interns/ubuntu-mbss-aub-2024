#! /usr/bin/bash

{
    echo "[REMEDIATION] Ensuring network file system services are not in use (2.1.9)..."

    read -p "Does your system have network file system services dependencies (nfs-kernel-server)? (Y/N)" ANSWER
    case "$ANSWER" in
        [Yy]*)
            echo "Aborting removal of network file system services..."
            systemctl stop nfs-server.service
            systemctl mask nfs-server.service
            echo "Stopped and masked network file system services instead."
            ;;
        *)
            echo "Removing network file system services..."
            systemctl stop nfs-server.service
            apt purge nfs-kernel-server
            echo "Removed network file system services successfully."
            ;;
    esac
}