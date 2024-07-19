#! /usr/bin/bash
source ./utils.sh
source ./globals.sh
# Benchmark tests on Ubuntu 22.04.4 based on
# CIS Benchmarks https://downloads.cisecurity.org/#/

# to run, please run the commands below on the terminal

# su root
# chmod +x runtests.sh 
# ./runtests.sh

echo "Ubuntu 22.04.4 Benchmark Tests based on CIS Benchmarks"
echo "Developed by AUB Interns: Gabriel Calubayan, Ieiaiel Sanceda, Gabriel Limbaga"
echo ""

# Chapter 5

echo "Running pam_faillock module configuration tests (Chapter 5.3.3.1)..."
runTests ./tests/chap5/chap5_3/chap5_3_3/chap5_3_3_1/*.sh

echo "Running pam_pwquality module configuration tests (Chapter 5.3.3.2)..."
runTests ./tests/chap5/chap5_3/chap5_3_3/chap5_3_3_2/*.sh

echo "Running pam_pwhistory module configuration tests (Chapter 5.3.3.3)..."
runTests ./tests/chap5/chap5_3/chap5_3_3/chap5_3_3_3/*.sh
