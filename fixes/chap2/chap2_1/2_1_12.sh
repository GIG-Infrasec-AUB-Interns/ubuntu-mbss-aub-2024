#! /usr/bin/bash

{
    echo "[REMEDIATION] Ensuring rpcbind services are not in use (2.1.12)..."

    read -p "Does your system have rpcbind services dependencies? (Y/N)" ANSWER
    case "$ANSWER" in
        [Yy]*)
            echo "Aborting removal of rpcbind services..."
            systemctl stop rpcbind.socket rpcbind.service
            systemctl mask rpcbind.socket rpcbind.service
            echo "Stopped and masked rpcbind services instead."
            ;;
        *)
            echo "Removing rpcbind services..."
            systemctl stop rpcbind.socket rpcbind.service
            apt purge rpcbind
            echo "Removed rpcbind services successfully."
            ;;
    esac
}