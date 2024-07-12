
{
    #Set net.ipv4.ip_forward = 0 in /etc/sysctl.conf or a file in /etc/sysctl.d/ ending in .conf
    printf '%s\n' "net.ipv4.ip_forward = 0" >> /etc/sysctl.d/60- netipv4_sysctl.conf

    sysctl -w net.ipv4.ip_forward=0
    sysctl -w net.ipv4.route.flush=1

    #Set net.ipv6.conf.all.forwarding = 0 in /etc/sysctl.conf or a file in /etc/sysctl.d/ ending in .conf
    printf '%s\n' "net.ipv6.conf.all.forwarding = 0" >> /etc/sysctl.d/60- netipv6_sysctl.conf

    sysctl -w net.ipv6.conf.all.forwarding=0
    sysctl -w net.ipv6.route.flush=1

}
