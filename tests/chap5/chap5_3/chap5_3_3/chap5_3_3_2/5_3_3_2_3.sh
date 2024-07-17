#!/usr/bin/bash
source utils.sh
source globals.sh

# Configuration values
{
    echo "Ensure password complexity is configured (5.3.3.2.3)..."
    fail_flag=0

    grep_query=$(grep -Psi -- '^\h*(minclass|[dulo]credit)\b' /etc/security/pwquality.conf /etc/security/pwquality.conf.d/*.conf)

    # Check for minclass
    if echo "$grep_query" | grep -q "minclass = $MINCLASS"; then
        echo "PASS: minclass is set correctly."
    else
        echo "FAIL: minclass is not set to $MINCLASS."
        fail_flag=1
    fi

    # Check dcredit
    if echo "$grep_query" | grep -q "dcredit = $DCREDIT"; then
        echo "PASS: dcredit is set correctly."
    else
        echo "FAIL: dcredit is not set to $DCREDIT."
        fail_flag=1
    fi

    # Check ucredit
    if echo "$grep_query" | grep -q "ucredit = $UCREDIT"; then
        echo "PASS: ucredit is set correctly."
    else
        echo "FAIL: ucredit is not set to $UCREDIT."
        fail_flag=1
    fi

    # Check ocredit
    if echo "$grep_query" | grep -q "ocredit = $OCREDIT"; then
        echo "PASS: ocredit is set correctly."
    else
        echo "FAIL: ocredit is not set to $OCREDIT."
        fail_flag=1
    fi

    # Check lcredit
    if echo "$grep_query" | grep -q "lcredit = $LCREDIT"; then
        echo "PASS: lcredit is set correctly."
    else
        echo "FAIL: lcredit is not set to $LCREDIT."
        fail_flag=1
    fi

    # Check pam_pwquality.so arguments
    grep_query2=$(grep -Psi -- '^\h*password\h+(requisite|required|sufficient)\h+pam_pwquality\.so\h+([^#\n\r]+\h+)?(minclass|[dulo]credit)\b' /etc/pam.d/common-password)

    if [[ -z "$grep_query2" ]]; then
        echo "PASS: No conflicting pam_pwquality arguments found."
    else
        echo "FAIL: Conflicting pam_pwquality arguments found."
        echo "$grep_query2"
        fail_flag=1
    fi

    if [[ $fail_flag -eq 0 ]]; then
        echo "Overall Check: PASS"
    else
        echo "Overall Check: FAIL"
        runFix "5.3.3.2.3" fixes/chap5/chap5_3/chap5_3_3/chap5_3_3_2/5_3_3_2_3.sh
    fi
}
