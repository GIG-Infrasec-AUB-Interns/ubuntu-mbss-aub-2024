#!/usr/bin/env bash 

# 6.2.1.1.5 [REMEDIATION] Ensure journald Storage is configured

{ 
  echo "[REMEDIATION] Ensuring journald Storage is configured (6.2.1.1.5)..."
  [ ! -d /etc/systemd/journald.conf.d/ ] && mkdir /etc/systemd/journald.conf.d/ 
  if grep -Psq -- '^\h*\[Journal\]' /etc/systemd/journald.conf.d/60-journald.conf; then 
    printf '%s\n' "Storage=persistent" >> /etc/systemd/journald.conf.d/60-journald.conf 
  else 
    printf '%s\n' "[Journal]" "Storage=persistent" >> /etc/systemd/journald.conf.d/60-journald.conf 
  fi 

  systemctl reload-or-restart systemd-journald

  echo "journald Storage is now configured."
}