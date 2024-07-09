#! /usr/bin/bash
source utils.sh

{
    echo "Ensuring dnsmasq services are not in use (2.1.5)..."

    read -p "Does your machine have dnsmasq service dependent packages? (Y/N): " DEPENDENCY

    case "$DEPENDENCY" in
        [Yy]*)
            echo "Verifying dnsmasq services is not enabled..."
            systemctl_1=$(systemctl is-enabled dnsmasq.service 2>/dev/null | grep 'enabled')
            systemctl_2=$(systemctl is-active dnsmasq.service 2>/dev/null | grep '^active')
            
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
                runFix "2.1.5" fixes/chap2/chap2/2_1_5.sh
            ;;
        *)
            echo "Verifying dnsmasq services is not installed..."

            dpkg_output=$(dpkg-query -s dnsmasq &>/dev/null && echo "dnsmasq is installed")

            if [[ -z "$dpkg_output" ]]; then
                echo "Output from dpkg:"
                echo "$dpkg_output"
                echo "Audit Result: PASS"
            else
                echo "Output from dpkg:"
                echo "$dpkg_output"
                echo "Audit Result: FAIL"
                runFix "2.1.5" fixes/chap2/chap2/2_1_5.sh
            fi
            ;;
    esac
}