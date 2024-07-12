#!/usr/bin/env bash 

# 7.1.3 [REMEDIATION] Ensure permissions on /etc/group are configured

{ 
  echo "[REMEDIATION] Ensuring permissions on /etc/group are configured (7.1.3)..."
  
  chmod u-x,go-wx /etc/group 
  chown root:root /etc/group

  echo "Permissions on /etc/group are now configured."
}