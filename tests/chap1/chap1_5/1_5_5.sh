#!/usr/bin/bash

{
    dpkg_output=$(dpkg-query -s apport &> /dev/null && grep -Psi -- '^\h*enabled\h*=\h*[^0]\b' /etc/default/apport)
    systemctl_output=$(systemctl is-active apport.service | grep '^active')
    
    if [[ -z $dpkg_output ]] && [[ -z $systemctl_output ]]; then
        echo "Audit Result: PASS"
    else
        echo "Audit Result: FAIL"
    fi
}