#!/usr/bin/env bash 

# 7.2.5 Ensure no duplicate UIDs exist

{ 
  echo "Ensuring no duplicate UIDs exist (7.2.5)..."
  while read -r l_count l_uid; do 
    if [ "$l_count" -gt 1 ]; then 
      echo -e "Duplicate UID: \"$l_uid\" Users: \"$(awk -F: '($3 == n) { print $1 }' n=$l_uid /etc/passwd | xargs)\"" 
    fi 
  done < <(cut -f3 -d":" /etc/passwd | sort -n | uniq -c)

  echo "If there are any duplicate UIDs, please establish unique UIDs and review all files owned by the shared UIDs to determine which UID they are supposed to belong to"
  echo "For more information, please visit https://downloads.cisecurity.org/#/"
}