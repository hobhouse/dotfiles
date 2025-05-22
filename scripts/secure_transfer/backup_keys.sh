#!/bin/bash

# Create a timestamped directory for the secure transfer
TRANSFER_DIR="$HOME/Downloads/secure_transfer_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$TRANSFER_DIR"

echo "==> 🔒 Backing up sensitive keys and certificates to $TRANSFER_DIR"

# Function to safely copy files
copy_file() {
    local source="$1"
    local dest="$2"
    if [ -f "$source" ]; then
        echo "Copying $source to $dest"
        cp "$source" "$dest"
    else
        echo "Warning: $source does not exist"
    fi
}

# Create subdirectories
mkdir -p "$TRANSFER_DIR/ssh"
mkdir -p "$TRANSFER_DIR/gpg"
mkdir -p "$TRANSFER_DIR/certs"
mkdir -p "$TRANSFER_DIR/aws"
mkdir -p "$TRANSFER_DIR/scripts"

# Backup SSH keys and config
echo "Backing up SSH keys..."
if [ -d "$HOME/.ssh" ]; then
    # Copy all SSH keys
    cp -R "$HOME/.ssh/"* "$TRANSFER_DIR/ssh/" 2>/dev/null || echo "No SSH keys found"
    # Remove any known_hosts file as it's machine-specific
    rm -f "$TRANSFER_DIR/ssh/known_hosts" 2>/dev/null
fi

# Backup GPG keys
echo "Backing up GPG keys..."
if [ -d "$HOME/.gnupg" ]; then
    # Export private keys
    gpg --export-secret-keys --armor > "$TRANSFER_DIR/gpg/private_keys.asc" 2>/dev/null || echo "No GPG private keys found"
    # Export public keys
    gpg --export --armor > "$TRANSFER_DIR/gpg/public_keys.asc" 2>/dev/null || echo "No GPG public keys found"
    # Backup GPG config
    copy_file "$HOME/.gnupg/gpg.conf" "$TRANSFER_DIR/gpg/gpg.conf"
fi

# Backup AWS credentials
echo "Backing up AWS credentials..."
copy_file "$HOME/.aws/credentials" "$TRANSFER_DIR/aws/credentials"
copy_file "$HOME/.aws/config" "$TRANSFER_DIR/aws/config"

# Backup any SSL certificates
echo "Backing up SSL certificates..."
if [ -d "$HOME/.certs" ]; then
    cp -R "$HOME/.certs/"* "$TRANSFER_DIR/certs/" 2>/dev/null || echo "No certificates found"
fi

# Copy the restore script
echo "Copying restore script..."
copy_file "$(dirname "$0")/restore_keys.sh" "$TRANSFER_DIR/scripts/restore_keys.sh"
chmod +x "$TRANSFER_DIR/scripts/restore_keys.sh"

# Create a README with instructions
cat > "$TRANSFER_DIR/README.md" << 'EOL'
# Secure Transfer Package

This directory contains sensitive keys and certificates for transferring to a new machine.

## Contents
- SSH keys and config
- GPG keys
- AWS credentials
- SSL certificates
- Restore script

## Instructions
1. AirDrop this entire directory to your new machine
2. On the new machine, navigate to the downloaded directory
3. Run the restore script: `./scripts/restore_keys.sh`
4. After keys are restored, you can clone your dotfiles repository
5. Delete this directory after successful transfer

## Security
- This directory contains sensitive information
- Delete it after successful transfer
- Do not commit these files to version control
- Consider encrypting the directory before transfer
EOL

# Create a zip file for easier transfer
echo "Creating zip archive..."
cd "$HOME/Downloads"
zip -r "secure_transfer_$(date +%Y%m%d_%H%M%S).zip" "$(basename "$TRANSFER_DIR")"

echo "✨ Backup completed!"
echo "Files are stored in: $TRANSFER_DIR"
echo "A zip archive has been created in: $HOME/Downloads"
echo "Please review the contents before transferring."
echo "Remember to delete these files after successful transfer!"
