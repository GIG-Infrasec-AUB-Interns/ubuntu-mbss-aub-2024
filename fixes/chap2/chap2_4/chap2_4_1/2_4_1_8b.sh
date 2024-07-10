#!/usr/bin/bash
source utils.sh
# for when cron.allow doesnt exist but cron.deny exists

{
    echo "[REMEDIATION] Ensuring crontab is restricted to authorized users (2.4.1.8)..."

    [ -e "/etc/cron.deny" ] && chown root:root /etc/cron.deny
    [ -e "/etc/cron.deny" ] && chmod u-x,g-wx,o-rwx /etc/cron.deny

    echo "Remediation successful."
}