#! /usr/bin/bash

# 6.3.3.17 [REMEDIATION] Ensure successful and unsuccessful attempts to use the chacl command are recorded

{
    echo "[REMEDIATION] Ensuring successful and unsuccessful attempts to use the chacl command are recorded (6.3.3.17)..."

    UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
    rules=(
        "-a always,exit -F path=/usr/bin/chacl -F perm=x -F auid>=${UID_MIN} -F auid!=unset -k perm_chng"
    )
    [ -n "${UID_MIN}" ] && printf "${rules[@]}" >> /etc/audit/rules.d/50-perm_chng.rules || printf "ERROR: Variable 'UID_MIN' is unset.\n"

    augenrules --load
    if [[ $(auditctl -s | grep "enabled") =~ "2" ]]; then 
      printf "Reboot required to load rules\n"; 
    fi

    echo "successful and unsuccessful attempts to use the chacl command are now recorded."
}