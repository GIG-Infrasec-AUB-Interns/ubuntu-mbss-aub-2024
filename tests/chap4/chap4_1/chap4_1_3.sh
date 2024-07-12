source utils.sh
{
    ufw allow proto tcp from any to any port 22

    eout=$(systemctl is-enabled ufw.service)
    aout=$(systemctl is-active ufw)
    sout=$(ufw status | grep "Status: active")

    if [[ "$eout" == "enabled" && "$aout" == "active" && -n "$sout" ]]; then
        echo "Audit Result: Pass"
    else    
        echo "Audit Result: Fail"
        #Remediation
        runFix "4.1.3" fixes/chap4/chap4_1/chap4_1_3.sh
    fi
}