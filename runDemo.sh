#! /usr/bin/bash
source ./demo/utils.sh
source ./demo/globals.sh
# Benchmark tests on Ubuntu 22.04.4 based on
# CIS Benchmarks https://downloads.cisecurity.org/#/

# to run, please run the commands below on the terminal

# su root
# chmod +x runDemo.sh 
# ./demo/runDemo.sh

echo "Ubuntu 22.04.4 Benchmark Tests DEMO"
echo "Developed by Group GIG (InfraSec Team): Gabriel Calubayan, Ieiaiel Sanceda, Gabriel Limbaga"
echo ""

# Chapter 5

echo "Running pam_faillock module configuration tests (Chapter 5.3.3.1)..."

runTests ./demo/tests/chap5/chap5_3/chap5_3_3/chap5_3_3_1/*.sh

echo "Running pam_pwquality module configuration tests (Chapter 5.3.3.2)..."
runTests ./demo/tests/chap5/chap5_3/chap5_3_3/chap5_3_3_2/*.sh

echo "Running pam_pwhistory module configuration tests (Chapter 5.3.3.3)..."
runTests ./demo/tests/chap5/chap5_3/chap5_3_3/chap5_3_3_3/*.sh
