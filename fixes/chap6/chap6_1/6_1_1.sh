#! /usr/bin/bash

# 6.1.1 [REMEDIATION] Ensure AIDE is installed

{
    echo "[REMEDIATION] Ensuring AIDE is installed (6.1.1)..."

    apt install aide aide-common

    echo "AIDE and AIDE-common installed successfully."
    echo "For more information, please visit https://downloads.cisecurity.org/#/"
}