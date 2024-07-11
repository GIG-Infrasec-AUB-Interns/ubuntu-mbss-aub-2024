#! /usr/bin/bash
source utils.sh
# 7.1.1 Ensure permissions on /etc/passwd are configured

{
  echo "Ensuring permissions on /etc/passwd are configured (7.1.1)..."
  audit_output=$(stat -Lc 'Access: (%#a) Uid: (%u/%U) Gid: (%g/%G)' /etc/passwd)

  permissions=$(echo $audit_output | awk '{print $2}' | tr -d '()%#')
  uid=$(echo $audit_output | awk '{print $4}' | tr -d '()%#')
  gid=$(echo $audit_output | awk '{print $6}' | tr -d '()%#')

  if ([ $permissions -le 0644 ] && [ "$uid" == "0/root" ] && [ "$gid" == "0/root" ]); then
    echo "Audit output:"
    echo "$audit_output"
    echo "Audit Result: PASS"
  else
    echo "Audit output:"
    echo "$audit_output"
    echo "Audit Result: FAIL"
  
    runFix "7.1.1" fixes/chap7/chap7_1/7_1_1.sh # Remediation
  fi
}
