#!/usr/bin/env bash 

# 6.3.4.3 [REMEDIATION] Ensure audit log files group owner is configured

{ 
  echo "[REMEDIATION] Ensuring audit log files group owner is configured (6.3.4.3)..."
  
  find $(dirname $(awk -F"=" '/^\s*log_file/ {print $2}' /etc/audit/auditd.conf | xargs)) -type f \( ! -group adm -a ! -group root \) -exec chgrp adm {} +
  sed -ri 's/^\s*#?\s*log_group\s*=\s*\S+(\s*#.*)?.*$/log_group = adm\1/' /etc/audit/auditd.conf
  systemctl restart auditd

  echo "Audit log files group owner is now configured."
}