#!/usr/bin/env bash 

# 7.2.3 Ensure all groups in /etc/passwd exist in /etc/group

{ 
  echo "Ensuring all groups in /etc/passwd exist in /etc/group (7.2.3)..."
  a_passwd_group_gid=("$(awk -F: '{print $4}' /etc/passwd | sort -u)") 
  a_group_gid=("$(awk -F: '{print $3}' /etc/group | sort -u)") 
  a_passwd_group_diff=("$(printf '%s\n' "${a_group_gid[@]}" "${a_passwd_group_gid[@]}" | sort | uniq -u)") 
  while IFS= read -r l_gid; do 
    awk -F: '($4 == '"$l_gid"') {print " - User: \"" $1 "\" has GID: \"" $4 "\" which does not exist in /etc/group" }' /etc/passwd 
  done < <(printf '%s\n' "${a_passwd_group_gid[@]}" "${a_passwd_group_diff[@]}" | sort | uniq -D | uniq) 
  unset a_passwd_group_gid; unset a_group_gid; unset a_passwd_group_diff 

  echo "If any users are listed, please perform the appropriate action to correct any discrepancies found"
  echo "For more information, please visit https://downloads.cisecurity.org/#/"
}