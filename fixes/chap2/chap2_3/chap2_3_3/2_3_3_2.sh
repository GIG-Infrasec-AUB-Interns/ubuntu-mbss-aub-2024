#!/usr/bin/bash
source utils.sh

{
    echo "[REMEDIATION] Ensuring chronyd is running as user _chrony (2.3.3.2)..."

    # Check if the user line is already present in the config
    if grep -q "^user _chrony" /etc/chrony/chrony.conf; then
        echo "User _chrony already set in /etc/chrony/chrony.conf"
    else
        echo "Adding user _chrony to /etc/chrony/chrony.conf"
        echo "user _chrony" >> /etc/chrony/chrony.conf
    fi

    # Check if chrony.conf.d directory exists and process files if it does
    if [[ -d /etc/chrony/chrony.conf.d ]]; then
        for conf_file in /etc/chrony/chrony.conf.d/*.conf; do
            if ! grep -q "^user _chrony" "$conf_file"; then
                echo "Adding user _chrony to $conf_file"
                echo "user _chrony" >> "$conf_file"
            fi
        done
    fi

    # Restart chronyd service to apply changes
    echo "Restarting chronyd service..."
    systemctl restart chronyd.service

    echo "chronyd is now running as user _chrony. Remediation successful."
}