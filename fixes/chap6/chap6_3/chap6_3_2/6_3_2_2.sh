#!/usr/bin/env bash 

# 6.3.2.2 [REMEDIATION] Ensure audit logs are not automatically deleted

{ 
  echo "[REMEDIATION] Ensuring audit logs are not automatically deleted (6.3.2.2)..."

  if grep -q "^max_log_file_action" /etc/audit/auditd.conf; then
    sed -i "s/^max_log_file_action.*/max_log_file_action = keep_logs/" /etc/audit/auditd.conf
  else
    echo "max_log_file_action = keep_logs" >> /etc/audit/auditd.conf
  fi

  echo "Audit logs are no longer automatically deleted."
}