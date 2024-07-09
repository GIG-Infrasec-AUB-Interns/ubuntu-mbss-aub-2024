#! /usr/bin/bash

{
    echo "[REMEDIATION] Ensuring web server services are not in use (2.1.18)..."

    read -p "Does your system have web server services dependencies? (Y/N)" ANSWER
    case "$ANSWER" in
        [Yy]*)
            echo "Aborting removal of web server services..."
            systemctl stop apache2.socket apache2.service nginx.service
            systemctl mask apache2.socket apache2.service nginx.service
            echo "Stopped and masked web server services instead."
            ;;
        *)
            echo "Removing web server services..."
            systemctl stop apache2.socket httpd.service nginx.service
            apt purge apache2 nginx
            echo "Removed web server services successfully."
            ;;
    esac
}