#!/usr/bin/bash
source utils.sh
source globals.sh

{
    echo "[REMEDIATION] Ensure inactive password lock is configured (5.4.1.5)..."
    
    # set the default password inactivity period
    useradd -D -f $SET_INACTIVEPW_LOCK
    
    # modify user parameters for all users
    awk -F: '($2~/^\$.+\$/) {if($7 > 45 || $7 < 0)system ("chage --inactive 45 " $1)}' /etc/shadow

    echo "Remediation successful."
}
