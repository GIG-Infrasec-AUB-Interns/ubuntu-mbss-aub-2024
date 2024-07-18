source utils.sh

# 4.1.7 Ensure ufw default deny firewall policy

ufw allow out http
ufw allow out https
ufw allow out ntp # Network Time Protocol
ufw allow out to any port 53 # DNS
ufw allow out to any port 853 # DNS over TLS
ufw logging on

{
    vout=$(ufw status verbose | grep Default:)

    # Check default policies
    default_incoming=$(echo "$vout" | grep "deny (incoming)")
    default_outgoing=$(echo "$vout" | grep "deny (outgoing)")
    default_routed=$(echo "$vout" | grep "disabled (routed)")
    if [[ -n "$default_incoming" && -n "$default_outgoing" && -n "$default_routed" ]]; then
        echo "Audit Result: Pass"

    else
        echo "Audit Result: Fail"
        #Remediation
        runFix "4.1.7" fixes/chap4/chap4_1/chap4_1_7.sh
    fi
}