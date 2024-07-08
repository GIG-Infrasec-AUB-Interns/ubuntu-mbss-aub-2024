# #! /usr/bin/bash
# source utils.sh

# # 1.1.2.2.4 Ensure noexec option set on /dev/shm partition

# {
#     echo "Ensuring noexec option set on /dev/shm partition (1.1.2.2.4)..."
#     findmnt_output=$(findmnt -kn /dev/shm | grep -v 'noexec')

#     if [[ -z "$findmnt_output" ]]; then
#         echo "Output from findmnt:"
#         echo "$findmnt_output"
#         echo "Audit Result: PASS"
#     else
#         echo "Output from findmnt:"
#         echo "$findmnt_output"
#         echo "Audit Result: FAIL"

#         runFix "1.1.2.2.4" fixes/chap1/chap1_1/chap1_1_2/chap1_1_2_2/1_1_2_2_4.sh
#     fi
# }