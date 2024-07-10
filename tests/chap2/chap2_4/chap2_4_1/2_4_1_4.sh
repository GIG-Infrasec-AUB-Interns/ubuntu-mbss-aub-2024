#!/usr/bin/bash
source utils.sh

{
    echo "Ensuring permissions on /etc/cron.daily/ are configured (2.4.1.4)..."
    stat_output=$(stat -Lc 'Access: (%a/%A) Uid: (%u/%U) Gid: (%g/%G)' /etc/cron.daily/)
    
    echo "Output from stat:"
    echo "$stat_output"

    # Extract values for comparison
    permissions=$(stat -Lc '%a' /etc/cron.daily/)
    uid=$(stat -Lc '%u/%U' /etc/cron.daily/)
    gid=$(stat -Lc '%g/%G' /etc/cron.daily/)

    if [[ "$permissions" == "700" && "$uid" == "0/root" && "$gid" == "0/root" ]]; then
        echo "Audit Result: PASS"
    else
        echo "Audit Result: FAIL"
        runFix "2.4.1.4" fixes/chap2/chap2_4/chap2_4_1/2_4_1_4.sh
    fi
}
