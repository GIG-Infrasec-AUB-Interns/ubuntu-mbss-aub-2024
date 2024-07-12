#!/usr/bin/bash
source utils.sh

{
    echo "[REMEDIATION] Ensuring systemd-timesyncd configured with authorized timeserver (2.3.2.1)..."
    
    [ ! -d /etc/systemd/timesyncd.conf.d/ ] && mkdir /etc/systemd/timesyncd.conf.d/
    printf '%s\n' "[Time]" "NTP=time.nist.gov" "FallbackNTP=time-a-g.nist.gov time-b-g.nist.gov time-c-g.nist.gov" >> /etc/systemd/timesyncd.conf.d/60-timesyncd.conf

    systemctl reload-or-restart systemd-timesyncd
    
    echo "Configured systemd-timesyncd daemon successfully."
}
