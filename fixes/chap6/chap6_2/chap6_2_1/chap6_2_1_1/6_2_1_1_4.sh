#!/usr/bin/env bash 

# 6.2.1.1.4 [REMEDIATION] Ensure journald ForwardToSyslog is disabled

{ 
  echo "[REMEDIATION] Ensuring journald ForwardToSyslog is disabled (6.2.1.1.4)..."
  [ ! -d /etc/systemd/journald.conf.d/ ] && mkdir /etc/systemd/journald.conf.d/ 
  if grep -Psq -- '^\h*\[Journal\]' /etc/systemd/journald.conf.d/60-journald.conf; then 
    printf '%s\n' "ForwardToSyslog=no" >> /etc/systemd/journald.conf.d/60-journald.conf 
  else 
    printf '%s\n' "[Journal]" "ForwardToSyslog=no" >> /etc/systemd/journald.conf.d/60-journald.conf 
  fi 

  systemctl reload-or-restart systemd-journald

  echo "journald ForwardToSyslog is now disabled."
}