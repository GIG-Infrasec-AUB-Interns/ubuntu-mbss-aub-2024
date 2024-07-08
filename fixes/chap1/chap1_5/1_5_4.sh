#! /usr/bin/bash

# 1.5.4 [REMEDIATION] Ensure prelink is not installed

{
    echo "[REMEDIATION] Ensuring prelink is not installed (1.5.4)..."

    # restore binaries to normal
    prelink -ua

    # Uninstall prelink using the appropriate package manager or manual installation
    apt purge prelink

    echo "Remediation finished successfully."
    echo "For more information, please visit https://downloads.cisecurity.org/#/"
}