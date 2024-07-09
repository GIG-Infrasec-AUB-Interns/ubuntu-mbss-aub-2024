#! /usr/bin/bash
# 6.2.1.2.1 Ensure systemd-journal-remote is installed

{
  echo "Ensuring systemd-journal-remote is installed (6.2.1.2.1)..."
  remote_output=$(dpkg-query -s systemd-journal-remote &>/dev/null && echo "systemd-journal-remote is installed")
  
  if ([[ "$remote_output" == "systemd-journal-remote is installed" ]]); then
    echo "systemd-journal-remote audit output:"
    echo "$remote_output"
    echo "Audit Result: PASS"
  else
    echo "systemd-journal-remote audit output:"
    echo "$remote_output"
    echo "Audit Result: FAIL"

    # Remediation
    read -p "Run remediation script for Test 6.2.1.2.1? (Y/N): " ANSWER
    case "$ANSWER" in
      [Yy]*)
        echo "Commencing remediation for Test 6.2.1.2.1..."

        FIXES_SCRIPT="$(realpath fixes/chap6/chap6_2/chap6_2_1/chap6_2_1_2/6_2_1_2_1.sh)"
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