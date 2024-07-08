#! /usr/bin/bash

# 1.5.4 [REMEDIATION] Ensure prelink is not installed

{
    echo "[REMEDIATION] Ensuring prelink is not installed (1.5.4)..."

    # Remediation
    read -p "Remove the apport package? (Y/N): " ANSWER
    case "$ANSWER" in
        [Yy]*)
            echo "Removing apport package..."
            apt purge apport
            ;;
        *)
            echo "apport package not removed."
            echo "Stopping and masking apport package instead."

            # edit the enabled=0 line
            if grep -q "^enabled=" /etc/default/apport; then
                sed -i 's/^enabled=.*/enabled=0/' /etc/default/apport
            else
                echo "enabled=0" >> /etc/default/apport
            fi

            # stopping and masking
            systemctl stop apport.service
            systemctl mask apport.service
            ;;
    esac

    echo "Remediation finished successfully."
    echo "For more information, please visit https://downloads.cisecurity.org/#/"
}