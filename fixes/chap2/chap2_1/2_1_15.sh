#! /usr/bin/bash

{
    echo "[REMEDIATION] Ensuring snmp services are not in use (2.1.15)..."

    read -p "Does your system have snmp services dependencies? (Y/N)" ANSWER
    case "$ANSWER" in
        [Yy]*)
            echo "Aborting removal of snmp services..."
            systemctl stop snmpd.service
            systemctl mask snmpd.service
            echo "Stopped and masked snmp services instead."
            ;;
        *)
            echo "Removing snmp services..."
            systemctl stop snmpd.service
            apt purge snmpd
            echo "Removed snmp services successfully."
            ;;
    esac
}