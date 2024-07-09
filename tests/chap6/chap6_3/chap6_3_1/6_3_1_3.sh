#! /usr/bin/bash
# 6.3.1.3 Ensure auditing for processes that start prior to auditd is enabled

{
  echo "Ensuring auditing for processes that start prior to auditd is enabled (6.3.1.3)..."
  audit_output=$(find /boot -type f -name 'grub.cfg' -exec grep -Ph -- '^\h*linux' {} + | grep -v 'audit=1')

  if [ -z "$audit_output" ]; then
    echo "Return output:"
    echo "$audit_output"
    echo "Audit Result: PASS"
  else
    echo "Return output:"
    echo "$audit_output"
    echo "Audit Result: FAIL"

    echo "For remediation, please edit /etc/default/grub and add audit=1 to GRUB_CMDLINE_LINUX"
    echo "EXAMPLE: GRUB_CMDLINE_LINUX=\"audit=1\""
    echo "Then run update-grub"
    echo "For more information, please visit https://downloads.cisecurity.org/#/"
  fi
}