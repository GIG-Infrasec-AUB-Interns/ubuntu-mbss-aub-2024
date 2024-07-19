#!/bin/bash
{
    
    SUDOERS_FILE="/etc/sudoers"
    SUDOERS_DIR="/etc/sudoers.d"

    
    sudo cp "$SUDOERS_FILE" "$SUDOERS_FILE.bak"
    for file in "$SUDOERS_DIR"/*; do
        sudo cp "$file" "$file.bak"
    done

    add_defaults_use_pty() {
        local file="$1"
        if ! grep -q '^Defaults use_pty' "$file"; then
            echo "Defaults use_pty" | sudo tee -a "$file" > /dev/null
        fi
    }

    add_defaults_use_pty "$SUDOERS_FILE"

    for file in "$SUDOERS_DIR"/*; do
        add_defaults_use_pty "$file"
    done

    sudo sed -i '/!use_pty/d' "$SUDOERS_FILE"

    for file in "$SUDOERS_DIR"/*; do
        sudo sed -i '/!use_pty/d' "$file"
    done

    if sudo visudo -c; then
        echo "Sudoers configuration is valid."
    else
        echo "Sudoers configuration has errors. Restoring from backup."
        sudo mv "$SUDOERS_FILE.bak" "$SUDOERS_FILE"
        for file in "$SUDOERS_DIR"/*.bak; do
            sudo mv "$file" "${file%.bak}"
        done
    fi
}