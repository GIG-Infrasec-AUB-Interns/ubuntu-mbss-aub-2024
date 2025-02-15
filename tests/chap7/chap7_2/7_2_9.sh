#!/usr/bin/env bash 
source utils.sh
# 7.2.9 Ensure local interactive user home directories are configured

{ 
  echo "Ensuring local interactive user home directories are configured (7.2.9)..."
  l_output="" l_output2="" l_heout2="" l_hoout2="" l_haout2="" 
  l_valid_shells="^($( awk -F\/ '$NF != "nologin" {print}' /etc/shells | sed -rn '/^\//{s,/,\\\\/,g;p}' | paste -s -d '|' - ))$" 
  unset a_uarr && a_uarr=() # Clear and initialize array 
  while read -r l_epu l_eph; do # Populate array with users and user home location 
    a_uarr+=("$l_epu $l_eph") 
  done <<< "$(awk -v pat="$l_valid_shells" -F: '$(NF) ~ pat { print $1 " " $(NF-1) }' /etc/passwd)" 
  l_asize="${#a_uarr[@]}" # Here if we want to look at number of users before proceeding 
  [ "$l_asize " -gt "10000" ] && echo -e "\n ** INFO **\n - \"$l_asize\" Local interactive users found on the system\n - This may be a long running check\n" 
  while read -r l_user l_home; do 
    if [ -d "$l_home" ]; then 
      l_mask='0027' 
      l_max="$( printf '%o' $(( 0777 & ~$l_mask)) )" 
      while read -r l_own l_mode; do 
        [ "$l_user" != "$l_own" ] && l_hoout2="$l_hoout2\n - User: \"$l_user\" Home \"$l_home\" is owned by: \"$l_own\"" 
        if [ $(( $l_mode & $l_mask )) -gt 0 ]; then 
          l_haout2="$l_haout2\n - User: \"$l_user\" Home \"$l_home\" is mode: \"$l_mode\" should be mode: \"$l_max\" or more restrictive" 
        fi 
      done <<< "$(stat -Lc '%U %#a' "$l_home")" 
    else 
      l_heout2="$l_heout2\n - User: \"$l_user\" Home \"$l_home\" Doesn't exist" 
    fi 
  done <<< "$(printf '%s\n' "${a_uarr[@]}")" 
  [ -z "$l_heout2" ] && l_output="$l_output\n - home directories exist" || l_output2="$l_output2$l_heout2" 
  [ -z "$l_hoout2" ] && l_output="$l_output\n - own their home directory" || l_output2="$l_output2$l_hoout2" 
  [ -z "$l_haout2" ] && l_output="$l_output\n - home directories are mode: \"$l_max\" or more restrictive" || l_output2="$l_output2$l_haout2" 
  [ -n "$l_output" ] && l_output=" - All local interactive users:$l_output" 
  if [ -z "$l_output2" ]; then # If l_output2 is empty, we pass 
    echo -e "\n- Audit Result:\n ** PASS **\n - * Correctly configured * :\n$l_output" 
  else 
    echo -e "\n- Audit Result:\n ** FAIL **\n - * Reasons for audit failure * :\n$l_output2" 
    [ -n "$l_output" ] && echo -e "\n- * Correctly configured * :\n$l_output" 
    echo "For remediation, please follow local site policy and perform one of the following:"
    echo "   - Lock the user account"
    echo "   - Remove the user from the system"
    echo "   - Create a directory for the user. If undefined, edit /etc/passwd and add the absolute path to the directory to the last field of the user"
    echo "Run the remediation script to:" 
    echo "   - Remove excessive permissions from local interactive users home directories"
    echo "   - Update the home directory's owner"
    runFix "7.2.9" fixes/chap7/chap7_2/7_2_9.sh # Remediation
  fi 
}