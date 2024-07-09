#! /usr/bin/bash
source utils.sh
# 6.3.4.7 Ensure audit configuration files group owner is configured

{
  echo "Ensuring audit configuration files group owner is configured (6.3.4.7)..."
  audit_output=$(find /etc/audit/ -type f \( -name '*.conf' -o -name '*.rules' \) ! -group root)
  
  if [ -z "$audit_output" ]; then
    echo "Audit output:"
    echo "$audit_output"
    echo "Audit Result: PASS"
  else
    echo "Audit output:"
    echo "$audit_output"
    echo "Audit Result: FAIL"

    runFix "6.3.4.7" fixes/chap6/chap6_3/chap6_3_4/6_3_4_7.sh # Remediation
  fi
}