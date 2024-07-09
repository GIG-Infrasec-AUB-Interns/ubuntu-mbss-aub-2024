#! /usr/bin/bash

{
    echo "[REMEDIATION] Ensuring dnsmasq services are not in use (2.1.5)..."

    read -p "Does your system have dnsmasq services dependencies? (Y/N)" ANSWER
    case "$ANSWER" in
        [Yy]*)
            echo "Aborting removal of dnsmasq services..."
            systemctl stop dnsmasq.service
            systemctl mask dnsmasq.service
            echo "Stopped and masked dnsmasq services instead."
            ;;
        *)
            echo "Removing dnsmasq services..."
            systemctl stop dnsmasq.service
            apt purge dnsmasq
            echo "Removed dnsmasq services successfully."
            ;;
    esac
}