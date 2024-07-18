#!/usr/bin/bash
source utils.sh
source globals.sh

{
    echo "Ensure strong password hashing algorithm is configured (5.4.1.4)..."
    hashing_algo_output=$(grep -Pi -- '^\h*ENCRYPT_METHOD\h+(SHA512|yescrypt)\b' /etc/login.defs)
    hashing_algo=$(echo $hashing_algo_output | grep -oP '(SHA512|yescrypt)')

    if [[ -z $hashing_algo ]]; then
        echo "FAIL"
        runFix "5.4.1.4" fixes/chap5/chap5_4/chap5_4_1/5_4_1_4.sh
    else
        echo "PASS"
    fi
}
