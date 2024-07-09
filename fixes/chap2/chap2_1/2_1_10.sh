#! /usr/bin/bash

{
    echo "[REMEDIATION] Ensuring nis server services are not in use (2.1.10)..."

    read -p "Does your system have nis server services (ypserv)? (Y/N)" ANSWER
    case "$ANSWER" in
        [Yy]*)
            echo "Aborting removal of nis server services..."
            systemctl stop ypserv.service
            systemctl mask ypserv.service
            echo "Stopped and masked nis server services instead."
            ;;
        *)
            echo "Removing nis server services..."
            systemctl stop ypserv.service
            apt purge ypserv
            echo "Removed nis server services successfully."
            ;;
    esac
}