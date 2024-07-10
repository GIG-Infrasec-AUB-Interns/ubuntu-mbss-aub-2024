#!/usr/bin/bash
source utils.sh

{
    echo "[REMEDIATION] Ensuring a single time synchronization daemon is in use (2.3.1.1)..."
    echo "Which time synchronization daemon does your organization use? [1] chrony [2] systemd-timesyncd [3] other"
    read -p "Please enter the number of your " DAEMON

    case "$DAEMON" in
        [1])
            echo "Configuring chrony daemon in your system..."
            apt install chrony 
            echo "Stopping systemd-timesyncd..."
            systemctl stop systemd-timesyncd.service
            systemctl mask systemd-timesyncd.service
            echo "Configured chrony daemon successfully."
            ;;
        [2])
            echo "Using systemd-timesyncd daemon default in your system..."
            echo "Removing chrony..."
            apt purge chrony
            apt autoremove chron
            echo "Configured systemd-timesyncd daemon successfully."
            ;;
        *)
            echo "Please check which time synchronization daemon your organization is using, and adjust this audit script as necessary."
            echo "No remediations done."
            ;;
    esac
}
