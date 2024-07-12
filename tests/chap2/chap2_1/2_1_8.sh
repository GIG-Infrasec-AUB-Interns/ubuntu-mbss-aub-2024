#! /usr/bin/bash
source utils.sh

{
    echo "Ensuring message access server services are not in use (2.1.8)..."

    read -p "Does your machine have message access server services dependent packages? (Y/N): " DEPENDENCY

    case "$DEPENDENCY" in
        [Yy]*)
            echo "Verifying message access server services is not enabled..."
            systemctl_1=$(systemctl is-enabled dovecot.socket dovecot.service 2>/dev/null | grep 'enabled')
            systemctl_2=$(systemctl is-active dovecot.socket dovecot.service 2>/dev/null | grep '^active')
            
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
                runFix "2.1.8" fixes/chap2/chap2_1/2_1_8.sh
            fi
            ;;
        *)
            echo "Verifying message access server services is not installed..."

            dpkg_output1=$(dpkg-query -s dovecot-imapd &>/dev/null && echo "dovecot-imapd is installed")
            dpkg_output2=$(dpkg-query -s dovecot-pop3d &>/dev/null && echo "dovecot-pop3d is installed")

            if [[ -z "$dpkg_output1" ]] && [[ -z "$dpkg_output2" ]]; then
                echo "Output from dovecot-imapd dpkg:"
                echo "$dpkg_output1"
                echo "Output from dovecot-pop3d dpkg:"
                echo "$dpkg_output2"
                echo "Audit Result: PASS"
            else
                echo "Output from dovecot-imapd dpkg:"
                echo "$dpkg_output1"
                echo "Output from dovecot-pop3d dpkg:"
                echo "$dpkg_output2"
                echo "Audit Result: FAIL"
                runFix "2.1.8" fixes/chap2/chap2_1/2_1_8.sh
            fi
            ;;
    esac
}