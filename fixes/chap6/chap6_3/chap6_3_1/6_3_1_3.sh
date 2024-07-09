#!/usr/bin/env bash 

# 6.3.1.3 [REMEDIATION] Ensure auditing for processes that start prior to auditd is enabled

{ 
  echo "[REMEDIATION] Ensuring auditing for processes that start prior to auditd is enabled (6.3.1.3)..."

  GRUB_CONFIG_FILE="/etc/default/grub"
  
  if grep -q '^GRUB_CMDLINE_LINUX=' "$GRUB_CONFIG_FILE"; then
    sed -i "s/\(^GRUB_CMDLINE_LINUX=\".*\)\"/\1 audit=1\"/" "$GRUB_CONFIG_FILE"
  else
    echo "GRUB_CMDLINE_LINUX=\"audit=1\"" >> "$GRUB_CONFIG_FILE"
  fi

  update-grub

  echo "Auditing for processes that start prior to auditd is now enabled."
}