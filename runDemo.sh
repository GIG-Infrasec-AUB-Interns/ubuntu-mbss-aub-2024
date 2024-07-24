#! /usr/bin/bash
source utils.sh
source globals.sh
# Benchmark tests on Ubuntu 22.04.4 based on
# CIS Benchmarks https://downloads.cisecurity.org/#/

# to run, please run the commands below on the terminal

# su root
# chmod +x runDemo.sh 
# ./runDemo.sh

echo "Ubuntu 22.04.4 Benchmark Tests DEMO"
echo "Developed by Group GIG (InfraSec Team): Gabriel Calubayan, Ieiaiel Sanceda, Gabriel Limbaga"
echo ""

# test 1.7.3 (user list)
echo "Partially auditing GNOME Display Manager configuration (1.7)..."
# login banner
echo "Auditing GDM login banner (1.7.2)..."
./tests/chap1/chap1_7/1_7_2.sh
# disable user list
echo "Checking if GDM disable-user-list option is enabled (1.7.3)..."
./tests/chap1/chap1_7/1_7_3.sh

# Chapter 5.3
echo "Partially testing Pluggable Authentication Modules (Chapter 5.3)..."
echo "Running PAM software package configuration tests (Chapter 5.3.1)..."
runTests ./tests/chap5/chap5_3/chap5_3_1/*.sh

echo "Testing pam-auth-update profiles (Chapter 5.3.2)..."
runTests ./tests/chap5/chap5_3/chap5_3_2/*.sh

echo "Partially testing PAM arguments (Chapter 5.3.3)..."
echo "Running PAM software package configuration tests (Chapter 5.3.3.1)..."
runTests ./tests/chap5/chap5_3/chap5_3_3/chap5_3_3_1/*.sh

echo "Running pam_pwquality module configuration tests (Chapter 5.3.3.2)..."
runTests ./tests/chap5/chap5_3/chap5_3_3/chap5_3_3_2/*.sh