#! /usr/bin/bash
source utils.sh
# 6.3.2.2 Ensure audit logs are not automatically deleted

{
  echo "Ensuring audit logs are not automatically deleted (6.3.2.2)..."
  max_log_file_action=$(grep max_log_file_action /etc/audit/auditd.conf)

  if [ "$max_log_file_action" == "max_log_file_action = keep_logs" ]; then
    echo "$max_log_file_action"
    echo "Audit Result: PASS"
  else
    echo "$max_log_file_action"
    echo "Audit Result: FAIL"

    runFix "6.3.2.2" fixes/chap6/chap6_3/chap6_3_2/6_3_2_2.sh # Remediation
  fi
}