#! /usr/bin/bash

# 6.3.3.19 [REMEDIATION] Ensure kernel module loading unloading and modification is collected

{
    echo "[REMEDIATION] Ensuring kernel module loading unloading and modification is collected (6.3.3.19)..."

    UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
    rules=(
        "-a always,exit -F arch=b64 -S init_module,finit_module,delete_module -F auid>=${UID_MIN} -F auid!=unset -k kernel_modules"
        "-a always,exit -F path=/usr/bin/kmod -F perm=x -F auid>=${UID_MIN} -F auid!=unset -k kernel_modules"
    )
    [ -n "${UID_MIN}" ] && printf "${rules[@]}" >> /etc/audit/rules.d/50-kernel_modules.rules || printf "ERROR: Variable 'UID_MIN' is unset.\n"

    augenrules --load
    if [[ $(auditctl -s | grep "enabled") =~ "2" ]]; then 
      printf "Reboot required to load rules\n"; 
    fi

    echo "NOTE: If there is an issue with symlinks, it should be further investigated."
    echo "Kernel module loading unloading and modification is now collected."
}