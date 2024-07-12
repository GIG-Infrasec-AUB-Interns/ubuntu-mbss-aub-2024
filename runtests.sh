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

# # Chapter 1 Initial Setup


# # 1.1 Filesystem
# echo "Running Filesystem tests (Chapter 1.1)..."

# echo "Testing filesystem kernel module configurations (1.1.1)..."
# runTests ./tests/chap1/chap1_1/chap1_1_1/*.sh

# echo "Testing filesystem partitions (1.1.2)..."
# echo "Testing config of /tmp (1.1.2.1)..."
# runTests ./tests/chap1/chap1_1/chap1_1_2/chap1_1_2_1/*.sh
# echo "Testing config of /dev/shm (1.1.2.2)..."             # test 1.1.2.2.4 problematic, not updating noexec field
# runTests ./tests/chap1/chap1_1/chap1_1_2/chap1_1_2_2/*.sh
# echo "Testing config of /home (1.1.2.3)..."
# runTests ./tests/chap1/chap1_1/chap1_1_2/chap1_1_2_3/*.sh
# echo "Testing config of /var (1.1.2.4)..."
# runTests ./tests/chap1/chap1_1/chap1_1_2/chap1_1_2_4/*.sh
# echo "Testing config of /var/tmp (1.1.2.5)..."
# runTests ./tests/chap1/chap1_1/chap1_1_2/chap1_1_2_5/*.sh
# echo "Testing config of /var/log (1.1.2.6)..."
# runTests ./tests/chap1/chap1_1/chap1_1_2/chap1_1_2_6/*.sh
# echo "Testing config of /var/log/audit (1.1.2.7)..."
# runTests ./tests/chap1/chap1_1/chap1_1_2/chap1_1_2_7/*.sh


# # 1.3 Mandatory Access Control   # test 1.3.2 is problematic, grub not updating
# # echo "Testing Mandatory Access Control (1.3)..."
# # echo "Testing AppArmor configuration (1.3.1)..."
# # runTests ./tests/chap1/chap1_3/chap1_3_1/*.sh

# # 1.4 Testing configuration of bootloader # test 1.4.1 is problematic, password seemingly not updating
# # echo "Testing config of bootloader (1.4)..."
# # runTests ./tests/chap1/chap1_4/*.sh

# # 1.5 tests
# runTests ./tests/chap1/chap1_5/*.sh

# # 1.6 tests not done because it needs specific text from the organization approved by the legal department

# # 1.7 tests
# if check_gdm_installed; then
#     echo "GDM is installed."
#     echo "Running GDM tests..."
#     runTests ./tests/chap1/chap1_7/*.sh
# else
#     echo "GDM is not installed. Skipping GNOME Display Manager configuration."
# fi

# # Chapter 2 Services

# # 2.1 Server Services
# echo "Running server services configuration tests (Chapter 2.1)..."
# runTests ./tests/chap2/chap2_1/*.sh

# echo "Running client services configuration tests (Chapter 2.2)..."
# runTests ./tests/chap2/chap2_2/*.sh

# echo "Running time synchronization configuration tests (Chapter 2.3)..."
# echo "Ensuring time synchronization is in use (Chapter 2.3.1)..."
# runTests ./tests/chap2/chap2_2/chap2_3_1/*.sh

# if [[ "$TIME_SYNCH" == "systemd-timesyncd" ]]; then
#     echo "Checking systemd-timesyncd configuration (Chapter 2.3.2)..."
#     runTests ./tests/chap2/chap2_2/chap2_3_2/*.sh
# elif [[ "$TIME_SYNCH" == "chrony" ]]; then
#     echo "Checking chrony configuration (Chapter 2.3.3)..."
#     runTests ./tests/chap2/chap2_2/chap2_3_3/*.sh
# else
#     echo "No time synchronization in use."
# fi

# echo "Running job scheduler tests (2.4)..."

# cron_installed=$(dpkg -l | grep cron)

# if [[ -z "$cron_installed" ]]; then
#     echo "Running cron configuration tests (2.4.1)..."
#     runTests ./tests/chap2/chap2_4/chap2_4_1/*.sh
# else
#     echo "cron not installed. Skipping 2.4.1 tests..."
# fi


# at_installed=$(dpkg -l | grep at)

# if [[ -z "$at_installed" ]]; then
#     echo "Running at configuration tests (2.4.2)..."
#     runTests ./tests/chap2/chap2_4/chap2_4_2/*.sh
# else
#     echo "at not installed. Skipping 2.4.1 tests..."
# fi

# 3.1 Network device configuration
echo "Running Network device configuration (Chapter 3.1)..."
runTests ./tests/chap3/chap3_1/*.sh


echo "Running Network kernel module configuration(Chapter 3.2)..."
runTests ./tests/chap3/chap3_2/*.sh

#runTests for 3.3 is currently not working (results in nonterminating condition and skipping to the output for 3.3.10)
#runTests ./tests/chap3/chap3_3/*.sh

# 4.1 UncomplicatedFirewall configuration
echo "Running UncomplicatedFirewall configuration (Chapter 4.1)..."
runTests ./tests/chap4/chap4_1/*.sh
# for 4.1, 4.1.4 - 4.1.6 were not tested since they needed input for site policies which is unavailable to the team at the moment.
runTests ./tests/chap4/chap4_2/*.sh

