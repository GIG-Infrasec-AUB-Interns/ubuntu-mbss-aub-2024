#!/usr/bin/env bash 

# 7.1.1 [REMEDIATION] Ensure permissions on /etc/passwd are configured

{ 
  echo "[REMEDIATION] Ensuring permissions on /etc/passwd are configured (7.1.1)..."
  
  chmod u-x,go-wx /etc/passwd 
  chown root:root /etc/passwd

  echo "Permissions on /etc/passwd are now configured."
}