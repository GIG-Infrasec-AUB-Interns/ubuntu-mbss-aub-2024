#! /usr/bin/bash
source utils.sh
# 6.2.1.1.1 Ensure journald service is enabled and active

{
  echo "Ensuring journald service is enabled and active (6.2.1.1.1)..."
  is_enabled_output=$(systemctl is-enabled systemd-journald.service)
  is_active_output=$(systemctl is-active systemd-journald.service)

  if [[ "$is_enabled_output" == "static" && "$is_active_output" == "active" ]]; then
    echo "journald is-enabled output:"
    echo "$is_enabled_output"
    echo "journald is-active output:"
    echo "$is_active_output"
    echo "Audit Result: PASS"
  else
    echo "journald is-enabled output:"
    echo "$is_enabled_output"
    echo "journald is-active output:"
    echo "$is_active_output"
    echo "Audit Result: FAIL"

    runFix "6.2.1.1.1" fixes/chap6/chap6_2/chap6_2_1/chap6_2_1_1/6_2_1_1_1.sh # Remediation
  fi
}