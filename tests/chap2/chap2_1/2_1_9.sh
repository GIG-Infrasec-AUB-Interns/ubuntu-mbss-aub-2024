#! /usr/bin/bash
source utils.sh

{
    echo "Ensuring network file system services are not in use (2.1.9)..."

    read -p "Does your machine have network file system services dependent packages? (Y/N): " DEPENDENCY

    case "$DEPENDENCY" in
        [Yy]*)
            echo "Verifying network file system services is not enabled..."
            systemctl_1=$(systemctl is-enabled nfs-server.service 2>/dev/null | grep 'enabled')
            systemctl_2=$(systemctl is-active nfs-server.service 2>/dev/null | grep '^active')
            
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
                runFix "2.1.9" fixes/chap2/chap2_1/2_1_9.sh
            fi
            ;;
        *)
            echo "Verifying network file system services is not installed..."

            dpkg_output1=$(dpkg-query -s nfs-kernel-server &>/dev/null && echo "nfs-kernel-server is installed")

            if [[ -z "$dpkg_output1" ]]; then
                echo "Output from dpkg:"
                echo "$dpkg_output1"
                echo "Audit Result: PASS"
            else
                echo "Output from dpkg:"
                echo "$dpkg_output1"
                echo "Audit Result: FAIL"
                runFix "2.1.9" fixes/chap2/chap2_1/2_1_9.sh
            fi
            ;;
    esac
}