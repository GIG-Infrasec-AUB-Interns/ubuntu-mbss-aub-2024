#! /usr/bin/bash

{
    echo "[REMEDIATION] Ensuring samba file server services are not in use (2.1.14)..."

    read -p "Does your system have samba file server services dependencies \n (does your machine need to mount directories/file systems to Windows)? (Y/N)" ANSWER
    case "$ANSWER" in
        [Yy]*)
            echo "Aborting removal of samba file server services..."
            systemctl stop smbd.service
            systemctl mask smbd.service
            echo "Stopped and masked samba file server services instead."
            ;;
        *)
            echo "Removing samba file server services..."
            systemctl stop smbd.service
            apt purge samba
            echo "Removed samba file server services successfully."
            ;;
    esac
}