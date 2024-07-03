#! /usr/bin/bash

# 1.1.2.1.1 Ensure /tmp is a separate partition

{
    echo "Ensuring /tmp is a separate partition (1.1.2.1.1)..."

    output1=$(findmnt -kn /tmp)
    output2=$(systemctl is-enabled tmp.mount)

    expected_output="/tmp tmpfs tmpfs rw,nosuid,nodev,noexec"
    expected_generated="generated"
    expected_disabled="disabled"
    expected_masked="masked"

    # Check if output1 matches the expected output and output2 is not masked or disabled
    if [ "$output1" != "$expected_output" ] || [ "$output2" == "$expected_disabled" ] || [ "$output2" == "$expected_masked" ]; then
        echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n"$output1"\n"$output2"\n"
        # Remediation
        read -p "Run remediation script for Test 1.1.2.1.1? (Y/N): " ANSWER
        case "$ANSWER" in
            [Yy]*)
                echo "Commencing remediation for Test 1.1.2.1.1..."
                
                FIXES_SCRIPT="$(realpath fixes/chap1/chap1_1/chap1_1_2/chap1_1_2_1/1_1_2_1_1.sh)"
                if [ -f "$FIXES_SCRIPT" ]; then
                    chmod +x "$FIXES_SCRIPT"
                    "$FIXES_SCRIPT"
                else
                    echo "Error: $FIXES_SCRIPT is not found."
                fi
                echo "For more information, please visit https://downloads.cisecurity.org/#/"
                ;;
            *)
                echo "Remediation not commenced"
                echo "For more information, please visit https://downloads.cisecurity.org/#/"
                ;;
        esac
    else
        echo -e "\n- Audit Result:\n ** PASS **\n"$output1"\n"$output2"\n"
    fi
}