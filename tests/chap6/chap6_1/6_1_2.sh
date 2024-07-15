#! /usr/bin/bash
source utils.sh
# 6.1.2 Ensure filesystem integrity is regularly checked

{
  echo "Ensuring filesystem integrity is regularly checked (6.1.2)..."
  echo "You can use either cron OR aidecheck.service and aidecheck.timer to schedule and run aide check."
  read -p "Will you be using cron to schedule and run aide check? (Y/N): " ANSWER

  case "$ANSWER" in
    [Yy]*)
      echo "Verifying a cron job is scheduled to run the aide check..."
      grep -Prs '^([^#\n\r]+\h+)?(\/usr\/s?bin\/|^\h*)aide(\.wrapper)?\h+(--(check|update)|([^#\n\r]+\h+)?\$AIDEARGS)\b' /etc/cron.* /etc/crontab /var/spool/cron/
      echo "Ensure that a cron job in compliance with site policy is returned."
      echo "Otherwise, please proceed with the remediation script."

      runFix "6.1.2" fixes/chap6/chap6_1/6_1_2.sh # Remediation
      ;;
    *)
      echo "Verifying that aidecheck.service and aidecheck.timer are enabled and aidecheck.timer is running..."
      service_enabled_output=$(systemctl is-enabled aidecheck.service)
      timer_enabled_output=$(systemctl is-enabled aidecheck.timer)
      timer_active_output=$(systemctl is-active aidecheck.timer)

      if ([ "$service_enabled_output" == "enabled" ] && [ "$timer_enabled_output" == "enabled" ] && [ "$timer_active_output" == "active" ]); then
        echo "aidecheck.service is-enabled output:"
        echo "$service_enabled_output"
        echo "aidecheck.timer is-enabled output:"
        echo "$timer_enabled_output"
        echo "aidecheck.timer is-active output:"
        echo "$timer_active_output"
        echo "Audit Result: PASS"
      else
        echo "aidecheck.service is-enabled output:"
        echo "$service_enabled_output"
        echo "aidecheck.timer is-enabled output:"
        echo "$timer_enabled_output"
        echo "aidecheck.timer is-active output:"
        echo "$timer_active_output"
        echo "Audit Result: FAIL"

        echo "For remediation, please visit https://downloads.cisecurity.org/#/"
      fi
      ;;
  esac
}