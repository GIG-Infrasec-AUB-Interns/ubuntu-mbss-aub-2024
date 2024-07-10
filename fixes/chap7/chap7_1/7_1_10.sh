#!/usr/bin/env bash 

# 7.1.10 [REMEDIATION] Ensure permissions on /etc/security/opasswd are configured

{ 
  echo "[REMEDIATION] Ensuring permissions on /etc/security/opasswd are configured (7.1.10)..."
  
  [ -e "/etc/security/opasswd" ] && chmod u-x,go-rwx /etc/security/opasswd 
  [ -e "/etc/security/opasswd" ] && chown root:root /etc/security/opasswd 
  [ -e "/etc/security/opasswd.old" ] && chmod u-x,go-rwx /etc/security/opasswd.old 
  [ -e "/etc/security/opasswd.old" ] && chown root:root /etc/security/opasswd.old

  echo "Permissions on /etc/security/opasswd are now configured."
}