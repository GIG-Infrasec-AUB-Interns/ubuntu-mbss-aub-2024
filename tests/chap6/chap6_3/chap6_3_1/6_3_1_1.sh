#! /usr/bin/bash
source utils.sh
# 6.3.1.1 Ensure auditd packages are installed

{
  echo "Ensuring auditd packages are installed (6.3.1.1)..."
  auditd_output=$(dpkg-query -s auditd &>/dev/null && echo auditd is installed)
  audispd_plugins_output=$(dpkg-query -s audispd-plugins &>/dev/null && echo audispd-plugins is installed)
  
  if ([ "$auditd_output" == "auditd is installed" ] && [ "$audispd_plugins_output" == "audispd-plugins is installed" ]); 
  then
    echo "auditd audit output:"
    echo "$auditd_output"
    echo "audispd-plugins audit output:"
    echo "$audispd_plugins_output"
    echo "Audit Result: PASS"
  else
    echo "auditd audit output:"
    echo "$auditd_output"
    echo "audispd-plugins audit output:"
    echo "$audispd_plugins_output"
    echo "Audit Result: FAIL"

    runFix "6.3.1.1" fixes/chap6/chap6_3/chap6_3_1/6_3_1_1.sh # Remediation
  fi
}