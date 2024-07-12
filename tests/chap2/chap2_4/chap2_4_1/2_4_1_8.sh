#!/usr/bin/bash
source utils.sh

{
    echo "Ensuring crontab is restricted to authorized users (2.4.1.8)..."

    # Check if /etc/cron.allow exists
    if [ -e "/etc/cron.allow" ]; then
        cron_allow_output=$(stat -Lc 'Access: (%a/%A) Owner: (%U) Group: (%G)' /etc/cron.allow)
        echo "Output from /etc/cron.allow stat:"
        echo "$cron_allow_output"

        # Extract values for comparison (cron allow)
        cron_allow_permissions=$(stat -Lc '%a' /etc/cron.allow)
        cron_allow_owner=$(stat -Lc '%U' /etc/cron.allow)
        cron_allow_group=$(stat -Lc '%G' /etc/cron.allow)

        if [[ "$cron_allow_permissions" == "640" && "$cron_allow_owner" == "root" && "$cron_allow_group" == "root" ]]; then
            echo "Audit Result: PASS"
        else
            echo "Audit Result: FAIL"
            runFix "2.4.1.8" fixes/chap2/chap2_4/chap2_4_1/2_4_1_8a.sh
        fi

    # Check if /etc/cron.deny exists
    elif [ -e "/etc/cron.deny" ]; then
        cron_deny_output=$(stat -Lc 'Access: (%a/%A) Owner: (%U) Group: (%G)' /etc/cron.deny)
        echo "Output from /etc/cron.deny stat:"
        echo "$cron_deny_output"

        # Extract values for comparison (cron deny)
        cron_deny_permissions=$(stat -Lc '%a' /etc/cron.deny)
        cron_deny_owner=$(stat -Lc '%U' /etc/cron.deny)
        cron_deny_group=$(stat -Lc '%G' /etc/cron.deny)

        if [[ "$cron_deny_permissions" == "640" && "$cron_deny_owner" == "root" && "$cron_deny_group" == "root" ]]; then
            echo "Audit Result: PASS"
        else
            echo "Audit Result: FAIL"
            runFix "2.4.1.8" fixes/chap2/chap2_4/chap2_4_1/2_4_1_8b.sh
        fi

    # If neither /etc/cron.allow nor /etc/cron.deny exist
    else
        echo "cron.allow and cron.deny do not exist! cron will deny access to all users until permissions are fixed"
        runFix "2.4.1.8a" fixes/chap2/chap2_4/chap2_4_1/2_4_1_8a.sh
}
