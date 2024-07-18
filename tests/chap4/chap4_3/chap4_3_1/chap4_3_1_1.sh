source utils.sh

# 4.3.1.1 Ensure iptables packages are installed
{
    query_output=$(dpkg-query -s iptables &>/dev/null && echo "iptables is installed")
    pquery_output=$(dpkg-query -s iptables-persistent &>/dev/null && echo "iptables-persistent is installed")

    if [[ "$query_output" == "iptables is installed" && "$pquery_output" == "iptables-persistent is installed" ]]; then
        echo "Audit Result: Pass"
    else
        echo "Audit Result: Fail"
        #Remediation
        runFix "4.3.1" fixes/chap4/chap4_3/chap4_3_1/chap4_3_1_1.sh
    fi
}