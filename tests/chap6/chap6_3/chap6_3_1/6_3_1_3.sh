#! /usr/bin/bash
# 6.3.1.3 Ensure auditing for processes that start prior to auditd is enabled

{
  echo "Ensuring auditing for processes that start prior to auditd is enabled (6.3.1.3)..."
  audit_output=$(find /boot -type f -name 'grub.cfg' -exec grep -Ph -- '^\h*linux' {} + | grep -v 'audit=1')

  if [ -z "$audit_output" ]; then
    echo "Return output:"
    echo "$audit_output"
    echo "Audit Result: PASS"
  else
    echo "Return output:"
    echo "$audit_output"
    echo "Audit Result: FAIL"

    runFix "6.3.1.3" fixes/chap6/chap6_3/chap6_3_1/6_3_1_3.sh # Remediation
  fi
}