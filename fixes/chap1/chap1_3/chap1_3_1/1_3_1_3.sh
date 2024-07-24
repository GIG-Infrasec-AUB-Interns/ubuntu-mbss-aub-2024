#! /usr/bin/bash
# Remediation script for 1.3.1.3 Ensure all AppArmor Profiles are in enforce or complain mode

{
    echo "Remediating to ensure all AppArmor profiles are in enforce or complain mode..."

    # Set all profiles to enforce mode
    aa-enforce /etc/apparmor.d/*

    echo "All profiles are set to enforce mode."
}
