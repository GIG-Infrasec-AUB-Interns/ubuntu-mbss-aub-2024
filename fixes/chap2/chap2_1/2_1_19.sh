#! /usr/bin/bash

{
    echo "[REMEDIATION] Ensuring xinetd services are not in use (2.1.19)..."

    read -p "Does your system have xinetd services dependencies? (Y/N)" ANSWER
    case "$ANSWER" in
        [Yy]*)
            echo "Aborting removal of xinetd services..."
            systemctl stop xinetd.service
            systemctl mask xinetd.service
            echo "Stopped and masked xinetd services instead."
            ;;
        *)
            echo "Removing xinetd services..."
            systemctl stop xinetd.service
            apt purge xinetd
            echo "Removed xinetd services successfully."
            ;;
    esac
}