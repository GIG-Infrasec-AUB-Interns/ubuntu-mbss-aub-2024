#! /usr/bin/bash
source utils.sh

{
    echo "Ensuring dhcp server services are not in use (2.1.3)..."

    read -p "Does your machine have dhcp server service dependent packages? (Y/N): " DEPENDENCY

    case "$DEPENDENCY" in
        [Yy]*)
            echo "Verifying dhcp server services is not enabled..."
            systemctl_1=$(systemctl is-enabled isc-dhcp-server.service isc-dhcp-server6.service 2>/dev/null | grep 'enabled')
            systemctl_2=$(systemctl is-active isc-dhcp-server.service isc-dhcp-server6.service 2>/dev/null | grep '^active')
            
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
                runFix "2.1.3" fixes/chap2/chap2/2_1_3.sh
            fi
            ;;
        *)
            echo "Verifying dhcp server services is not installed..."

            dpkg_output=$(dpkg-query -s isc-dhcp-server &>/dev/null && echo "isc-dhcp-server is installed")

            if [[ -z "$dpkg_output" ]]; then
                echo "Output from dpkg:"
                echo "$dpkg_output"
                echo "Audit Result: PASS"
            else
                echo "Output from dpkg:"
                echo "$dpkg_output"
                echo "Audit Result: FAIL"
                runFix "2.1.3" fixes/chap2/chap2/2_1_3.sh
            fi
            ;;
    esac
}