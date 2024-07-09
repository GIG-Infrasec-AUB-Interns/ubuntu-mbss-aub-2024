#! /usr/bin/bash
source utils.sh

{
    echo "Ensuring web server services are not in use (2.1.18)..."

    read -p "Does your machine have web server services dependencies? (Y/N): " DEPENDENCY

    case "$DEPENDENCY" in
        [Yy]*)
            echo "Verifying web server services is not enabled..."
            systemctl_1=$(systemctl is-enabled apache2.socket apache2.service nginx.service 2>/dev/null | grep 'enabled')
            systemctl_2=$(systemctl is-active apache2.socket apache2.service nginx.service 2>/dev/null | grep '^active')
            
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
                runFix "2.1.18" fixes/chap2/chap2/2_1_18.sh
            ;;
        *)
            echo "Verifying web server services is not installed..."

            dpkg_output1=$(dpkg-query -s apache2 &>/dev/null && echo "apache2 is installed")
            dpkg_output2=$(dpkg-query -s nginx &>/dev/null && echo "nginx is installed")

            if [[ -z "$dpkg_output1" ]] && [[ -z "$dpkg_output2" ]]; then
                echo "Output from apache2 dpkg:"
                echo "$dpkg_output1"
                echo "Output from nginx dpkg:"
                echo "$dpkg_output2"
                echo "Audit Result: PASS"
            else
                echo "Output from apache2 dpkg:"
                echo "$dpkg_output1"
                echo "Output from nginx dpkg:"
                echo "$dpkg_output2"
                echo "Audit Result: FAIL"
                runFix "2.1.18" fixes/chap2/chap2/2_1_18.sh
            fi
            ;;
    esac
}