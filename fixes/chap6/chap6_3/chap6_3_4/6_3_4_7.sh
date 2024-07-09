#!/usr/bin/env bash 

# 6.3.4.7 [REMEDIATION] Ensure audit configuration files group owner is configured

{ 
  echo "[REMEDIATION] Ensuring audit configuration files group owner is configured (6.3.4.7)..."
  
  find /etc/audit/ -type f \( -name '*.conf' -o -name '*.rules' \) ! -group root -exec chgrp root {} +

  echo "Audit configuration files group owner is now configured."
}