#!/usr/bin/bash

{
    echo "[REMEDIATION] Ensuring mail transfer agent is configured for local-only mode (2.1.21)..."

    # Define the path to the postfix configuration file
    POSTFIX_CONF="/etc/postfix/main.cf"
    
    # Check if the configuration file exists
    if [ -f "$POSTFIX_CONF" ]; then
        # Check if inet_interfaces is already set
        if grep -q "^inet_interfaces" "$POSTFIX_CONF"; then
            # Update inet_interfaces to loopback-only
            sed -i 's/^inet_interfaces.*/inet_interfaces = loopback-only/' "$POSTFIX_CONF"
            echo "Updated inet_interfaces to loopback-only in $POSTFIX_CONF"
        else
            # Add inet_interfaces to the configuration file
            echo "inet_interfaces = loopback-only" >> "$POSTFIX_CONF"
            echo "Added inet_interfaces = loopback-only to $POSTFIX_CONF"
        fi

        # Restart postfix service to apply the changes
        systemctl restart postfix
        if [ $? -eq 0 ]; then
            echo "Postfix service restarted successfully."
        else
            echo "Failed to restart Postfix service."
        fi
    else
        echo "Error: Postfix configuration file $POSTFIX_CONF not found."
    fi
}
