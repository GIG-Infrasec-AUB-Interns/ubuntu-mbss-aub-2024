#!/usr/bin/env bash

{
    echo "[REMEDIATION] Ensure at is restricted to authorized users (2.4.2.1)..."

    grep -Pq -- '^daemon\b' /etc/group && l_group="daemon" || l_group="root"
    [ ! -e "/etc/at.allow" ] && touch /etc/at.allow
    chown root:"$l_group" /etc/at.allow
    chmod u-x,g-wx,o-rwx /etc/at.allow
    [ -e "/etc/at.deny" ] && chown root:"$l_group" /etc/at.deny
    [ -e "/etc/at.deny" ] && chmod u-x,g-wx,o-rwx /etc/at.deny
    
    echo "Remediation successful."
}
