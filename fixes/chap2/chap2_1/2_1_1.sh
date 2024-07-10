#! /usr/bin/bash

# 2.1 [REMEDIATION] Ensure AppArmor is installed

{
    echo "[REMEDIATION] Ensuring autofs services are not in use (2.1.1)..."

    read -p "Does your system have autofs dependencies OR does the workstation \n use portable hard drives or optical drives? (Y/N)" ANSWER
    case "$ANSWER" in
        [Yy]*)
            echo "Aborting removal of autofs..."
            systemctl stop autofs.service 
            systemctl mask autofs.service
            echo "Stopped and masked autofs instead."
            ;;
        *)
            echo "Removing autofs..."
            systemctl stop autofs.service 
            apt purge autofs 
            echo "Removed autofs successfully."
            ;;
    esac
}