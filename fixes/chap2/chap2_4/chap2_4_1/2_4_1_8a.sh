#!/usr/bin/bash
source utils.sh

# for when cron.allow exists
{
    echo "[REMEDIATION] Ensuring crontab is restricted to authorized users (2.4.1.8)..."

    [ ! -e "/etc/cron.allow" ] && touch /etc/cron.allow
    chown root:root /etc/cron.allow
    chmod u-x,g-wx,o-rwx /etc/cron.allow

    echo "Remediation successful."
}