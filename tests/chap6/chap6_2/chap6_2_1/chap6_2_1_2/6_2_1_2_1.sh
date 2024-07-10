#! /usr/bin/bash
source utils.sh
# 6.2.1.2.1 Ensure systemd-journal-remote is installed

{
  echo "Ensuring systemd-journal-remote is installed (6.2.1.2.1)..."
  remote_output=$(dpkg-query -s systemd-journal-remote &>/dev/null && echo "systemd-journal-remote is installed")
  
  if [ "$remote_output" == "systemd-journal-remote is installed" ]; then
    echo "systemd-journal-remote audit output:"
    echo "$remote_output"
    echo "Audit Result: PASS"
  else
    echo "systemd-journal-remote audit output:"
    echo "$remote_output"
    echo "Audit Result: FAIL"

    runFix "6.2.1.2.1" fixes/chap6/chap6_2/chap6_2_1/chap6_2_1_2/6_2_1_2_1.sh # Remediation
  fi
}