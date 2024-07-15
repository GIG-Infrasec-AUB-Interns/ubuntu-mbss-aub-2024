#! /usr/bin/bash
source utils.sh
# 6.3.3.6 Ensure use of privileged commands are collected

{
  echo "Ensuring use of privileged commands are collected (6.3.3.6)..."

  findmnt -n -l -k -it $(awk '/nodev/ { print $2 }' /proc/filesystems | paste -sd,) | grep -Pv "noexec|nosuid"
  echo "Before proceeding, inspect the output above to determine exactly which file systems will be traversed."
  echo "To exclude a particular file system due to adverse performance impacts, please update the audit and remediation scripts by adding a sufficiently unique string to the grep statement."

  read -p "Would you like to proceed with the audit? (Y/N): " ANSWER_1
  case "$ANSWER_1" in
    [Yy]*)
      echo "You can choose to run the audit for either the on disk OR the running configuration."
      read -p "Run the audit for the on disk configuration? (Y/N): " ANSWER_2
      case "$ANSWER_2" in
        [Yy]*)
          echo "Running the audit for the on disk configuration..."
          for PARTITION in $(findmnt -n -l -k -it $(awk '/nodev/ { print $2 }' /proc/filesystems | paste -sd,) | grep -Pv "noexec|nosuid" | awk '{print $1}'); do 
            for PRIVILEGED in $(find "${PARTITION}" -xdev -perm /6000 -type f); do 
              grep -qr "${PRIVILEGED}" /etc/audit/rules.d && printf "OK: '${PRIVILEGED}' found in auditing rules.\n" || printf "Warning: '${PRIVILEGED}' not found in on disk configuration.\n" 
            done 
          done

          echo "Please verify that all output is OK"
          runFix "6.3.3.6" fixes/chap6/chap6_3/chap6_3_3/6_3_3_6.sh # Remediation
          ;;
        *)
          echo "Running the audit for the running configuration..."
          RUNNING=$(auditctl -l) 
          [ -n "${RUNNING}" ] && for PARTITION in $(findmnt -n -l -k -it $(awk '/nodev/ { print $2 }' /proc/filesystems | paste -sd,) | grep -Pv "noexec|nosuid" | awk '{print $1}'); do 
            for PRIVILEGED in $(find "${PARTITION}" -xdev -perm /6000 -type f); do 
              printf -- "${RUNNING}" | grep -q "${PRIVILEGED}" && printf "OK: '${PRIVILEGED}' found in auditing rules.\n" || printf "Warning: '${PRIVILEGED}' not found in running configuration.\n" 
            done 
          done || printf "ERROR: Variable 'RUNNING' is unset.\n"
          
          echo "Please verify that all output is OK"
          runFix "6.3.3.6" fixes/chap6/chap6_3/chap6_3_3/6_3_3_6.sh # Remediation
          ;;
      esac 
      ;;
    *)
      echo "Cancelling audit (6.3.3.6)..."
      ;;
  esac
}