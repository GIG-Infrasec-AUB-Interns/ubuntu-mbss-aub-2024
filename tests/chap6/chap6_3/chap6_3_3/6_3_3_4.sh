#! /usr/bin/bash
source utils.sh
# 6.3.3.4 Ensure events that modify date and time information are collected

{
  echo "Ensuring events that modify date and time information are collected (6.3.3.4)..."
  ondisk_expected_1=(
    "-a always,exit -F arch=b64 -S adjtimex,settimeofday,clock_settime -k time-change"
    "-a always,exit -F arch=b32 -S adjtimex,settimeofday,clock_settime -k time-change"
  )
  ondisk_expected_2=(
    "-w /etc/localtime -p wa -k time-change"
  )
  running_expected_1=(
    "-a always,exit -F arch=b64 -S adjtimex,settimeofday,clock_settime -F key=time-change"
    "-a always,exit -F arch=b32 -S adjtimex,settimeofday,clock_settime -F key=time-change"
  )
  running_expected_2=(
    "-w /etc/localtime -p wa -k time-change"
  )

  echo "You can choose to run the audit for either the on disk OR the running configuration."
  read -p "Run the audit for the on disk configuration? (Y/N): " ANSWER
  case "$ANSWER" in
    [Yy]*)
      echo "Running the audit for the on disk configuration..."
      ondisk_output_1=$(awk '/^ *-a *always,exit/ &&/ -F *arch=b(32|64)/ &&/ -S/ &&(/adjtimex/ ||/settimeofday/ ||/clock_settime/ ) &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules)
      ondisk_output_2=$(awk '/^ *-w/ &&/\/etc\/localtime/ &&/ +-p *wa/ &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules)
      matches_1=$(check "$ondisk_output_1" "${ondisk_expected_1[@]}")
      matches_2=$(check "$ondisk_output_2" "${ondisk_expected_2[@]}")

      if ([ "$matches_1" == "true" ] && [ "$matches_2" == "true" ]); then
        echo "On disk rules:"
        echo "$ondisk_output_1"
        echo "$ondisk_output_2"
        echo "Audit Result: PASS"
      else
        echo "On disk rules:"
        echo "$ondisk_output_1"
        echo "$ondisk_output_2"
        echo "Audit Result: FAIL"
        runFix "6.3.3.4" fixes/chap6/chap6_3/chap6_3_3/6_3_3_4.sh # Remediation
      fi
      ;;
    *)
      echo "Running the audit for the running configuration..."
      running_output_1=$(auditctl -l | awk '/^ *-a *always,exit/ &&/ -F *arch=b(32|64)/ &&/ -S/ &&(/adjtimex/ ||/settimeofday/ ||/clock_settime/ ) &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)')
      running_output_2=$(auditctl -l | awk '/^ *-w/ &&/\/etc\/localtime/ &&/ +-p *wa/ &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)')
      matches_1=$(check "$running_output_1" "${running_expected_1[@]}")
      matches_2=$(check "$running_output_2" "${running_expected_2[@]}")

      if ([ "$matches_1" == "true" ] && [ "$matches_2" == "true" ]); then
        echo "Loaded rules:"
        echo "$running_output_1"
        echo "$running_output_2"
        echo "Audit Result: PASS"
      else
        echo "Loaded rules:"
        echo "$running_output_1"
        echo "$running_output_2"
        echo "Audit Result: FAIL"
        runFix "6.3.3.4" fixes/chap6/chap6_3/chap6_3_3/6_3_3_4.sh # Remediation
      fi
      ;;
  esac
}