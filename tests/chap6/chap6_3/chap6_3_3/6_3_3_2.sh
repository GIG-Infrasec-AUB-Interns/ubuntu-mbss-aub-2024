#! /usr/bin/bash
source utils.sh
# 6.3.3.2 Ensure actions as another user are always logged

{
  echo "Ensuring actions as another user are always logged (6.3.3.2)..."
  ondisk_expected=(
    "-a always,exit -F arch=b64 -C euid!=uid -F auid!=unset -S execve -k user_emulation"
    "-a always,exit -F arch=b32 -C euid!=uid -F auid!=unset -S execve -k user_emulation"
  )
  running_expected=(
    "-a always,exit -F arch=b64 -S execve -C uid!=euid -F auid!=-1 -F key=user_emulation"
    "-a always,exit -F arch=b32 -S execve -C uid!=euid -F auid!=-1 -F key=user_emulation"
  )

  echo "You can choose to run the audit for either the on disk OR the running configuration."
  read -p "Run the audit for the on disk configuration? (Y/N): " ANSWER
  case "$ANSWER" in
    [Yy]*)
      echo "Running the audit for the on disk configuration..."
      ondisk_output=$(awk '/^ *-a *always,exit/ &&/ -F *arch=b(32|64)/ &&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) &&(/ -C *euid!=uid/||/ -C *uid!=euid/) &&/ -S *execve/ &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules)
      matches=$(check "$ondisk_output" "${ondisk_expected[@]}")

      if [ "$matches" == "true" ]; then
        echo "On disk rules:"
        echo "$ondisk_output"
        echo "Audit Result: PASS"
      else
        echo "On disk rules:"
        echo "$ondisk_output"
        echo "Audit Result: FAIL"
        runFix "6.3.3.2" fixes/chap6/chap6_3/chap6_3_3/6_3_3_2.sh # Remediation
      fi
      ;;
    *)
      echo "Running the audit for the running configuration..."
      running_output=$(auditctl -l | awk '/^ *-a *always,exit/ &&/ -F *arch=b(32|64)/ &&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) &&(/ -C *euid!=uid/||/ -C *uid!=euid/) &&/ -S *execve/ &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)')
      matches=$(check "$running_output" "${running_expected[@]}")

      if [ "$matches" == "true" ]; then
        echo "Loaded rules:"
        echo "$running_output"
        echo "Audit Result: PASS"
      else
        echo "Loaded rules:"
        echo "$running_output"
        echo "Audit Result: FAIL"
        runFix "6.3.3.2" fixes/chap6/chap6_3/chap6_3_3/6_3_3_2.sh # Remediation
      fi
      ;;
  esac
}