#! /usr/bin/bash


{
    echo "[REMEDIATION] Ensuring avahi daemon services are not in use (2.1.2)..."

    read -p "Does your system depend on avahi daemon OR does the workstation \n use portable hard drives or optical drives? (Y/N)" ANSWER
    case "$ANSWER" in
            [Yy]*)
                echo "Aborting removal of avahi daemon..."
                systemctl stop avahi-daemon.socket avahi-daemon.service 
                systemctl mask avahi-daemon.socket avahi-daemon.service
                echo "Stopped and masked avahi daemon instead."
                ;;
            *)
                echo "Removing avahi daemon..."
                systemctl stop avahi-daemon.socket avahi-daemon.service
                apt purge avahi-daemon 
                echo "Removed avahi daemon successfully."
                ;;
    esac
}