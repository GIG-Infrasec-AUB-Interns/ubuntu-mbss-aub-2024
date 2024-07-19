#!/usr/bin/bash
source utils.sh
# 5.2.6 Ensure sudo authentication timeout is configured correctly

{
    output=$( grep -roP "timestamp_timeout=\K[0-9]*" /etc/sudoers* )
    if [[ -z "$output" ]]; then
        output2=$( sudo -V | grep "Authentication timestamp timeout:")
        if [[ "$output2" == '"Authentication timestamp timeout: 15.0 minutes"' ]]; then
            echo "Audit Result: Pass" 
        elif [[ "$output2" == "-1" ]]
            echo "Audit Result: Fail"
            echo "Timeout is disabled"
        fi

    else
        echo "Audit Result: Fail"
        
        # Remediation
        echo "If the currently configured timeout is larger than 15 minutes, "
        echo "edit the file listed in the audit section with visudo -f <PATH TO FILE> "
        echo "and modify the entry timestamp_timeout= to 15 minutes or less as per your site policy. "
        echo "The value is in minutes. "
        echo -e "This particularentry may appear on it's own, or on the same line as env_reset. \n \n "
        
        echo "See the following two examples:"
        echo "Defaults env_reset, timestamp_timeout=15"
        echo "Defaults timestamp_timeout=15"
        echo "Defaults env_reset"

        
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