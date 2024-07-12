source utils.sh

# 4.2.1 Ensure nftables is installed
{
    query_output=$(dpkg-query -s nftables &>/dev/null && echo "nftables is installed")
    if [[ "$query_output" == "nftables is installed" ]]; then
        echo "Audit Result: Pass"
    else
        echo "Audit Result: Fail"
        #Remediation
        runFix "4.2.1" fixes/chap4/chap4_2/chap4_2_1.sh
    fi
}