#! /usr/bin/bash
source utils.sh

{
    echo "Ensuring samba file server services are not in use (2.1.14)..."

    read -p "Does your machine have samba file server services dependencies? (Y/N): " DEPENDENCY

    case "$DEPENDENCY" in
        [Yy]*)
            echo "Verifying samba file server services is not enabled..."
            systemctl_1=$(systemctl is-enabled smbd.service 2>/dev/null | grep 'enabled')
            systemctl_2=$(systemctl is-active smbd.service 2>/dev/null | grep '^active')
            
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
                runFix "2.1.14" fixes/chap2/chap2_1/2_1_14.sh
            fi
            ;;
        *)
            echo "Verifying samba file server services is not installed..."

            dpkg_output1=$(dpkg-query -s samba &>/dev/null && echo "samba is installed")

            if [[ -z "$dpkg_output1" ]]; then
                echo "Output from dpkg:"
                echo "$dpkg_output1"
                echo "Audit Result: PASS"
            else
                echo "Output from dpkg:"
                echo "$dpkg_output1"
                echo "Audit Result: FAIL"
                runFix "2.1.14" fixes/chap2/chap2_1/2_1_14.sh
            fi
            ;;
    esac
}