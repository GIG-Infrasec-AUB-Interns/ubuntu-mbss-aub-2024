#! /usr/bin/bash

# 6.1.2 [REMEDIATION] Ensure filesystem integrity is regularly checked

{
    echo "[REMEDIATION] Ensuring filesystem integrity is regularly checked (6.1.2)..."

    crontab -u root -e
    CRON_LINE="0 5 * * * /usr/bin/aide.wrapper --config /etc/aide/aide.conf --update"
    (crontab -l; echo "$CRON_LINE") | crontab -

    echo "A cron job is now scheduled to run the aide check."
}