#!/usr/bin/env bash 

# 7.2.1 [REMEDIATION] Ensure accounts in /etc/passwd use shadowed passwords

{ 
  echo "[REMEDIATION] Ensuring accounts in /etc/passwd use shadowed passwords (7.2.1)..."
  
  pwconv

  echo "Accounts in /etc/passwd now use shadowed passwords."
}