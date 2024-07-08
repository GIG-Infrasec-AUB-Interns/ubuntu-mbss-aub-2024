#! /usr/bin/bash

# 1.7.4 [REMEDIATION] Ensuring GDM screen locks when the user is idle

{
    echo "[REMEDIATION] Ensuring GDM screen locks when the user is idle..."
    
    LOCK_DELAY_THRESH=5 # lock delay should be LEQ than this (in seconds). edit as necessary
    IDLE_DELAY_THRESH=900 # idle delay should be LEQ than this (in seconds). edit as necessary

    gsettings set org.gnome.desktop.screensaver lock-delay $LOCK_DELAY_THRESH
    gsettings set org.gnome.desktop.session idle-delay $IDLE_DELAY_THRESH

    echo "Remediation finished successfully."
}