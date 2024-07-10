#! /usr/bin/bash
source utils.sh
# 6.3.1.2 Ensure auditd service is enabled and active

{
  echo "Ensuring auditd service is enabled and active (6.3.1.2)..."
  is_enabled_output=$(systemctl is-enabled auditd | grep '^enabled')
  is_active_output=$(systemctl is-active auditd | grep '^active')

  if ([ "$is_enabled_output" == "enabled" ] && [ "$is_active_output" == "active" ]); then
    echo "auditd service is-enabled output:"
    echo "$is_enabled_output"
    echo "auditd service is-active output:"
    echo "$is_active_output"
    echo "Audit Result: PASS"
  else
    echo "auditd service is-enabled output:"
    echo "$is_enabled_output"
    echo "auditd service is-active output:"
    echo "$is_active_output"
    echo "Audit Result: FAIL"

    runFix "6.3.1.2" fixes/chap6/chap6_3/chap6_3_1/6_3_1_2.sh # Remediation
  fi
}