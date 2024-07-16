#!/usr/bin/bash
source utils.sh
source globals.sh

{
    echo "[REMEDIATION] Ensure nologin is not listed in /etc/shells (5.4.3.1)..."

    echo "Updating /etc/shells to remove nologin lines..."

    sed -i '/\/nologin\b/d' /etc/shells

    echo "Remediation successful."
}
