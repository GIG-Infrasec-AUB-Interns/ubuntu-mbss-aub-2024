#! /usr/bin/bash
source utils.sh

{
    echo "Ensuring autofs services are not in use (2.1.1)..."

    read -p "Does your machine have autofs dependent packages? (Y/N): " AUTOFS_ANSWER

    case "$AUTOFS_ANSWER" in
        [Yy]*)
            echo "Verifying autofs is not enabled..."
            systemctl_1=$(systemctl is-enabled autofs.service 2>/dev/null | grep 'enabled')
            systemctl_2=$(systemctl is-active autofs.service 2>/dev/null | grep '^active')
            
            if [[ -z "$systemctl_1" ]] && [[ -z "$systemctl_2" ]]; then
                echo "Output from systemctl_1:"
                echo "$systemctl_1"
                echo "Output from systemctl_2:"
                echo "$systemctl_2"
                echo "Audit Result: PASS"
            else
                echo "Output from systemctl_1:"
                echo "$systemctl_1"
                echo "Output from systemctl_2:"
                echo "$systemctl_2"
                echo "Audit Result: FAIL"
                runFix "2.1.1" fixes/chap2/chap2/2_1_1.sh
            fi
            ;;
        *)
            echo "Verifying autofs is not installed..."

            dpkg_output=$( dpkg-query -s autofs &>/dev/null && echo "autofs is installed")

            if [[ -z "$dpkg_output" ]]; then
                echo "Output from dpkg:"
                echo "$dpkg_output"
                echo "Audit Result: PASS"
            else
                echo "Output from dpkg:"
                echo "$dpkg_output"
                echo "Audit Result: FAIL"
                runFix "2.1.1" fixes/chap2/chap2/2_1_1.sh
            fi
            ;;
    esac
}
