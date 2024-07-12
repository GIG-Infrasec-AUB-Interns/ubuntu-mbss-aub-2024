#!/usr/bin/env bash 

# 6.3.4.8 [REMEDIATION] Ensure audit tools mode is configured

{ 
  echo "[REMEDIATION] Ensuring audit tools mode is configured (6.3.4.8)..."
  
  chmod go-w /sbin/auditctl /sbin/aureport /sbin/ausearch /sbin/autrace /sbin/auditd /sbin/augenrules

  echo "Audit tools mode is now configured."
}