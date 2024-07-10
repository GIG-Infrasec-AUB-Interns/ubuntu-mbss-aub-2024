#! /usr/bin/bash

{
    echo "[REMEDIATION] Ensuring ldap server services are not in use (2.1.7)..."

    read -p "Does your system have ldap server services dependencies? (Y/N)" ANSWER
    case "$ANSWER" in
        [Yy]*)
            echo "Aborting removal of ldap server services..."
            systemctl stop slapd.service
            systemctl mask slapd.service
            echo "Stopped and masked ldap server services instead."
            ;;
        *)
            echo "Removing ldap server services..."
            systemctl stop slapd.service
            apt purge slapd
            echo "Removed ldap server services successfully."
            ;;
    esac
}