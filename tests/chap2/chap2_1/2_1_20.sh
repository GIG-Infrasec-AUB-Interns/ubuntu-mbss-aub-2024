#! /usr/bin/bash
source utils.sh

{
    echo "Ensuring X window server services are not in use for servers (2.1.20)..."

    read -p "Does your machine require Graphical Desktop Manager or X-Windows server and is approved by local site policy? (Y/N): " DEPENDENCY

    case "$DEPENDENCY" in
        [Yy]*)
            echo "Skipping audit of X window server services..."
            ;;
        *)
            echo "Verifying X window server services is not installed..."

            dpkg_output1=$(dpkg-query -s xserver-common &>/dev/null && echo "xserver-common is installed")

            if [[ -z "$dpkg_output1" ]]; then
                echo "Output from dpkg:"
                echo "$dpkg_output1"
                echo "Audit Result: PASS"
            else
                echo "Output from dpkg:"
                echo "$dpkg_output1"
                echo "Audit Result: FAIL"
                runFix "2.1.20" fixes/chap2/chap2_1/2_1_20.sh
            fi
            ;;
    esac
}