#! /usr/bin/bash

# 1.4.1 [REMEDIATION] Ensure bootloader password is set

{
    echo "[REMEDIATION] Ensuring bootloader password is set (1.4.1)..."

    echo "Please set your password:\n"
    grub-mkpasswd-pbkdf2 --iteration-count=600000 --salt=64

    echo "Need to set username and encryted password (hash of password) in /etc/grub.d"
    read -p "Please enter the username you just entered: " USERNAME
    read -p "Please enter the hash of the password (not the actual password): " HASH_PASSWORD

    # Create a custom GRUB configuration file
    custom_grub_file="/etc/grub.d/01_custom"
    echo "Creating custom GRUB configuration file at $custom_grub_file"

    cat <<EOF > $custom_grub_file
exec tail -n +2 $0
set superusers="$USERNAME"
password_pbkdf2 $USERNAME $HASH_PASSWORD
EOF

    read -p "Require to be able to boot/reboot without entering password? (Y/N):" REQUIRE

    case "$REQUIRE" in
            [Yy]*)
                echo "Editing /etc/grub.d/10_linux to add --unrestricted in line CLASS=..."
                sed -i 's/^CLASS=.*$/CLASS="--class gnu-linux --class gnu --class os --unrestricted"/' /etc/grub.d/10_linux
                ;;
            *)
                echo "/etc/grub.d/10_linux not edited."
                ;;
    esac

    echo "Updating GRUB configuration..."
    update-grub

    echo "Bootloader username and password set successfully."
    echo "For more information, please visit https://downloads.cisecurity.org/#/"
}