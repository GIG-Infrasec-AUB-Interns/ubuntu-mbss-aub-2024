source utils.sh
{
    query_output=$(dpkg-query -s ufw &>/dev/null && echo "ufw is installed")
    if [["$query_output" == "ufw is installed"]]; then
        echo "Audit Result: Pass"
    else
        echo "Audit Result: Fail"
        #Remediation
        runFix "4.1.1" fixes/chap4/chap4_1/chap4_1_1.sh
    fi
}