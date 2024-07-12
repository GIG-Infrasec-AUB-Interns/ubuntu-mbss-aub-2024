#!/usr/bin/bash
source utils.sh

{
    echo "[REMEDIATION] Ensure chrony is configured with authorized timeserver (2.3.3.1)..."

    echo "Please do the following"
    echo "1) Edit /etc/chrony/chrony.conf or a file ending in .sources in /etc/chrony/sources.d and add or edit server or pool lines as appropriate according to local site policy:"
    echo "   <[server|pool]> <[remote-server|remote-pool]>"
    echo "   Examples:"
    echo "   - pool directive: "
    echo "     pool time.nist.gov iburst maxsources 4 #The maxsources option is unique to the pool directive"
    echo ""
    echo "   - server directive: "
    echo "     server time-a-g.nist.gov iburst\n server 132.163.97.3 iburst\n server time-d-b.nist.gov iburs"
    echo ""
    echo "2) Run one of the following commands to load the updated time sources into chronyd running config:"
    echo "# systemctl restart chronyd\n
    - OR if sources are in a .sources file -\n
    # chronyc reload sources"
}
