#! /usr/bin/bash
source utils.sh
# 6.3.2.4 Ensure system warns when audit logs are low on space

{
  echo "Ensuring system warns when audit logs are low on space (6.3.2.4)..."
  space_left_action=$(grep -Pi -- '^\h*space_left_action\h*=\h*(email|exec|single|halt)\b' /etc/audit/auditd.conf)
  admin_space_left_action=$(grep -Pi -- '^\h*admin_space_left_action\h*=\h*(single|halt)\b' /etc/audit/auditd.conf)

  if ([ -z "$space_left_action" ] && [ -z "$admin_space_left_action" ] ); then
    echo "space_left_action is not email, exec, single, or halt"
    echo "admin_space_left_action is not single or halt"
    echo "Audit Result: FAIL"

    runFix "6.3.2.4" fixes/chap6/chap6_3/chap6_3_2/6_3_2_4.sh # Remediation
  else
    echo "$space_left_action"
    echo "$admin_space_left_action"
    echo "Audit Result: PASS"
  fi
}