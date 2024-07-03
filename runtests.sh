#! /usr/bin/bash

# Benchmark tests on Ubuntu 22.04.4 based on
# CIS Benchmarks https://downloads.cisecurity.org/#/

# to run, please run the commands below on the terminal

# su root
# chmod +x runtests.sh 
# ./runtests.sh

function runTests() {
    local FILES=("$@") # store all file paths in array
    for FILE in "${FILES[@]}"
        do
            chmod +x "$FILE"  # ensure the file is executable
            if [ -x "$FILE" ]; then
                ./"$FILE"  # execute file
            else
                echo "Error: $FILE is not executable or does not exist."
            fi
    done
}

echo "Ubuntu 22.04.4 Benchmark Tests based on CIS Benchmarks"
echo "Developed by AUB Interns: Gabriel Calubayan, Ieiaiel Sanceda, Gabriel Limbaga"
echo ""

# Chapter 1 Initial Setup

# 1.1 Filesystem
echo "Running Filesystem tests (Chapter 1.1)..."

echo "Testing filesystem kernel module configurations (1.1.1)..."
runTests ./tests/chap1/chap1_1/chap1_1_1/*.sh

# echo "Testing filesystem partitions (1.1.2)..."
# runTests ./tests/chap1/chap1_1/chap1_1_2/*.sh

# 1.3 Mandatory Access Control
# echo "Running Mandatory Access Control tests (Chapter 1.3)..."

# echo "Testing AppArmor configuration (1.3.1)..."
# runTests ./tests/chap1/chap1_3/chap1_3_1/*.sh

