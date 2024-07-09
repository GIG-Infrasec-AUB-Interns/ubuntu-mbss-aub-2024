#! /usr/bin/bash
source utils.sh

{
    echo "Ensuring snmp services are not in use (2.1.15)..."

    read -p "Does your machine have snmp services dependencies? (Y/N): " DEPENDENCY

    case "$DEPENDENCY" in
        [Yy]*)
            echo "Verifying snmp services is not enabled..."
            systemctl_1=$(systemctl is-enabled snmpd.service 2>/dev/null | grep 'enabled')
            systemctl_2=$(systemctl is-active snmpd.service 2>/dev/null | grep '^active')
            
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
                runFix "2.1.15" fixes/chap2/chap2/2_1_15.sh
            ;;
        *)
            echo "Verifying snmp services is not installed..."

            dpkg_output1=$(dpkg-query -s snmpd &>/dev/null && echo "snmpd is installed")

            if [[ -z "$dpkg_output1" ]]; then
                echo "Output from dpkg:"
                echo "$dpkg_output1"
                echo "Audit Result: PASS"
            else
                echo "Output from dpkg:"
                echo "$dpkg_output1"
                echo "Audit Result: FAIL"
                runFix "2.1.15" fixes/chap2/chap2/2_1_15.sh
            fi
            ;;
    esac
}