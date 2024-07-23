#!/usr/bin/bash
source utils.sh
# 5.2.5 Ensure re-authentication for privilege escalation is not disabled globally

{
    output=$(grep -r "^[^#].*\!authenticate" /etc/sudoers* 2>/dev/null)

    if [[ -z "$output" ]]; then
        echo "Audit Result: Pass"
    else
        echo "Audit Result: Fail"
        echo "Lines found with !authenticate:"
        echo "$output"

        # Remediation
        echo "Configure the operating system to require users to reauthenticate for privilege escalation."
        echo "Based on the outcome of the audit procedure, use visudo -f <PATH TO FILE> to edit the relevant sudoers file."
        echo "Remove any occurrences of !authenticate tags in the file(s)"
        
        read -p "5.2.5 Do you understand the instructions mentioned above? (Y/N):" ANSWER
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