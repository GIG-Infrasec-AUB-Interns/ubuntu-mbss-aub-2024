#! /usr/bin/bash
source utils.sh
source globals.sh

{
    echo "Ensure root user umask is configured (5.4.2.6)..."

    grep_output=$(grep -Psi -- '^\h*umask\h+(([0-7][0-7][01][0-7]\b|[0-7][0-7][0-7][0-6]\b)|([0-7][01][0-7]\b|[0-7][0-7][0-6]\b)|(u=[rwx]{1,3},)?(((g=[rx]?[rx]?w[rx]?[rx]?\b)(,o=[rwx]{1,3})?)|((g=[wrx]{1,3},)?o=[wrx]{1,3}\b)))' /root/.bash_profile /root/.bashrc)

    if [[ -z $grep_output ]]; then
        echo "PASS"
    else
        echo "FAIL"
        runFix "5.4.2.6" fixes/chap5/chap5_4/chap5_4_2/5_4_2_6.sh
    fi
}