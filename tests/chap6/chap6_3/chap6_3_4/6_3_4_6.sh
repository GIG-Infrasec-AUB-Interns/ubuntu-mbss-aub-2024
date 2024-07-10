#! /usr/bin/bash
source utils.sh
# 6.3.4.6 Ensure audit configuration files owner is configured

{
  echo "Ensuring audit configuration files owner is configured (6.3.4.6)..."
  audit_output=$(find /etc/audit/ -type f \( -name '*.conf' -o -name '*.rules' \) ! -user root)
  
  if [ -z "$audit_output" ]; then
    echo "Audit output:"
    echo "$audit_output"
    echo "Audit Result: PASS"
  else
    echo "Audit output:"
    echo "$audit_output"
    echo "Audit Result: FAIL"

    runFix "6.3.4.6" fixes/chap6/chap6_3/chap6_3_4/6_3_4_6.sh # Remediation
  fi
}