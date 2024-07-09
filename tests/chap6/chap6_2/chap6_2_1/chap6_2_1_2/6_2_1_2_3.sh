#! /usr/bin/bash
source utils.sh
# 6.2.1.2.3 Ensure systemd-journal-upload is enabled and active

{
  echo "Ensuring systemd-journal-uploadis enabled and active (6.2.1.2.3)..."
  is_enabled_output=$(systemctl is-enabled systemd-journal-upload.service)
  is_active_output=$(systemctl is-active systemd-journal-upload.service)

  if [[ "$is_enabled_output" == "enabled" && "$is_active_output" == "active" ]]; then
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

    runFix "6.2.1.2.3" fixes/chap6/chap6_2/chap6_2_1/chap6_2_1_2/6_2_1_2_3.sh # Remediation
  fi
}