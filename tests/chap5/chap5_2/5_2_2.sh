#!/usr/bin/bash
source utils.sh
# 5.2.2 Ensure sudo commands use pty

{

    output=$(grep -rPi -- '^\s*Defaults\s+([^#\n\r]+,)?use_pty(,\s*\S+)*\s*(#.*)?$' /etc/sudoers* 2>/dev/null)
    output2=$(grep -rPi -- '^\h*Defaults\h+([^#\n\r]+,)?!use_pty(,\h*\h+\h*)*\h*(#.*)?$' /etc/sudoers*)
   
    if [[ "$output" == *"Defaults use_pty"* && -z "$output2" ]]; then
        echo "Audit Result: Pass"
    else
        echo "Audit Result: Fail"

        # Remediation
        echo "Edit the file /etc/sudoers with visudo or a file in /etc/sudoers.d/ with visudo -f <PATHTO FILE> and add the following line:"
        echo "Defaults use_pty"
        echo "Edit the file /etc/sudoers with visudo and any files in /etc/sudoers.d/ with visudo -f <PATH TO FILE> and remove any occurrence of !use_pty"

        read -p "5.2.2 Do you understand the instructions mentioned above? (Y/N):" ANSWER
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