#! /usr/bin/bash
source utils.sh

{
    echo "Ensuring rpcbind services are not in use (2.1.12)..."

    read -p "Does your machine have rpcbind services dependent packages? (Y/N): " DEPENDENCY

    case "$DEPENDENCY" in
        [Yy]*)
            echo "Verifying rpcbind services is not enabled..."
            systemctl_1=$(systemctl is-enabled rpcbind.socket rpcbind.service 2>/dev/null | grep 'enabled')
            systemctl_2=$(systemctl is-active rpcbind.socket rpcbind.service 2>/dev/null | grep '^active')
            
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
                runFix "2.1.12" fixes/chap2/chap2_1/2_1_12.sh
            fi
            ;;
        *)
            echo "Verifying rpcbind services is not installed..."

            dpkg_output1=$(dpkg-query -s rpcbind &>/dev/null && echo "rpcbind is installed")

            if [[ -z "$dpkg_output1" ]]; then
                echo "Output from dpkg:"
                echo "$dpkg_output1"
                echo "Audit Result: PASS"
            else
                echo "Output from dpkg:"
                echo "$dpkg_output1"
                echo "Audit Result: FAIL"
                runFix "2.1.12" fixes/chap2/chap2_1/2_1_12.sh
            fi
            ;;
    esac
}