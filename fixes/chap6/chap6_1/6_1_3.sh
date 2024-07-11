#! /usr/bin/bash

# 6.1.3 [REMEDIATION] Ensure cryptographic mechanisms are used to protect the integrity of audit tools

{
  echo "[REMEDIATION] Ensuring cryptographic mechanisms are used to protect the integrity of audit tools (6.1.3)..."
  
  lines=(
    "/sbin/auditctl p+i+n+u+g+s+b+acl+xattrs+sha512" 
    "/sbin/auditd p+i+n+u+g+s+b+acl+xattrs+sha512" 
    "/sbin/ausearch p+i+n+u+g+s+b+acl+xattrs+sha512" 
    "/sbin/aureport p+i+n+u+g+s+b+acl+xattrs+sha512" 
    "/sbin/autrace p+i+n+u+g+s+b+acl+xattrs+sha512" 
    "/sbin/augenrules p+i+n+u+g+s+b+acl+xattrs+sha512"
  )
  
  for line in "${lines[@]}"; do
    escaped_line=$(echo "$line" | sed 's/\//\\\//g')

    if grep -q "^${line%% *}" /etc/aide/aide.conf; then
      sed -i "s/^${line%% *}.*/$escaped_line/" /etc/aide/aide.conf
    else
      echo "$line" >> /etc/aide/aide.conf
    fi
  done
  
  echo "Remediation finished successfully."
}