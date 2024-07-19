#!/bin/bash
{

    sudo cp /etc/sudoers /etc/sudoers.bak
    for file in /etc/sudoers.d/*; do
        sudo cp "$file" "$file.bak"
    done

    sudo sh -c 'echo "Defaults use_pty" >> /etc/sudoers'

    for file in /etc/sudoers.d/*; do
        sudo sh -c 'echo "Defaults use_pty" >> "$file"'
    done

    sudo sed -i '/!use_pty/d' /etc/sudoers

    for file in /etc/sudoers.d/*; do
        sudo sed -i '/!use_pty/d' "$file"
    done

    if sudo visudo -c; then
        echo "Sudoers configuration is valid."
    else
        echo "Sudoers configuration has errors. Restoring from backup."
        sudo mv /etc/sudoers.bak /etc/sudoers
        for file in /etc/sudoers.d/*.bak; do
            sudo mv "$file" "${file%.bak}"
        done
    fi
}