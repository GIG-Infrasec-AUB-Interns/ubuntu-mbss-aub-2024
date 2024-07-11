#!/usr/bin/env bash 

# 7.1.8 [REMEDIATION] Ensure permissions on /etc/gshadow- are configured

{ 
  echo "[REMEDIATION] Ensuring permissions on /etc/gshadow- are configured (7.1.8)..."
  
  chmod u-x,g-wx,o-rwx /etc/gshadow-

  # Set ownership of /etc/gshadow- to root OR shadow
  chown root:shadow /etc/gshadow-
  # chown root:root /etc/gshadow-

  echo "Permissions on /etc/gshadow- are now configured."
}