#!/usr/bin/bash
source utils.sh

{
    echo "Ensuring permissions on /etc/crontab are configured (2.4.1.2)..."
    stat_output=$(stat -Lc 'Access: (%a/%A) Uid: (%u/%U) Gid: (%g/%G)' /etc/crontab)
    
    echo "Output from stat:"
    echo "$stat_output"

    # Extract values for comparison
    permissions=$(stat -Lc '%a' /etc/crontab)
    uid=$(stat -Lc '%u/%U' /etc/crontab)
    gid=$(stat -Lc '%g/%G' /etc/crontab)

    if [[ "$permissions" == "600" && "$uid" == "0/root" && "$gid" == "0/root" ]]; then
        echo "Audit Result: PASS"
    else
        echo "Audit Result: FAIL"
        runFix "2.4.1.2" fixes/chap2/chap2_4/chap2_4_1/2_4_1_2.sh
    fi
}
