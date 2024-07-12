#! /usr/bin/bash

{
    echo "[REMEDIATION] Ensuring web proxy server services are not in use (2.1.17)..."

    read -p "Does your system have web proxy server services dependencies? (Y/N)" ANSWER
    case "$ANSWER" in
        [Yy]*)
            echo "Aborting removal of web proxy server services..."
            systemctl stop squid.service
            systemctl mask squid.service
            echo "Stopped and masked web proxy server services instead."
            ;;
        *)
            echo "Removing web proxy server services..."
            systemctl stop squid.service
            apt purge squid
            echo "Removed web proxy server services successfully."
            ;;
    esac
}