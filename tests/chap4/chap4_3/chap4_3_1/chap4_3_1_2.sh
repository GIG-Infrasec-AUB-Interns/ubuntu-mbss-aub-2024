source utils.sh

# 4.3.1.2 Ensure nftables is not installed with iptables
{
    query_output=$(dpkg-query -s nftables &>/dev/null && echo "nftables is installed")
    if [[ "$query_output" == "nftables is installed" ]]; then
        echo "Audit Result: Fail"
        #Remediation
        runFix "4.3.1.2" fixes/chap4/chap4_3/chap4_3_1/chap4_3_1_2.sh
    else
        echo "Audit Result: Pass"
        
    fi
}