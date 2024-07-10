#! /usr/bin/bash
source utils.sh
# 7.1.5 Ensure permissions on /etc/shadow are configured

{
  echo "Ensuring permissions on /etc/shadow are configured (7.1.5)..."
  audit_output=$(stat -Lc 'Access: (%#a) Uid: (%u/%U) Gid: (%g/ %G)' /etc/shadow)

  permissions=$(echo $audit_output | awk '{print $2}' | tr -d '()%#')
  uid=$(echo $audit_output | awk '{print $4}' | tr -d '()%#')
  gid=$(echo $audit_output | awk '{print $7}' | tr -d '()%#')

  if ([ $permissions -le 0640 ] && [ "$uid" == "0/root" ]) && ([ "$gid" == "root" ] || [ "$gid" == "shadow" ]); then
    echo "Audit output:"
    echo "$audit_output"
    echo "Audit Result: PASS"
  else
    echo "Audit output:"
    echo "$audit_output"
    echo "Audit Result: FAIL"
  
    runFix "7.1.5" fixes/chap7/chap7_1/7_1_5.sh # Remediation
  fi
}
