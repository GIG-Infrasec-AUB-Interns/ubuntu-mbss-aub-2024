#!/usr/bin/env bash 

# 6.3.4.10 [REMEDIATION] Ensure audit tools group owner is configured

{ 
  echo "[REMEDIATION] Ensuring audit tools group owner is configured (6.3.4.10)..."
  
  chgrp root /sbin/auditctl /sbin/aureport /sbin/ausearch /sbin/autrace /sbin/auditd /sbin/augenrules

  echo "Audit tools group owner is now configured."
}