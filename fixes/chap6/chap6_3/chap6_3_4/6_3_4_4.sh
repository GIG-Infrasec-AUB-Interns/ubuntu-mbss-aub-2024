#!/usr/bin/env bash 

# 6.3.4.4 [REMEDIATION] Ensure the audit log file directory mode is configured

{ 
  echo "[REMEDIATION] Ensuring the audit log file directory mode is configured (6.3.4.4)..."
  
  chmod g-w,o-rwx "$(dirname "$(awk -F= '/^\s*log_file\s*/{print $2}' /etc/audit/auditd.conf | xargs)")"

  echo "Audit log file directory mode is now configured."
}