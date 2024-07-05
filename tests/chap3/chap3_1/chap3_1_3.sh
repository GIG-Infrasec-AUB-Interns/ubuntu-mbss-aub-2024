#! /usr/bin/bash

# 3.1.3  Ensure bluetooth services are not in use

{
    eservice=$(systemctl is-enabled bluetooth.service 2>/dev/null | grep 'enabled')
    aservice=$(systemctl is-active bluetooth.service 2>/dev/null | grep '^active')
    echo $eservice
    echo $aservice
}
