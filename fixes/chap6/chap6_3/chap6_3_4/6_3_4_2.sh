#!/usr/bin/env bash 

# 6.3.4.2 [REMEDIATION] Ensure audit log files owner is configured

{ 
  echo "[REMEDIATION] Ensuring audit log files owner is configured (6.3.4.2)..."
  
  [ -f /etc/audit/auditd.conf ] && find "$(dirname $(awk -F "=" '/^\s*log_file/ {print $2}' /etc/audit/auditd.conf | xargs))" -type f ! -user root -exec chown root {} +

  echo "Audit log files owner is now configured."
}