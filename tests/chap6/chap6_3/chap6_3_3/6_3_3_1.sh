#! /usr/bin/bash
source utils.sh
# 6.3.3.1 Ensure changes to system administration scope (sudoers) is collected

{
  echo "Ensuring changes to system administration scope (sudoers) is collected (6.3.3.1)..."
  expected=(
    "-w /etc/sudoers -p wa -k scope"
    "-w /etc/sudoers.d -p wa -k scope"
  )

  echo "You can choose to run the audit for either the on disk OR the running configuration."
  read -p "Run the audit for the on disk configuration? (Y/N): " ANSWER
  case "$ANSWER" in
    [Yy]*)
      echo "Running the audit for the on disk configuration..."
      ondisk_output=$(awk '/^ *-w/ &&/\/etc\/sudoers/ &&/ +-p *wa/ &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules)
      matches=$(check "$ondisk_output" "${expected[@]}")

      if [ "$matches" == "true" ]; then
        echo "On disk rules:"
        echo "$ondisk_output"
        echo "Audit Result: PASS"
      else
        echo "On disk rules:"
        echo "$ondisk_output"
        echo "Audit Result: FAIL"
        runFix "6.3.3.1" fixes/chap6/chap6_3/chap6_3_3/6_3_3_1.sh # Remediation
      fi
      ;;
    *)
      echo "Running the audit for the running configuration..."
      running_output=$(auditctl -l | awk '/^ *-w/ &&/\/etc\/sudoers/ &&/ +-p *wa/ &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)')
      matches=$(check "$running_output" "${expected[@]}")

      if [ "$matches" == "true" ]; then
        echo "Loaded rules:"
        echo "$running_output"
        echo "Audit Result: PASS"
      else
        echo "Loaded rules:"
        echo "$running_output"
        echo "Audit Result: FAIL"
        runFix "6.3.3.1" fixes/chap6/chap6_3/chap6_3_3/6_3_3_1.sh # Remediation
      fi
      ;;
  esac
}