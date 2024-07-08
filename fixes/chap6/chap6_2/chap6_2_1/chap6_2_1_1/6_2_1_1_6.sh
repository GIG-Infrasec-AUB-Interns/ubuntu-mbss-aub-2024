#!/usr/bin/env bash 

# 6.2.1.1.6 [REMEDIATION] Ensure journald Compress is configured

{ 
  echo "[REMEDIATION] Ensuring journald Compress is configured (6.2.1.1.6)..."
  [ ! -d /etc/systemd/journald.conf.d/ ] && mkdir /etc/systemd/journald.conf.d/ 
  if grep -Psq -- '^\h*\[Journal\]' /etc/systemd/journald.conf.d/60-journald.conf; then 
    printf '%s\n' "Compress=yes" >> /etc/systemd/journald.conf.d/60-journald.conf 
  else 
    printf '%s\n' "[Journal]" "Compress=yes" >> /etc/systemd/journald.conf.d/60-journald.conf 
  fi

  systemctl reload-or-restart systemd-journald

  echo "journald Compress is now configured."
}