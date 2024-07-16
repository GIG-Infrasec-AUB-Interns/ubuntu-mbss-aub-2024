#!/usr/bin/bash
source utils.sh
source globals.sh

{
    echo "[REMEDIATION] Ensure root user umask is configured (5.4.2.6)..."

    echo "Updating umask in /root/.bash_profile and /root/.bashrc to 0027 or more restrictive..."

    # Update umask in /root/.bash_profile
    if grep -q 'umask' /root/.bash_profile; then
        sed -i 's/umask .*/umask 0027/' /root/.bash_profile
    else
        echo 'umask 0027' >> /root/.bash_profile
    fi

    # Update umask in /root/.bashrc
    if grep -q 'umask' /root/.bashrc; then
        sed -i 's/umask .*/umask 0027/' /root/.bashrc
    else
        echo 'umask 0027' >> /root/.bashrc
    fi

    echo "Remediation successful."
}
