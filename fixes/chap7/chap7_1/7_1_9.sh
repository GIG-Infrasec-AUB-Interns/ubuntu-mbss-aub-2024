#!/usr/bin/env bash 

# 7.1.9 [REMEDIATION] Ensure permissions on /etc/shells are configured

{ 
  echo "[REMEDIATION] Ensuring permissions on /etc/shells are configured (7.1.9)..."
  
  chmod u-x,go-wx /etc/shells 
  chown root:root /etc/shells

  echo "Permissions on /etc/shells are now configured."
}