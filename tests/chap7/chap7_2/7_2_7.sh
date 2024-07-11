#!/usr/bin/env bash 

# 7.2.7 Ensure no duplicate user names exist

{ 
  echo "Ensuring no duplicate user names exist (7.2.7)..."
  while read -r l_count l_user; do 
    if [ "$l_count" -gt 1 ]; then 
      echo -e "Duplicate User: \"$l_user\" Users: \"$(awk -F: '($1 == n) { print $1 }' n=$l_user /etc/passwd | xargs)\"" 
    fi 
  done < <(cut -f1 -d":" /etc/group | sort -n | uniq -c)

  echo "If there are any duplicate user names, please establish unique user names for the users."
  echo "File ownerships will automatically reflect the change as long as the users have unique UIDs."
  echo "For more information, please visit https://downloads.cisecurity.org/#/"
}