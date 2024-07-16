#!/usr/bin/bash
source utils.sh
source globals.sh

{
    echo "[REMEDIATION] Ensure root is the only UID 0 account (5.4.2.1)..."

    # Find all users with UID 0 other than root
    uid_0_users=$(awk -F: '($3 == 0 && $1 != "root") { print $1 }' /etc/passwd)

    if [[ -n $uid_0_users ]]; then
        echo "Changing UID of non-root users with UID 0..."

        for user in $uid_0_users; do
            echo "Modifying user $user to have a new UID..."

            # Find the highest current UID and add 1 to get a unique UID
            new_uid=$(awk -F: '($3 >= 1000) { if ($3 > max) max=$3 } END { print max+1 }' /etc/passwd)

            usermod -u $new_uid $user
            echo "User $user has been assigned a new UID: $new_uid"
        done
    else
        echo "No non-root users with UID 0 found."
    fi

    echo "Remediation successful."
}
