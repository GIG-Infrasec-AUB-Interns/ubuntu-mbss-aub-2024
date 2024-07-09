#!/usr/bin/env bash 

# 6.3.4.6 [REMEDIATION] Ensure audit configuration files owner is configured

{ 
  echo "[REMEDIATION] Ensuring audit configuration files owner is configured (6.3.4.6)..."
  
  find /etc/audit/ -type f \( -name '*.conf' -o -name '*.rules' \) ! -user root -exec chown root {} +

  echo "Audit configuration files owner is now configured."
}