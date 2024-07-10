#! /usr/bin/bash
source utils.sh
# 6.2.1.2.4 Ensure systemd-journal-remote service is not in use

{
  echo "Ensuring systemd-journal-remote service is not in use (6.2.1.2.4)..."
  is_enabled_output=$(systemctl is-enabled systemd-journal-remote.socket systemd-journal-remote.service | grep -P -- '^enabled')
  is_active_output=$(systemctl is-active systemd-journal-remote.socket systemd-journal-remote.service | grep -P -- '^active')

  if ([ -z "$is_enabled_output" ] && [ -z "$is_active_output" ]); then
    echo "systemd-journal-remote is-enabled output:"
    echo "$is_enabled_output"
    echo "systemd-journal-remote is-active output:"
    echo "$is_active_output"
    echo "Audit Result: PASS"
  else
    echo "systemd-journal-remote is-enabled output:"
    echo "$is_enabled_output"
    echo "systemd-journal-remote is-active output:"
    echo "$is_active_output"
    echo "Audit Result: FAIL"

    runFix "6.2.1.2.4" fixes/chap6/chap6_2/chap6_2_1/chap6_2_1_2/6_2_1_2_4.sh # Remediation
  fi
}