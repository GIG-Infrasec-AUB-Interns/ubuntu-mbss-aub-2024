#!/usr/bin/bash
source utils.sh

{
    echo "Ensuring permissions on /etc/cron.monthly/ are configured (2.4.1.6)..."
    stat_output=$(stat -Lc 'Access: (%a/%A) Uid: (%u/%U) Gid: (%g/%G)' /etc/cron.monthly/)
    
    echo "Output from stat:"
    echo "$stat_output"

    # Extract values for comparison
    permissions=$(stat -Lc '%a' /etc/cron.monthly/)
    uid=$(stat -Lc '%u/%U' /etc/cron.monthly/)
    gid=$(stat -Lc '%g/%G' /etc/cron.monthly/)

    if [[ "$permissions" == "700" && "$uid" == "0/root" && "$gid" == "0/root" ]]; then
        echo "Audit Result: PASS"
    else
        echo "Audit Result: FAIL"
        runFix "2.4.1.6" fixes/chap2/chap2_4/chap2_4_1/2_4_1_6.sh
    fi
}
