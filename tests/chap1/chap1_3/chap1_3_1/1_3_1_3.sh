#! /usr/bin/bash
source utils.sh

# 1.3.1.3 Ensure all AppArmor Profiles are in enforce or complain mode

{
    echo "Ensure all AppArmor Profiles are in enforce or complain mode (1.3.1.3)..."
    profiles_output=$(apparmor_status | grep profiles)
    processes_output=$(apparmor_status | grep processes)

    # Check for any unconfined processes
    unconfined_processes=$(apparmor_status | grep "0 processes are unconfined but have a profile defined")

    if [[ "$profiles_output" =~ "profiles are loaded" ]] && \
       [[ "$profiles_output" =~ "profiles are in enforce mode" ]] && \
       [[ "$profiles_output" =~ "profiles are in complain mode" ]] && \
       ! apparoor_status | grep -q "0 processes are unconfined"; then
        echo "Audit Result: PASS"
    else
        echo "Audit Result: FAIL"
        echo "Some profiles are not in enforce or complain mode, or there are unconfined processes."

        runFix "1.3.1.3" fixes/chap1/chap1_3/chap1_3_1/1_3_1_3.sh
    fi
}