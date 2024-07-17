#!/usr/bin/bash
source utils.sh

{
    echo "[REMEDIATION] Ensure pam_faillock module is enabled (5.3.2.2)..."

    # Creating the first profile for pam_faillock to deny access
    faillock_profile=$(cat <<EOF
Name: Enable pam_faillock to deny access
Default: yes
Priority: 0
Auth-Type: Primary
Auth:
 [default=die] pam_faillock.so authfail
EOF
    )
    echo "$faillock_profile" > /usr/share/pam-configs/faillock

    # Creating the second profile for notifying failed login attempts and resetting count upon success
    faillock_notify_profile=$(cat <<EOF
Name: Notify of failed login attempts and reset count upon success
Default: yes
Priority: 1024
Auth-Type: Primary
Auth:
 requisite pam_faillock.so preauth
Account-Type: Primary
Account:
 required pam_faillock.so
EOF
    )
    echo "$faillock_notify_profile" > /usr/share/pam-configs/faillock_notify

    # Updating PAM configuration
    pam-auth-update --enable faillock
    pam-auth-update --enable faillock_notify

    echo "Remediation successful"
}
