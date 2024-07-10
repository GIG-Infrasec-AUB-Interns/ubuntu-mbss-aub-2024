#!/usr/bin/env bash 

# 7.2.6 Ensure no duplicate GIDs exist

{ 
  echo "Ensuring no duplicate GIDs exist (7.2.5)..."
  while read -r l_count l_gid; do 
    if [ "$l_count" -gt 1 ]; then 
      echo -e "Duplicate GID: \"$l_gid\" Groups: \"$(awk -F: '($3 == n) { print $1 }' n=$l_gid /etc/group | xargs)\"" 
    fi 
  done < <(cut -f3 -d":" /etc/group | sort -n | uniq -c)

  echo "If there are any duplicate GIDs, please establish unique GIDs and review all files owned by the shared GIDs to determine which group they are supposed to belong to"
  echo "For more information, please visit https://downloads.cisecurity.org/#/"
}