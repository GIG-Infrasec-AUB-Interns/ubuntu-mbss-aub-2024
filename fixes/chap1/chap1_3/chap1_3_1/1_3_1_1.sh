#! /usr/bin/bash

# 1.3.1.1 [REMEDIATION] Ensure AppArmor is installed

{
    echo "[REMEDIATION] Ensuring AppArmor is installed (1.3.1.1)..."

    apt install apparmor apparmor-utils

    echo "AppArmor and AppArmor-utils installed successfully."
    echo "For more information, please visit https://downloads.cisecurity.org/#/"
}