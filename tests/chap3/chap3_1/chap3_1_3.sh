#! /usr/bin/bash

# 3.1.3  Ensure bluetooth services are not in use

# bluetooth can be unmasked and started again with 

# systemctl unmask bluetooth.service
# systemctl start bluetooth.service

{
    eservice=$(systemctl is-enabled bluetooth.service 2>/dev/null | grep 'enabled')
    aservice=$(systemctl is-active bluetooth.service 2>/dev/null | grep '^active')
    echo $eservice
    if [[ "$eservice" == "enabled" ]]; then
        systemctl stop bluetooth.service
        systemctl mask bluetooth.service
        echo "bluetooth.service is disabled"
    else
        echo "bluetooth.service is already disabled"
    fi
}
