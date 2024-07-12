#!/usr/bin/bash
source utils.sh

{
    echo "Ensuring at is restricted to authorized users (2.4.2.1)..."

    # Check if /etc/at.allow exists
    if [ -e "/etc/at.allow" ]; then
        at_allow_output=$(stat -Lc 'Access: (%a/%A) Owner: (%U) Group: (%G)' /etc/at.allow)
        echo "Output from /etc/at.allow stat:"
        echo "$at_allow_output"

        # Extract values for comparison (at allow)
        at_allow_permissions=$(stat -Lc '%a' /etc/at.allow)
        at_allow_owner=$(stat -Lc '%U' /etc/at.allow)
        at_allow_group=$(stat -Lc '%G' /etc/at.allow)

        if [[ "$at_allow_permissions" == "640" && "$at_allow_owner" == "root" && ( "$at_allow_group" == "root" || "$at_allow_group" == "daemon") ]]; then
            echo "Audit Result: PASS"
        else
            echo "Audit Result: FAIL"
            runFix "2.4.2.1" fixes/chap2/chap2_4/chap2_4_2/2_4_2_1.sh
        fi

    # Check if /etc/at.deny exists
    elif [ -e "/etc/at.deny" ]; then
        at_deny_output=$(stat -Lc 'Access: (%a/%A) Owner: (%U) Group: (%G)' /etc/at.deny)
        echo "Output from /etc/at.deny stat:"
        echo "$at_deny_output"

        # Extract values for comparison (at deny)
        at_deny_permissions=$(stat -Lc '%a' /etc/at.deny)
        at_deny_owner=$(stat -Lc '%U' /etc/at.deny)
        at_deny_group=$(stat -Lc '%G' /etc/at.deny)

        if [[ "$at_deny_permissions" == "640" && "$at_deny_owner" == "root" && ( "$at_deny_group" == "root" || "$at_deny_group" == "daemon")]]; then
            echo "Audit Result: PASS"
        else
            echo "Audit Result: FAIL"
            runFix "2.4.2.1" fixes/chap2/chap2_4/chap2_4_2/2_4_2_1.sh
        fi

    # If neither /etc/at.allow nor /etc/at.deny exist
    else
        echo "at.allow and at.deny do not exist! at will deny access to all users until permissions are fixed"
        runFix "2.4.2.1" fixes/chap2/chap2_4/chap2_4_2/2_4_2_1.sh
}
