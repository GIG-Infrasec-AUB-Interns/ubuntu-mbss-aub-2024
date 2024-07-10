#!/usr/bin/bash
source utils.sh

{
    echo "[REMEDIATION] Ensuring cron daemon is enabled and active (2.4.1.1)..."

    echo "Unmasking cron daemon..."
    systemctl unmask "$(systemctl list-unit-files | awk '$1~/^crond?\.service/{print $1}')"
    echo "Enabling cron daemon..."
    systemctl --now enable "$(systemctl list-unit-files | awk '$1~/^crond?\.service/{print $1}')"
    
    echo "Enabled cron daemon successfully."
}
