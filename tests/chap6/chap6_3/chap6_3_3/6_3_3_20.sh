#! /usr/bin/bash
source utils.sh
# 6.3.3.20 Ensure the audit configuration is immutable

{
  echo "Ensuring the audit configuration is immutable (6.3.3.20)..."
  audit_output=$(grep -Ph -- '^\h*-e\h+2\b' /etc/audit/rules.d/*.rules | tail -1)

  if [ "$audit_output" == "-e 2" ]; then
    echo "Audit output:"
    echo "$audit_output"
    echo "Audit Result: PASS"
  else
    echo "Audit output:"
    echo "$audit_output"
    echo "Audit Result: FAIL"

    runFix "6.3.3.20" fixes/chap6/chap6_3/chap6_3_3/6_3_3_20.sh # Remediation
  fi
}