#!/bin/bash
source utils.sh
# 5.1.5 Ensure sshd Banner is configured
{
    # Run the sshd -T command to retrieve SSH server configuration and grep for ciphers
    cipher_output=$(sshd -T | grep -Pi -- '^ciphers\h+\"?([^#\n\r]+,)?((3des|blowfish|cast128|aes(128|192|256))-cbc|arcfour(128|256)?|rijndael-cbc@lysator\.liu\.se|chacha20-poly1305@openssh\.com)\b')

    # Check if the cipher_output contains any "weak" ciphers
    if [[ -n "$cipher_output" ]]; then
        echo "Audit Result: Fail"
        echo "Weak ciphers found:"
        echo "$cipher_output"
        # Check if chacha20-poly1305@openssh.com is present
        if echo "$cipher_output" | grep -q "chacha20-poly1305@openssh.com"; then
            echo "CVE-2023-48795 should be reviewed and system patched."
        fi
        #Remediation currently not working
        runFix "5.1.6" fixes/chap5/chap5_1/5_1_6.sh  
    else
        echo "Audit Result: Pass"
        echo "No weak ciphers found."
    fi
}