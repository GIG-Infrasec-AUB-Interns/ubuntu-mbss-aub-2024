#!/usr/bin/bash
source utils.sh
# 5.2.3 Ensure sudo log file exists

{

    output=$(grep -rPsi "^\h*Defaults\h+([^#]+,\h*)?logfile\h*=\h*(\"|\')?\H+(\"|\')?(,\h*\H+\h*)*\h* (#.*)?$" /etc/sudoers*)
    expected='Defaults logfile="/var/log/sudo.log"'
    if [[ "$output" == *"$expected"* ]]; then
        echo "Audit Result: Pass"
    else
        echo "Audit Result: Fail"

        # Remediation
        echo "5.2.3 Edit the file /etc/sudoers with visudo or a file in /etc/sudoers.d/ with visudo -f <PATHTO FILE> and add the following line:"
        echo "Defaults logfile="/var/log/sudo.log""
        
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