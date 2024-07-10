#! /usr/bin/bash

{
    echo "[REMEDIATION] Ensuring message access server services are not in use (2.1.8)..."

    read -p "Does your system have message access server services dependencies (POP3 and IMAP)? (Y/N)" ANSWER
    case "$ANSWER" in
        [Yy]*)
            echo "Aborting removal of message access server services..."
            systemctl stop dovecot.socket dovecot.service
            systemctl mask dovecot.socket dovecot.service
            echo "Stopped and masked message access server services instead."
            ;;
        *)
            echo "Removing message access server services..."
            systemctl stop dovecot.socket dovecot.service
            apt purge dovecot-imapd dovecot-pop3d
            echo "Removed message access server services successfully."
            ;;
    esac
}