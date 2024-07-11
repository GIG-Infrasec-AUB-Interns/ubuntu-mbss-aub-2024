#! /usr/bin/bash
source utils.sh
# 6.3.3.8 Ensure events that modify user/group information are collected

{
  echo "Ensuring events that modify user/group information are collected (6.3.3.8)..."
  expected=(
    "-w /etc/group -p wa -k identity" 
    "-w /etc/passwd -p wa -k identity" 
    "-w /etc/gshadow -p wa -k identity" 
    "-w /etc/shadow -p wa -k identity" 
    "-w /etc/security/opasswd -p wa -k identity" 
    "-w /etc/nsswitch.conf -p wa -k identity" 
    "-w /etc/pam.conf -p wa -k identity" 
    "-w /etc/pam.d -p wa -k identity"
  )

  echo "You can choose to run the audit for either the on disk OR the running configuration."
  read -p "Run the audit for the on disk configuration? (Y/N): " ANSWER
  case "$ANSWER" in
    [Yy]*)
      echo "Running the audit for the on disk configuration..."
      ondisk_output=$(awk '/^ *-w/ &&(/\/etc\/group/ ||/\/etc\/passwd/ ||/\/etc\/gshadow/ ||/\/etc\/shadow/ ||/\/etc\/security\/opasswd/ ||/\/etc\/nsswitch.conf/ ||/\/etc\/pam.conf/ ||/\/etc\/pam.d/) &&/ +-p *wa/ &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules)
      matches=$(check "$ondisk_output" "${expected[@]}")

      if [ "$matches" == "true" ]; then
        echo "On disk rules:"
        echo "$ondisk_output"
        echo "Audit Result: PASS"
      else
        echo "On disk rules:"
        echo "$ondisk_output"
        echo "Audit Result: FAIL"
        runFix "6.3.3.8" fixes/chap6/chap6_3/chap6_3_3/6_3_3_8.sh # Remediation
      fi
      ;;
    *)
      echo "Running the audit for the running configuration..."
      running_output=$(auditctl -l | awk '/^ *-w/ &&(/\/etc\/group/ ||/\/etc\/passwd/ ||/\/etc\/gshadow/ ||/\/etc\/shadow/ ||/\/etc\/security\/opasswd/ ||/\/etc\/nsswitch.conf/ ||/\/etc\/pam.conf/ ||/\/etc\/pam.d/) &&/ +-p *wa/ &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)')
      matches=$(check "$running_output" "${expected[@]}")

      if [ "$matches" == "true" ]; then
        echo "Loaded rules:"
        echo "$running_output"
        echo "Audit Result: PASS"
      else
        echo "Loaded rules:"
        echo "$running_output"
        echo "Audit Result: FAIL"
        runFix "6.3.3.8" fixes/chap6/chap6_3/chap6_3_3/6_3_3_8.sh # Remediation
      fi
      ;;
  esac
}