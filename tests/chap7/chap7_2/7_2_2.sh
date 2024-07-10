#! /usr/bin/bash

# 7.2.2 Ensure /etc/shadow password fields are not empty

{
  echo "Ensuring /etc/shadow password fields are not empty (7.2.2)..."
  audit_output=$(awk -F: '($2 == "" ) { print $1 " does not have a password "}' /etc/shadow)

  if [ -z $audit_output ]; then
    echo "Audit output:"
    echo "$audit_output"
    echo "Audit Result: PASS"
  else
    echo "Audit output:"
    echo "$audit_output"
    echo "Audit Result: FAIL"
  
    echo "For remediation, run the following command for each account without a password:"
    echo "passwd -l <username>"
    echo "This will lock the account until it can be determined why it does not have a password."
  fi
}
