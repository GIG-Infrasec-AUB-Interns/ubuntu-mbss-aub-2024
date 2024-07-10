#!/usr/bin/env bash 

# 7.1.5 [REMEDIATION] Ensure permissions on /etc/shadow are configured

{ 
  echo "[REMEDIATION] Ensuring permissions on /etc/shadow are configured (7.1.5)..."
  
  chmod u-x,g-wx,o-rwx /etc/shadow

  # Set ownership of etc/shadow to root OR shadow
  chown root:shadow /etc/shadow
  # chown root:root /etc/root

  echo "Permissions on /etc/shadow are now configured."
}