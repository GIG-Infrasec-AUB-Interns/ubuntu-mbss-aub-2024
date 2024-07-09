#! /usr/bin/bash
source utils.sh
# 6.3.2.3 Ensure system is disabled when audit logs are full

{
  echo "Ensuring system is disabled when audit logs are full (6.3.2.3)..."
  disk_full_action=$(grep -Pi -- '^\h*disk_full_action\h*=\h*(halt|single)\b' /etc/audit/auditd.conf)
  disk_error_action=$(grep -Pi -- '^\h*disk_error_action\h*=\h*(syslog|single|halt)\b' /etc/audit/auditd.conf)

  if ([ -z "$disk_full_action" ] && [ -z "$disk_error_action" ] ); then
    echo "disk_full_action is not halt or single"
    echo "disk_error_action is not syslog, single, or halt"
    echo "Audit Result: FAIL"

    runFix "6.3.2.3" fixes/chap6/chap6_3/chap6_3_2/6_3_2_3.sh # Remediation
  else
    echo "$disk_full_action"
    echo "$disk_error_action"
    echo "Audit Result: PASS"
  fi
}