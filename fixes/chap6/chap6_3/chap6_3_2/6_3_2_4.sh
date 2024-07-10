#!/usr/bin/env bash 

# 6.3.2.4 [REMEDIATION] Ensure system warns when audit logs are low on space

{ 
  echo "[REMEDIATION] Ensuring system warns when audit logs are low on space (6.3.2.4)..."
  echo "Please enter your site's policy on space_left_action (email/exec/single/halt):"
  read SPACE_LEFT_ACTION_POLICY
  echo "Please enter your site's policy on admin_space_left_action (single/halt):"
  read ADMIN_SPACE_LEFT_ACTION_POLICY

  # Set space_left_action 
  if grep -q "^space_left_action" /etc/audit/auditd.conf; then
    sed -i "s/^space_left_action.*/space_left_action = $SPACE_LEFT_ACTION_POLICY/" /etc/audit/auditd.conf
  else
    echo "space_left_action = $SPACE_LEFT_ACTION_POLICY" >> /etc/audit/auditd.conf
  fi

  # Set admin_space_left_action
  if grep -q "^admin_space_left_action" /etc/audit/auditd.conf; then
    sed -i "s/^admin_space_left_action.*/admin_space_left_action = $ADMIN_SPACE_LEFT_ACTION_POLICY/" /etc/audit/auditd.conf
  else
    echo "admin_space_left_action = $ADMIN_SPACE_LEFT_ACTION_POLICY" >> /etc/audit/auditd.conf
  fi

  echo "System now warns when audit logs are low on space."
}