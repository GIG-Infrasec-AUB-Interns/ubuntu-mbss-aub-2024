#! /usr/bin/bash
source utils.sh
# 7.2.1 Ensure accounts in /etc/passwd use shadowed passwords

{
  echo "Ensuring accounts in /etc/passwd use shadowed passwords (7.2.1)..."
  audit_output=$(awk -F: '($2 != "x" ) { print "User: \"" $1 "\" is not set to shadowed passwords "}' /etc/passwd)

  if [ -z $audit_output ]; then
    echo "Audit output:"
    echo "$audit_output"
    echo "Audit Result: PASS"
  else
    echo "Audit output:"
    echo "$audit_output"
    echo "Audit Result: FAIL"
  
    runFix "7.2.1" fixes/chap7/chap7_2/7_2_1.sh # Remediation
  fi
}
