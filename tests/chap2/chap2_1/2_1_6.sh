#! /usr/bin/bash
source utils.sh

{
    echo "Ensuring ftp server services are not in use (2.1.6)..."

    read -p "Does your machine have ftp server services dependent packages? (Y/N): " DEPENDENCY

    case "$DEPENDENCY" in
        [Yy]*)
            echo "Verifying ftp server services is not enabled..."
            systemctl_1=$(systemctl is-enabled vsftpd.service 2>/dev/null | grep 'enabled')
            systemctl_2=$(systemctl is-active vsftpd.service 2>/dev/null | grep '^active')
            
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
                runFix "2.1.6" fixes/chap2/chap2/2_1_6.sh
            fi
            ;;
        *)
            echo "Verifying ftp server services is not installed..."

            dpkg_output=$(dpkg-query -s vsftpd &>/dev/null && echo "vsftpd is installed")

            if [[ -z "$dpkg_output" ]]; then
                echo "Output from dpkg:"
                echo "$dpkg_output"
                echo "Audit Result: PASS"
            else
                echo "Output from dpkg:"
                echo "$dpkg_output"
                echo "Audit Result: FAIL"
                runFix "2.1.6" fixes/chap2/chap2/2_1_6.sh
            fi
            ;;
    esac
}