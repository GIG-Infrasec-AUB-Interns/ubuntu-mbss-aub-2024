#!/usr/bin/env bash 

# 6.3.4.1 [REMEDIATION] Ensure audit log files mode is configured

{ 
  echo "[REMEDIATION] Ensuring audit log files mode is configured (6.3.4.1)..."
  
  [ -f /etc/audit/auditd.conf ] && find "$(dirname $(awk -F "=" '/^\s*log_file/ {print $2}' /etc/audit/auditd.conf | xargs))" -type f -perm /0137 -exec chmod u-x,g-wx,o-rwx {} +

  echo "Audit log files mode is now configured."
}