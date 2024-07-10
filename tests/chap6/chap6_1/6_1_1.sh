#! /usr/bin/bash
source utils.sh
# 6.1.1 Ensure AIDE is installed

{
  echo "Ensuring AIDE is installed (6.1.1)..."
  aide_output=$(dpkg-query -s aide &>/dev/null && echo "aide is installed")
  aide_common_output=$(dpkg-query -s aide-common &>/dev/null && echo "aide-common is installed")
  
  if ([ "$aide_output" == "aide is installed" ] && [ "$aide_common_output" == "aide-common is installed" ]); 
  then
    echo "AIDE audit output:"
    echo "$aide_output"
    echo "AIDE-common audit output:"
    echo "$aide_common_output"
    echo "Audit Result: PASS"
  else
    echo "AIDE audit output:"
    echo "$aide_output"
    echo "AIDE-common audit output:"
    echo "$aide_common_output"
    echo "Audit Result: FAIL"

    runFix "6.1.1" fixes/chap6/chap6_1/6_1_1.sh # Remediation
  fi
}