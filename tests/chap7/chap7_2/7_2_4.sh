#! /usr/bin/bash
source utils.sh
# 7.2.4 Ensure shadow group is empty

{
  echo "Ensuring shadow group is empty (7.2.4)..."
  group_output=$(awk -F: '($1=="shadow") {print $NF}' /etc/group)
  passwd_output=$(awk -F: '($4 == '"$(getent group shadow | awk -F: '{print $3}' | xargs)"') {print " - user: \"" $1 "\" primary group is the shadow group"}' /etc/passwd)

  if ([ -z $group_output ] && [ -z $passwd_output ]); then
    echo "Audit output:"
    echo "$group_output"
    echo "$passwd_output"
    echo "Audit Result: PASS"
  else
    echo "Audit output:"
    echo "$group_output"
    echo "$passwd_output"
    echo "Audit Result: FAIL"
  
    runFix "7.2.4" fixes/chap7/chap7_2/7_2_4.sh # Remediation
  fi
}
