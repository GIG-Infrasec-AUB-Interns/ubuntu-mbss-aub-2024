#!/usr/bin/bash
source utils.sh
# 5.2.7 Ensure access to the su command is restricted

{
    sudo sed -i '/^#\s*auth\s\+required\s\+pam_wheel.so\s\+deny\s\+group=nosu/s/^#\s*//;s/deny/use_uid/' /etc/pam.d/su
    
    output2=$(grep nosu /etc/group)
    if [[ -z "$output2" ]]; then
        sudo groupadd nosu
    fi
    
    output=$( grep -Pi '^\h*auth\h+(?:required|requisite)\h+pam_wheel\.so\h+(?:[^#\n\r]+\h+)?((?!\2) (use_uid\b|group=\H+\b))\h+(?:[^#\n\r]+\h+)?((?!\1)(use_uid\b|group=\H+\b))(\ h+.*)?$' /etc/pam.d/su)
    expected="auth       required   pam_wheel.so use_uid group=nosu"
    
    group_output=$(grep nosu /etc/group)
    nouser=false
    if [[ -n "$group_output" ]]; then
        user_list=$(echo "$output" | awk -F: '{print $4}')
        if [[ -z "$user_list" ]]; then
            nouser=true
        fi
    fi        

    if [[ "$output" == *"$expected"* && "$nouser" == true ]]; then
        echo "Audit Result: Pass"
    else
        echo "Audit Result: Fail"
    
        # Remediation
        echo "Create an empty group that will be specified for use of the su command. "
        echo "The group should be named according to site policy."
        echo "groupadd sugroup"
        echo "Add the following line to the /etc/pam.d/su file, specifying the empty group"
        echo "auth required pam_wheel.so use_uid group=sugroup"

        echo "for running the test scripts, replace all 'nosu' group name fields in the code with the new name for the empty group"

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