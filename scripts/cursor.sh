#!/bin/bash

echo "Setting up Cursor..."

# Create Cursor directories if they don't exist
mkdir -p "$HOME/Library/Application Support/Cursor/User"
mkdir -p "$HOME/Library/Application Support/Cursor/User/snippets"
mkdir -p "$HOME/Library/Application Support/Cursor/User/extensions"
mkdir -p "$HOME/Library/Application Support/Cursor/User/workspaceStorage"
mkdir -p "$HOME/Library/Application Support/Cursor/User/globalStorage"

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

# Check if backup exists
if [ -d "backup_latest/cursor" ]; then
    echo "Found Cursor backup, restoring settings..."

    # Restore main settings
    copy_file "backup_latest/cursor/settings.json" "$HOME/Library/Application Support/Cursor/User/settings.json"
    copy_file "backup_latest/cursor/keybindings.json" "$HOME/Library/Application Support/Cursor/User/keybindings.json"

    # Restore snippets
    if [ -d "backup_latest/cursor/snippets" ]; then
        echo "Restoring Cursor snippets..."
        cp -R "backup_latest/cursor/snippets"/* "$HOME/Library/Application Support/Cursor/User/snippets/" 2>/dev/null || echo "No snippets to restore"
    fi

    # Restore extensions
    if [ -d "backup_latest/cursor/extensions" ]; then
        echo "Restoring Cursor extensions..."
        cp -R "backup_latest/cursor/extensions"/* "$HOME/Library/Application Support/Cursor/User/extensions/" 2>/dev/null || echo "No extensions to restore"
    fi

    # Restore workspace settings
    if [ -d "backup_latest/cursor/workspaceStorage" ]; then
        echo "Restoring Cursor workspace settings..."
        cp -R "backup_latest/cursor/workspaceStorage"/* "$HOME/Library/Application Support/Cursor/User/workspaceStorage/" 2>/dev/null || echo "No workspace settings to restore"
    fi

    # Restore global storage
    if [ -d "backup_latest/cursor/globalStorage" ]; then
        echo "Restoring Cursor global storage..."
        cp -R "backup_latest/cursor/globalStorage"/* "$HOME/Library/Application Support/Cursor/User/globalStorage/" 2>/dev/null || echo "No global storage to restore"
    fi

    echo "✨ Cursor settings restored successfully!"
    echo "Please restart Cursor for changes to take effect."
else
    echo "No Cursor backup found. Skipping Cursor settings restore."
    echo "To restore Cursor settings, run the backup script first and ensure the backup is in 'backup_latest/cursor'"
fi
