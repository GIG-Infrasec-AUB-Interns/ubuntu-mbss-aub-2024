#! /usr/bin/bash
source utils.sh

{
    echo "Ensuring xinetd services are not in use (2.1.19)..."

    read -p "Does your machine have xinetd services dependencies? (Y/N): " DEPENDENCY

    case "$DEPENDENCY" in
        [Yy]*)
            echo "Verifying xinetd services is not enabled..."
            systemctl_1=$(systemctl is-enabled xinetd.service 2>/dev/null | grep 'enabled')
            systemctl_2=$(systemctl is-active xinetd.service 2>/dev/null | grep '^active')
            
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
                runFix "2.1.19" fixes/chap2/chap2/2_1_19.sh
            fi
            ;;
        *)
            echo "Verifying xinetd services is not installed..."

            dpkg_output1=$(dpkg-query -s xinetd &>/dev/null && echo "xinetd is installed")

            if [[ -z "$dpkg_output1" ]]; then
                echo "Output from dpkg:"
                echo "$dpkg_output1"
                echo "Audit Result: PASS"
            else
                echo "Output from dpkg:"
                echo "$dpkg_output1"
                echo "Audit Result: FAIL"
                runFix "2.1.19" fixes/chap2/chap2/2_1_19.sh
            fi
            ;;
    esac
}