source utils.sh

# 4.1.2 Ensure iptables-persistent is not installed with ufw
{
    query_output=$(dpkg-query -s iptables-persistent &>/dev/null && echo "iptables-persistent is installed")
    if [["$query_output" == "iptables-persistent is installed"]]; then
        echo "Audit Result: Fail"
        #Remediation
        runFix "4.1.2" fixes/chap4/chap4_1/chap4_1_2.sh
    
    else
        echo "Audit Result: Pass"
    fi
}