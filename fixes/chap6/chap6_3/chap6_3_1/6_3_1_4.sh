#!/usr/bin/env bash 

# 6.3.1.4 [REMEDIATION] Ensure audit_backlog_limit is sufficient

{ 
  echo "[REMEDIATION] Ensuring audit_backlog_limit is sufficient (6.3.1.4)..."

  BACKLOG_LIMIT=8192 # Define backlog limit, should be 8192 or higher
  GRUB_CONFIG_FILE="/etc/default/grub"

  if grep -q '^GRUB_CMDLINE_LINUX=' "$GRUB_CONFIG_FILE"; then
    sed -i "s/\(^GRUB_CMDLINE_LINUX=\".*\)\"/\1 audit_backlog_limit=$BACKLOG_LIMIT\"/" "$GRUB_CONFIG_FILE"
  else
    echo "GRUB_CMDLINE_LINUX=\"audit_backlog_limit=$BACKLOG_LIMIT\"" >> "$GRUB_CONFIG_FILE"
  fi

  update-grub

  echo "Audit backlog limit is now sufficient."
}