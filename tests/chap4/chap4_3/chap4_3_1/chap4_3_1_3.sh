source utils.sh

# 4.3.1.3 Ensure ufw is uninstalled or disabled with iptables
{
    query_output=$(dpkg-query -s ufw &>/dev/null && echo "ufw is installed")
    if [[ "$query_output" == "ufw is installed" ]]; then
        echo "Audit Result: Fail"
        #Remediation
        runFix "4.3.1.3" fixes/chap4/chap4_3/chap4_3_1/chap4_3_1_3.sh
    else
        echo "Audit Result: Pass"
    fi
}