#!/usr/bin/bash
source utils.sh
source globals.sh

{
    echo "[REMEDIATION] Ensure strong password hashing algorithm is configured (5.4.1.4)..."

    # Set the ENCRYPT_METHOD parameter to conform to site policy in /etc/login.defs
    if grep -q "ENCRYPT_METHOD" /etc/login.defs; then
        sed -i "s/^ENCRYPT_METHOD.*/ENCRYPT_METHOD $SET_HASHING_ALGO/" /etc/login.defs
    else
        echo "ENCRYPT_METHOD $SET_HASHING_ALGO" >> /etc/login.defs
    fi

    echo "Remediation successful."
}
