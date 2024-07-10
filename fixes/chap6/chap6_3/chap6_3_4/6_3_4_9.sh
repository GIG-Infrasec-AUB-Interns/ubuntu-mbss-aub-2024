#!/usr/bin/env bash 

# 6.3.4.9 [REMEDIATION] Ensure audit tools owner is configured

{ 
  echo "[REMEDIATION] Ensuring audit tools owner is configured (6.3.4.9)..."
  
  chown root /sbin/auditctl /sbin/aureport /sbin/ausearch /sbin/autrace /sbin/auditd /sbin/augenrules

  echo "Audit tools owner is now configured."
}