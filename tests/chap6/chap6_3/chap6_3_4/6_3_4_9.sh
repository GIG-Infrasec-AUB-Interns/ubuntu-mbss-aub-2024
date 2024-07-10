#! /usr/bin/bash
source utils.sh
# 6.3.4.9 Ensure audit tools owner is configured

{
  echo "Ensuring audit tools owner is configured (6.3.4.9)..."
  audit_output=$(stat -Lc "%n %U" /sbin/auditctl /sbin/aureport /sbin/ausearch /sbin/autrace /sbin/auditd /sbin/augenrules | awk '$2 != "root" {print}')
  
  if [ -z "$audit_output" ]; then
    echo "Audit output:"
    echo "$audit_output"
    echo "Audit Result: PASS"
  else
    echo "Audit output:"
    echo "$audit_output"
    echo "Audit Result: FAIL"

    runFix "6.3.4.9" fixes/chap6/chap6_3/chap6_3_4/6_3_4_9.sh # Remediation
  fi
}