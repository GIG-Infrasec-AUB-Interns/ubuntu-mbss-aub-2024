#! /usr/bin/bash
source utils.sh
# 6.3.1.4 Ensure audit_backlog_limit is sufficient

{
  echo "Ensuring audit_backlog_limit is sufficient (6.3.1.4)..."
  audit_output=$(find /boot -type f -name 'grub.cfg' -exec grep -Ph -- '^\h*linux' {} + | grep -Pv 'audit_backlog_limit=\d+\b')

  if [ -z "$audit_output" ]; then
    echo "Return output:"
    echo "$audit_output"
    echo "Audit Result: PASS"
  else
    echo "Return output:"
    echo "$audit_output"
    echo "Audit Result: FAIL"

    runFix "6.3.1.4" fixes/chap6/chap6_3/chap6_3_1/6_3_1_4.sh # Remediation
  fi
}