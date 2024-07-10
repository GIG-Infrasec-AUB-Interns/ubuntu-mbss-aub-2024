#!/usr/bin/env bash 

# 6.3.4.5 [REMEDIATION] Ensure audit configuration files mode is configured

{ 
  echo "[REMEDIATION] Ensuring audit configuration files mode is configured (6.3.4.5)..."
  
  find /etc/audit/ -type f \( -name '*.conf' -o -name '*.rules' \) -exec chmod u-x,g-wx,o-rwx {} +

  echo "Audit configuration files mode is now configured."
}