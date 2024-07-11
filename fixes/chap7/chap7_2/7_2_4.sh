#!/usr/bin/env bash 

# 7.2.4 [REMEDIATION] Ensure shadow group is empty

{ 
  echo "[REMEDIATION] Ensuring shadow group is empty (7.2.4)..."
  
  sed -ri 's/(^shadow:[^:]*:[^:]*:)([^:]+$)/\1/' /etc/group

  echo "For further remediation, change the primary group of any users with shadow as their primary group using the command below:"
  echo "usermod -g <primary group> <user>"
}