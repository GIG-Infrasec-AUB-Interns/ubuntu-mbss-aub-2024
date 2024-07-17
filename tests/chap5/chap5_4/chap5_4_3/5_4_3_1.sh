#! /usr/bin/bash
source utils.sh
source globals.sh

{
    echo "Ensure nologin is not listed in /etc/shells (5.4.3.1)..."

    script_output=$(grep '/nologin\b' /etc/shells)

    if [[ -z $script_output ]]; then
        echo "PASS"
    else
        echo "FAIL"
        echo "Script output:"
        echo "$script_output"
        runFix "5.4.3.1" fixes/chap5/chap5_4/chap5_4_3/5_4_3_1.sh
    fi
}
