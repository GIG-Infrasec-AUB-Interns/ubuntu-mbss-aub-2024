#! /usr/bin/bash
source utils.sh
# 6.3.3.10 Ensure successful file system mounts are collected

{
  echo "Ensuring successful file system mounts are collected (6.3.3.10)..."
  ondisk_expected=(
    "-a always,exit -F arch=b64 -S mount -F auid>=1000 -F auid!=unset -k mounts"
    "-a always,exit -F arch=b32 -S mount -F auid>=1000 -F auid!=unset -k mounts"
  )
  running_expected=(
    "-a always,exit -F arch=b64 -S mount -F auid>=1000 -F auid!=-1 -F key=mounts"
    "-a always,exit -F arch=b32 -S mount -F auid>=1000 -F auid!=-1 -F key=mounts"
  )

  echo "You can choose to run the audit for either the on disk OR the running configuration."
  read -p "Run the audit for the on disk configuration? (Y/N): " ANSWER
  case "$ANSWER" in
    [Yy]*)
      echo "Running the audit for the on disk configuration..."
      UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
      ondisk_output=$([ -n "${UID_MIN}" ] && awk "/^ *-a *always,exit/ &&/ -F *arch=b(32|64)/ &&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) &&/ -F *auid>=${UID_MIN}/ &&/ -S/ &&/mount/ &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" /etc/audit/rules.d/*.rules || printf "ERROR: Variable 'UID_MIN' is unset.\n")
      matches=$(check "$ondisk_output" "${ondisk_expected[@]}")

      if [ "$matches" == "true" ]; then
        echo "On disk rules:"
        echo "$ondisk_output"
        echo "Audit Result: PASS"
      else
        echo "On disk rules:"
        echo "$ondisk_output"
        echo "Audit Result: FAIL"
        runFix "6.3.3.10" fixes/chap6/chap6_3/chap6_3_3/6_3_3_10.sh # Remediation
      fi
      ;;
    *)
      echo "Running the audit for the running configuration..."
      UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
      running_output=$([ -n "${UID_MIN}" ] && auditctl -l | awk "/^ *-a *always,exit/ &&/ -F *arch=b(32|64)/ &&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) &&/ -F *auid>=${UID_MIN}/ &&/ -S/ &&/mount/ &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" || printf "ERROR: Variable 'UID_MIN' is unset.\n")
      matches=$(check "$running_output" "${running_expected[@]}")

      if [ "$matches" == "true" ]; then
        echo "Loaded rules:"
        echo "$running_output"
        echo "Audit Result: PASS"
      else
        echo "Loaded rules:"
        echo "$running_output"
        echo "Audit Result: FAIL"
        runFix "6.3.3.10" fixes/chap6/chap6_3/chap6_3_3/6_3_3_10.sh # Remediation
      fi
      ;;
  esac
}