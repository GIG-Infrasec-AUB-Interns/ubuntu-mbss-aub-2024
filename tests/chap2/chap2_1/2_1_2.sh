#! /usr/bin/bash
source utils.sh

{
    echo "Ensuring avahi daemon services are not in use (2.1.2)..."

    read -p "Does your machine have avahi daemon dependent packages? (Y/N): " DEPENDENCY

    case "$DEPENDENCY" in
        [Yy]*)
            echo "Verifying avahi daemon is not enabled..."
            systemctl_1=$(systemctl is-enabled avahi-daemon.socket avahi-daemon.service 2>/dev/null | grep 'enabled')
            systemctl_2=$(systemctl is-active avahi-daemon.socket avahi-daemon.service 2>/dev/null | grep '^active')
            
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
                runFix "2.1.2" fixes/chap2/chap2/2_1_2.sh
            fi
            ;;
        *)
            echo "Verifying avahi daemon is not installed..."

            dpkg_output=$(dpkg-query -s avahi-daemon &>/dev/null && echo "avahi-daemon is installed")

            if [[ -z "$dpkg_output" ]]; then
                echo "Output from dpkg:"
                echo "$dpkg_output"
                echo "Audit Result: PASS"
            else
                echo "Output from dpkg:"
                echo "$dpkg_output"
                echo "Audit Result: FAIL"
                runFix "2.1.2" fixes/chap2/chap2/2_1_2.sh
            fi
            ;;
    esac
}