#! /usr/bin/bash
source utils.sh
# 7.1.10 Ensure permissions on /etc/security/opasswd are configured

{
  echo "Ensuring permissions on /etc/security/opasswd are configured (7.1.10)..."
  opasswd=$([ -e "/etc/security/opasswd" ] && stat -Lc '%n Access: (%#a) Uid: (%u/%U) Gid: (%g/%G)' /etc/security/opasswd)
  opasswd_old=$([ -e "/etc/security/opasswd.old" ] && stat -Lc '%n Access: (%#a) Uid: (%u/%U) Gid: (%g/%G)' /etc/security/opasswd.old)

  perms_opasswd=$(echo $opasswd | awk '{print $3}' | tr -d '()%#')
  uid_opasswd=$(echo $opasswd | awk '{print $5}' | tr -d '()%#')
  gid_opasswd=$(echo $opasswd | awk '{print $7}' | tr -d '()%#')

  perms_opasswd_old=$(echo $opasswd_old | awk '{print $3}' | tr -d '()%#')
  uid_opasswd_old=$(echo $opasswd_old | awk '{print $5}' | tr -d '()%#')
  gid_opasswd_old=$(echo $opasswd_old | awk '{print $7}' | tr -d '()%#')

  opasswd_result="FAIL"
  opasswd_old_result="FAIL"

  if [ -z "$opasswd" ] || ([ $perms_opasswd -le 0600 ] && [ "$uid_opasswd" == "0/root" ] && [ "$gid_opasswd" == "0/root" ]); then
    opasswd_result="PASS"
  fi

  if [ -z "$opasswd_old" ] || ([ $perms_opasswd_old -le 0600 ]  && [ "$uid_opasswd_old" == "0/root" ] && [ "$gid_opasswd_old" == "0/root" ]); then
    opasswd_old_result="PASS"
  fi
  
  if [ "$opasswd_result" == "PASS" ] && [ "$opasswd_old_result" == "PASS" ]; then
    echo "Audit output:"
    echo "$opasswd"
    echo "$opasswd_old"
    echo "Audit Result: PASS"
  else
    echo "Audit output:"
    echo "$opasswd"
    echo "$opasswd_old"
    echo "Audit Result: FAIL"
  
    runFix "7.1.10" fixes/chap7/chap7_1/7_1_10.sh # Remediation
  fi
}
