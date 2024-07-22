#!/usr/bin/bash
source utils.sh

{
    echo "Ensure password failed attempts lockout includes root account (5.3.3.1.3)..."
    fail_flag=0

    # Check if even_deny_root or root_unlock_time is enabled
    enable_query=$(grep -Pi -- '^\h*(#\s*even_deny_root|#\s*root_unlock_time\h*=\h*\d+)\b' /etc/security/faillock.conf)

    if echo "$enable_query" | grep -q "#\s*even_deny_root"; then
        echo "PASS: even_deny_root is enabled."
    elif echo "$enable_query" | grep -Pq '#\s*root_unlock_time\s*=\s*(\d+)'; then
        root_unlock_time=$(echo "$enable_query" | grep -Po '#\s*root_unlock_time\s*=\s*\K\d+')
        if [ "$root_unlock_time" -ge 60 ]; then
            echo "PASS: root_unlock_time is set to $root_unlock_time seconds."
        else
            echo "FAIL: root_unlock_time is set to less than 60 seconds."
            fail_flag=1
        fi
    else
        echo "FAIL: even_deny_root and/or root_unlock_time is NOT enabled."
        echo "Query output:"
        echo "$enable_query"
        fail_flag=1
    fi

    # Check root_unlock_time in faillock.conf
    unlock_time_output=$(grep -Pi -- '^\h*#\s*root_unlock_time\h*=\h*([1-9]|[1-5][0-9])\b' /etc/security/faillock.conf)
    if [ -z "$unlock_time_output" ]; then
        echo "PASS: root_unlock_time in faillock.conf is 60 seconds or more."
    else
        echo "FAIL: root_unlock_time in faillock.conf is set to less than 60 seconds."
        echo "Query output:"
        echo "$unlock_time_output"
        fail_flag=1
    fi

    # Check root_unlock_time in PAM configuration files
    faillock_check=$(grep -Pi -- '^\h*auth\h+([^#\n\r]+\h+)pam_faillock\.so\h+([^#\n\r]+\h+)?root_unlock_time\h*=\h*([1-9]|[1-5][0-9])\b' /etc/pam.d/common-auth)
    if [ -z "$faillock_check" ]; then
        echo "PASS: root_unlock_time in PAM configuration is 60 seconds or more."
    else
        echo "FAIL: root_unlock_time in PAM configuration is set to less than 60 seconds."
        echo "Query output:"
        echo "$faillock_check"
        fail_flag=1
    fi

    if [ $fail_flag -eq 1 ]; then
        echo "FAIL"
        runFix "5.3.3.1.3" fixes/chap5/chap5_3/chap5_3_3/chap5_3_3_1/5_3_3_1_3.sh
    else
        echo "PASS"
    fi
}
