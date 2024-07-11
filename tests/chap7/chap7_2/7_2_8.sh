#!/usr/bin/env bash 

# 7.2.8 Ensure no duplicate group names exist

{ 
  echo "Ensuring no duplicate group names exist (7.2.8)..."
  while read -r l_count l_group; do 
    if [ "$l_count" -gt 1 ]; then 
      echo -e "Duplicate Group: \"$l_group\" Groups: \"$(awk -F: '($1 == n) { print $1 }' n=$l_group /etc/group | xargs)\"" 
    fi 
  done < <(cut -f1 -d":" /etc/group | sort -n | uniq -c)

  echo "If there are any duplicate group names, please establish unique group names for the groups."
  echo "File ownerships will automatically reflect the change as long as the groups have unique GIDs."
  echo "For more information, please visit https://downloads.cisecurity.org/#/"
}