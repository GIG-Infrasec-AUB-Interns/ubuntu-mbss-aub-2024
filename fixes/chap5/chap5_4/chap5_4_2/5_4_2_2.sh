#!/usr/bin/bash
source utils.sh
source globals.sh

{
    echo "[REMEDIATION] Ensure root is the only GID 0 account (5.4.2.2)..."

    # Find all users with GID 0 other than root, sync, shutdown, halt, and operator
    gid_0_users=$(awk -F: '($1 !~ /^(root|sync|shutdown|halt|operator)/ && $4=="0") { print $1 }' /etc/passwd)
    
    if [[ -n $gid_0_users ]]; then
        echo "Changing GID of non-root users with GID 0..."

        for user in $gid_0_users; do
            echo "Modifying user $user to have a new GID..."

            # Find the highest current GID and add 1 to get a unique GID
            new_gid=$(awk -F: '($3 >= 1000) { if ($3 > max) max=$3 } END { print max+1 }' /etc/group)

            usermod -g $new_gid $user
            echo "User $user has been assigned a new GID: $new_gid"
        done
    else
        echo "No non-root users with GID 0 found."
    fi

    echo "Changing GID of root to 0..."
    usermod -g 0 root
    echo "Setting the root group's GID to 0..."
    groupmod -g 0 root

    echo "Remediation successful."
}
