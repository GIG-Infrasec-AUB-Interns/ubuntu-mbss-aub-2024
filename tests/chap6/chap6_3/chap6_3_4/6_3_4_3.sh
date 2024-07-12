#! /usr/bin/bash
source utils.sh
# 6.3.4.2 Ensure audit log files group owner is configured

{
  echo "Ensuring audit log files group owner is configured (6.3.4.2)..."
  log_group=$(grep -Piws -- '^\h*log_group\h*=\h*\H+\b' /etc/audit/auditd.conf | grep -Pvi -- '(adm)')
  log_owner=""

  if [ -e /etc/audit/auditd.conf ]; then 
    l_fpath="$(dirname "$(awk -F "=" '/^\s*log_file/ {print $2}' /etc/audit/auditd.conf | xargs)")" 
    log_owner=$(find -L "$l_fpath" -not -path "$l_fpath"/lost+found -type f \( ! -group root -a ! -group adm \) -exec ls -l {} +) 
  fi

  if ([ -z "$log_group" ] && [ -z "$log_owner" ]); then
    echo "log_group audit output:"
    echo "$log_group"
    echo "log owner audit output:"
    echo "$log_owner"
    echo "Audit Result: PASS"
  else
    echo "log_group audit output:"
    echo "$log_group"
    echo "log owner audit output:"
    echo "$log_owner"
    echo "Audit Result: FAIL"

    runFix "6.3.4.3" fixes/chap6/chap6_3/chap6_3_4/6_3_4_3.sh # Remediation
  fi
}