#! /usr/bin/bash
# 6.1.1 Ensure AIDE is installed

{
  echo "Ensuring AIDE is installed (6.1.1)..."
  aide_output=$(dpkg-query -s aide &>/dev/null && echo "aide is installed")
  aide_common_output=$(dpkg-query -s aide-common &>/dev/null && echo "aide-common is installed")
  
  if ([[ "$aide_output" == "aide is installed" ]] && [[ "$aide_common_output" == "aide-common is installed" ]]); 
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

    # Remediation
    read -p "Run remediation script for Test 6.1.1? (Y/N): " ANSWER
    case "$ANSWER" in
      [Yy]*)
        echo "Commencing remediation for Test 6.1.1..."

        FIXES_SCRIPT="$(realpath fixes/chap6/chap6_1/6_1_1.sh)"
        if [ -f "$FIXES_SCRIPT" ]; then
          chmod +x "$FIXES_SCRIPT"
          "$FIXES_SCRIPT"
        else
          echo "Error: $FIXES_SCRIPT is not found."
        fi
        echo "For more information, please visit https://downloads.cisecurity.org/#/"
        ;;
      *)
        echo "Remediation not commenced"
        echo "For more information, please visit https://downloads.cisecurity.org/#/"
        ;;
    esac
  fi
}