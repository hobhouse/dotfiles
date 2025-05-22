#!/bin/bash

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TRANSFER_DIR="$(dirname "$SCRIPT_DIR")"

echo "==> 🔒 Restoring sensitive keys and certificates from $TRANSFER_DIR"

# Function to safely copy files
copy_file() {
    local source="$1"
    local dest="$2"
    if [ -f "$source" ]; then
        echo "Copying $source to $dest"
        mkdir -p "$(dirname "$dest")"
        cp "$source" "$dest"
    else
        echo "Warning: $source does not exist"
    fi
}

# Restore SSH keys
echo "Restoring SSH keys..."
if [ -d "$TRANSFER_DIR/ssh" ]; then
    mkdir -p "$HOME/.ssh"
    chmod 700 "$HOME/.ssh"
    cp -R "$TRANSFER_DIR/ssh/"* "$HOME/.ssh/" 2>/dev/null || echo "No SSH keys to restore"
    chmod 600 "$HOME/.ssh/"* 2>/dev/null
    chmod 644 "$HOME/.ssh/"*.pub 2>/dev/null
    chmod 644 "$HOME/.ssh/config" 2>/dev/null
fi

# Restore GPG keys
echo "Restoring GPG keys..."
if [ -d "$TRANSFER_DIR/gpg" ]; then
    mkdir -p "$HOME/.gnupg"
    chmod 700 "$HOME/.gnupg"

    # Import private keys
    if [ -f "$TRANSFER_DIR/gpg/private_keys.asc" ]; then
        gpg --import "$TRANSFER_DIR/gpg/private_keys.asc" 2>/dev/null || echo "No GPG private keys to import"
    fi

    # Import public keys
    if [ -f "$TRANSFER_DIR/gpg/public_keys.asc" ]; then
        gpg --import "$TRANSFER_DIR/gpg/public_keys.asc" 2>/dev/null || echo "No GPG public keys to import"
    fi

    # Restore GPG config
    copy_file "$TRANSFER_DIR/gpg/gpg.conf" "$HOME/.gnupg/gpg.conf"
fi

# Restore AWS credentials
echo "Restoring AWS credentials..."
if [ -d "$TRANSFER_DIR/aws" ]; then
    mkdir -p "$HOME/.aws"
    copy_file "$TRANSFER_DIR/aws/credentials" "$HOME/.aws/credentials"
    copy_file "$TRANSFER_DIR/aws/config" "$HOME/.aws/config"
    chmod 600 "$HOME/.aws/credentials" 2>/dev/null
fi

# Restore SSL certificates
echo "Restoring SSL certificates..."
if [ -d "$TRANSFER_DIR/certs" ]; then
    mkdir -p "$HOME/.certs"
    cp -R "$TRANSFER_DIR/certs/"* "$HOME/.certs/" 2>/dev/null || echo "No certificates to restore"
fi

# Test GitHub access
echo "Testing GitHub access..."
if ssh -T git@github.com 2>&1 | grep -q "successfully authenticated"; then
    echo "✅ GitHub SSH access confirmed!"

    # Clone dotfiles repository if not already present
    if [ ! -d "$HOME/projects/personal/dotfiles" ]; then
        echo "Cloning dotfiles repository..."
        mkdir -p "$HOME/projects/personal"
        git clone git@github.com:jackhobhouse/dotfiles.git "$HOME/projects/personal/dotfiles"

        if [ $? -eq 0 ]; then
            echo "✅ Dotfiles repository cloned successfully!"
            echo "You can now run the setup script:"
            echo "cd ~/projects/personal/dotfiles && ./setup.sh"
        else
            echo "❌ Failed to clone dotfiles repository"
        fi
    else
        echo "Dotfiles repository already exists at ~/projects/personal/dotfiles"
    fi
else
    echo "❌ GitHub SSH access failed. Please check your SSH keys."
fi

echo "✨ Key restoration completed!"
echo "Please verify that all keys and certificates are working correctly."
echo "Remember to delete the transfer directory after confirming everything works!"
echo "You can do this by running: rm -rf $TRANSFER_DIR"
