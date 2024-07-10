#!/usr/bin/bash
source utils.sh

{
    echo "Ensuring permissions on /etc/cron.d/ are configured (2.4.1.7)..."
    stat_output=$(stat -Lc 'Access: (%a/%A) Uid: (%u/%U) Gid: (%g/%G)' /etc/cron.d/)
    
    echo "Output from stat:"
    echo "$stat_output"

    # Extract values for comparison
    permissions=$(stat -Lc '%a' /etc/cron.d/)
    uid=$(stat -Lc '%u/%U' /etc/cron.d/)
    gid=$(stat -Lc '%g/%G' /etc/cron.d/)

    if [[ "$permissions" == "700" && "$uid" == "0/root" && "$gid" == "0/root" ]]; then
        echo "Audit Result: PASS"
    else
        echo "Audit Result: FAIL"
        runFix "2.4.1.7" fixes/chap2/chap2_4/chap2_4_1/2_4_1_7.sh
    fi
}
