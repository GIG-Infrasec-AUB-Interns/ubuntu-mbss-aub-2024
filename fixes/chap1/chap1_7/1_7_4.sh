#! /usr/bin/bash
source globals.sh

# 1.7.4 [REMEDIATION] Ensuring GDM screen locks when the user is idle

{
    echo "[REMEDIATION] Ensuring GDM screen locks when the user is idle..."

    gsettings set org.gnome.desktop.screensaver lock-delay $LOCK_DELAY_THRESH
    gsettings set org.gnome.desktop.session idle-delay $IDLE_DELAY_THRESH

    echo "Remediation finished successfully."
}