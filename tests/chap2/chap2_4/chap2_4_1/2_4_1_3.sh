#!/usr/bin/bash
source utils.sh

{
    echo "Ensuring permissions on /etc/cron.hourly/ are configured (2.4.1.3)..."
    stat_output=$(stat -Lc 'Access: (%a/%A) Uid: (%u/%U) Gid: (%g/%G)' /etc/cron.hourly/)
    
    echo "Output from stat:"
    echo "$stat_output"

    # Extract values for comparison
    permissions=$(stat -Lc '%a' /etc/cron.hourly/)
    uid=$(stat -Lc '%u/%U' /etc/cron.hourly/)
    gid=$(stat -Lc '%g/%G' /etc/cron.hourly/)

    if [[ "$permissions" == "700" && "$uid" == "0/root" && "$gid" == "0/root" ]]; then
        echo "Audit Result: PASS"
    else
        echo "Audit Result: FAIL"
        runFix "2.4.1.3" fixes/chap2/chap2_4/chap2_4_1/2_4_1_3.sh
    fi
}
