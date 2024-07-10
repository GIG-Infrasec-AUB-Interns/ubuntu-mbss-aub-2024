#! /usr/bin/bash
source utils.sh
# 6.3.2.1 Ensure audit log storage size is configured

{
  echo "Ensuring audit log storage size is configured (6.3.2.1)..."
  echo "Please enter the maximum size of the audit log file in accordance with your site's policy:"
  read MAX_LOG_FILE_POLICY
  max_log_file=$(grep -Po -- '^\h*max_log_file\h*=\h*\K\d+\b' /etc/audit/auditd.conf)

  if [ "$max_log_file" == "$MAX_LOG_FILE_POLICY" ]; then
    echo "max_log_file: $max_log_file"
    echo "Audit Result: PASS"
  else
    echo "max_log_file: $max_log_file"
    echo "Audit Result: FAIL"

    runFix "6.3.2.1" fixes/chap6/chap6_3/chap6_3_2/6_3_2_1.sh # Remediation
  fi
}