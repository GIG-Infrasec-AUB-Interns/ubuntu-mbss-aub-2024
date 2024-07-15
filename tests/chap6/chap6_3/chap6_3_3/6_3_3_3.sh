#! /usr/bin/bash
source utils.sh
# 6.3.3.3 Ensure events that modify the sudo log file are collected

{
  echo "Ensuring events that modify the sudo log file are collected (6.3.3.3)..."
  expected=(
    "-w /var/log/sudo.log -p wa -k sudo_log_file"
  )

  echo "You can choose to run the audit for either the on disk OR the running configuration."
  read -p "Run the audit for the on disk configuration? (Y/N): " ANSWER
  case "$ANSWER" in
    [Yy]*)
      echo "Running the audit for the on disk configuration..."
      SUDO_LOG_FILE=$(grep -r logfile /etc/sudoers* | sed -e 's/.*logfile=//;s/,? .*//' -e 's/"//g' -e 's|/|\\/|g')
      ondisk_output=$([ -n "${SUDO_LOG_FILE}" ] && awk "/^ *-w/ &&/"${SUDO_LOG_FILE}"/ &&/ +-p *wa/ &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" /etc/audit/rules.d/*.rules || printf "ERROR: Variable 'SUDO_LOG_FILE' is unset.\n")
      matches=$(check "$ondisk_output" "${expected[@]}")

      if [ "$matches" == "true" ]; then
        echo "On disk rules:"
        echo "$ondisk_output"
        echo "Audit Result: PASS"
      else
        echo "On disk rules:"
        echo "$ondisk_output"
        echo "Audit Result: FAIL"
        runFix "6.3.3.3" fixes/chap6/chap6_3/chap6_3_3/6_3_3_3.sh # Remediation
      fi
      ;;
    *)
      echo "Running the audit for the running configuration..."
      SUDO_LOG_FILE=$(grep -r logfile /etc/sudoers* | sed -e 's/.*logfile=//;s/,? .*//' -e 's/"//g' -e 's|/|\\/|g')
      running_output=$([ -n "${SUDO_LOG_FILE}" ] && auditctl -l | awk "/^ *-w/ &&/"${SUDO_LOG_FILE}"/ &&/ +-p *wa/ &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" || printf "ERROR: Variable 'SUDO_LOG_FILE' is unset.\n")
      matches=$(check "$running_output" "${expected[@]}")

      if [ "$matches" == "true" ]; then
        echo "Loaded rules:"
        echo "$running_output"
        echo "Audit Result: PASS"
      else
        echo "Loaded rules:"
        echo "$running_output"
        echo "Audit Result: FAIL"
        runFix "6.3.3.3" fixes/chap6/chap6_3/chap6_3_3/6_3_3_3.sh # Remediation
      fi
      ;;
  esac
}