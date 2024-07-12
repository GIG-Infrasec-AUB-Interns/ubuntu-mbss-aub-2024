#! /usr/bin/bash

# 2.2.5 [REMEDIATION] Ensure ldap client is not installed

{
    echo "[REMEDIATION] Ensure ldap client is not installed (2.2.5)..."
    apt purge ldap-utils
    echo "Removed ldap client successfully."
}