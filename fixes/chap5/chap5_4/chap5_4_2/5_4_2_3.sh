#!/usr/bin/bash
source utils.sh
source globals.sh

{
    echo "[REMEDIATION] Ensure group root is the only GID 0 group (5.4.2.3)..."

    # Find all groups with GID 0 other than root
    gid_0_groups=$(awk -F: '($1 != "root" && $3 == 0) {print $1}' /etc/group)

    if [[ -n $gid_0_groups ]]; then
        echo "Changing GID of non-root groups with GID 0..."

        for group in $gid_0_groups; do
            echo "Modifying group $group to have a new GID..."

            # Find the highest current GID and add 1 to get a unique GID
            new_gid=$(awk -F: '($3 >= 1000) { if ($3 > max) max=$3 } END { print max+1 }' /etc/group)

            groupmod -g $new_gid $group
            echo "Group $group has been assigned a new GID: $new_gid"
        done
    else
        echo "No non-root groups with GID 0 found."
    fi

    echo "Setting the root group's GID to 0..."
    groupmod -g 0 root

    echo "Remediation successful."
}
