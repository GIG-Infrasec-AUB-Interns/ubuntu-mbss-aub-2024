#! /usr/bin/bash
source utils.sh

# 1.3.1.1 Ensure AppArmor is installed

{
    echo "Ensuring AppArmor is installed (1.3.1.1)..."
    apparmor_output=$(dpkg-query -s apparmor &>/dev/null && echo "apparmor is installed")
    apparmor_utils_output=$(dpkg-query -s apparmor-utils &>/dev/null && echo "apparmor-utils is installed")

    if ([[ "$apparmor_output"=="apparmor is installed" ]] && [[ "$apparmor_utils_output"=="apparmor-utils is installed" ]]);
    then
        echo "AppArmor audit output:"
        echo "$apparmor_output"
        echo "AppArmor-utils audit output:"
        echo "$apparmor_utils_output"
        echo "Audit Result: PASS"
    else    
        echo "AppArmor audit output:"
        echo "$apparmor_output"
        echo "AppArmor-utils audit output:"
        echo "$apparmor_utils_output"
        echo "Audit Result: FAIL"

        runFix "1.3.1.1" fixes/chap1/chap1_3/chap1_3_1/1_3_1_1.sh
    fi
}