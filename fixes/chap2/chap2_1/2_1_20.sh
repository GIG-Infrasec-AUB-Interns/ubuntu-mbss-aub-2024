#! /usr/bin/bash

{
    echo "[REMEDIATION] Ensuring X window server services are not in use (2.1.19)..."

    read -p "Does your system have X window server services dependencies? (Y/N)" ANSWER
    case "$ANSWER" in
        [Yy]*)
            echo "Aborting removal of X window server services, and any remediation..."
            ;;
        *)
            echo "Removing X window server services..."
            apt purge xserver-common
            echo "Removed X window server services successfully."
            ;;
    esac
}