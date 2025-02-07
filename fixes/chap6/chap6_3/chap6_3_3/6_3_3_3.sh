#! /usr/bin/bash

# 6.3.3.3 [REMEDIATION] Ensure events that modify the sudo log file are collected

{
    echo "[REMEDIATION] Ensuring events that modify the sudo log file are collected (6.3.3.3)..."

    SUDO_LOG_FILE=$(grep -r logfile /etc/sudoers* | sed -e 's/.*logfile=//;s/,? .*//' -e 's/"//g')
    [ -n "${SUDO_LOG_FILE}" ] && printf " -w ${SUDO_LOG_FILE} -p wa -k sudo_log_file " >> /etc/audit/rules.d/50-sudo.rules || printf "ERROR: Variable 'SUDO_LOG_FILE' is unset.\n"
    augenrules --load
    if [[ $(auditctl -s | grep "enabled") =~ "2" ]]; then 
      printf "Reboot required to load rules\n"; 
    fi

    echo "Events that modify the sudo log file are now collected."
}