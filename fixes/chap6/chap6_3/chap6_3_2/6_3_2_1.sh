#!/usr/bin/env bash 

# 6.3.2.1 [REMEDIATION] Ensure audit log storage size is configured

{ 
  echo "[REMEDIATION] Ensuring audit log storage size is configured (6.3.2.1)..."
  echo "Please enter the maximum size of the audit log file in accordance with your site's policy:"
  read MAX_LOG_FILE_POLICY

  if ! [[ "$MAX_LOG_FILE_POLICY" =~ ^[0-9]+$ ]]; then
    echo "Error: The argument must be a positive integer."
  else
    if grep -q "^max_log_file" /etc/audit/auditd.conf; then
      sed -i "s/^max_log_file.*/max_log_file = $MAX_LOG_FILE/" /etc/audit/auditd.conf
    else
      echo "max_log_file = $MAX_LOG_FILE" >> /etc/audit/auditd.conf
    fi

    echo "Audit log storage size is now configured."
  fi
}