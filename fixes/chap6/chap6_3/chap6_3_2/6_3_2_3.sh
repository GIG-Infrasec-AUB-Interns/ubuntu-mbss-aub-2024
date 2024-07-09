#!/usr/bin/env bash 

# 6.3.2.3 [REMEDIATION] Ensure system is disabled when audit logs are full

{ 
  echo "[REMEDIATION] Ensuring system is disabled when audit logs are full (6.3.2.3)..."
  echo "Please enter your site's policy on disk_full_action (halt/single):"
  read DISK_FULL_ACTION_POLICY
  echo "Please enter your site's policy on disk_error_action (syslog/single/halt):"
  read DISK_ERROR_ACTION_POLICY

  # Set disk_full_action 
  if grep -q "^disk_full_action" /etc/audit/auditd.conf; then
    sed -i "s/^disk_full_action.*/disk_full_action = $DISK_FULL_ACTION_POLICY/" /etc/audit/auditd.conf
  else
    echo "disk_full_action = $DISK_FULL_ACTION_POLICY" >> /etc/audit/auditd.conf
  fi

  # Set disk_error_action 
  if grep -q "^disk_error_action" /etc/audit/auditd.conf; then
    sed -i "s/^disk_error_action.*/disk_error_action = $DISK_ERROR_ACTION_POLICY/" /etc/audit/auditd.conf
  else
    echo "disk_error_action = $DISK_ERROR_ACTION_POLICY" >> /etc/audit/auditd.conf
  fi

  echo "System is now disabled when audit logs are full."
}