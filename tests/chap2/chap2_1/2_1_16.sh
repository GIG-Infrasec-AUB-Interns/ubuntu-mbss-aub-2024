#! /usr/bin/bash
source utils.sh

{
    echo "Ensuring tftp server services are not in use (2.1.16)..."

    read -p "Does your machine have tftp server services dependencies? (Y/N): " DEPENDENCY

    case "$DEPENDENCY" in
        [Yy]*)
            echo "Verifying tftp server services is not enabled..."
            systemctl_1=$(systemctl is-enabled tftpd-hpa.service 2>/dev/null | grep 'enabled')
            systemctl_2=$(systemctl is-active tftpd-hpa.service 2>/dev/null | grep '^active')
            
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
                runFix "2.1.16" fixes/chap2/chap2/2_1_16.sh
            ;;
        *)
            echo "Verifying tftp server services is not installed..."

            dpkg_output1=$(dpkg-query -s tftpd-hpa &>/dev/null && echo "tftpd-hpa is installed")

            if [[ -z "$dpkg_output1" ]]; then
                echo "Output from dpkg:"
                echo "$dpkg_output1"
                echo "Audit Result: PASS"
            else
                echo "Output from dpkg:"
                echo "$dpkg_output1"
                echo "Audit Result: FAIL"
                runFix "2.1.16" fixes/chap2/chap2/2_1_16.sh
            fi
            ;;
    esac
}