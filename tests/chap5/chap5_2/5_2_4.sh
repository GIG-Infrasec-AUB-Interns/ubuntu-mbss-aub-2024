#!/usr/bin/bash
source utils.sh
# 5.2.4  Ensure users must provide password for privilege escalation

{
    output=$(grep -r "^[^#].*NOPASSWD" /etc/sudoers* 2>/dev/null)

    if [[ -z "$output" ]]; then
        echo "Audit Result: Pass"
    else
        echo "Audit Result: Fail"
        echo "Lines found:"
        echo "$output"

        # Remediation
        echo "Based on the outcome of the audit procedure, use visudo -f <PATH TO FILE> to edit the relevant sudoers file."
        echo "Remove any line with occurrences of NOPASSWD tags in the file."
        
        read -p "Do you understand the instructions mentioned above? (Y/N):" ANSWER
        case "$ANSWER" in
            [Yy]*)
                echo "Thank you. Please follow the instructions to make the necessary changes."
                ;;
            *)
                echo "For more information, please visit https://downloads.cisecurity.org/#/"
                ;;
        esac
    fi
}