#!/bin/bash

echo "Setting up Clippy snippets..."

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

# Define possible Clippy snippet locations
CLIPY_LOCATIONS=(
    "$HOME/Library/Containers/com.clipy.Clipy/Data/Library/Application Support/com.clipy.Clipy/snippets.xml"
    "$HOME/Library/Application Support/com.clipy.Clipy/snippets.xml"
    "$HOME/Library/Application Support/Clipy/snippets.xml"
)

# Source of truth for snippets
REPO_SNIPPETS="clippy/snippets.xml"

if [ ! -f "$REPO_SNIPPETS" ]; then
    echo "Error: Source snippets file not found at $REPO_SNIPPETS"
    exit 1
fi

# Create backup directory if it doesn't exist
mkdir -p "backup_latest/clippy"

# Backup existing snippets if they exist
for location in "${CLIPY_LOCATIONS[@]}"; do
    if [ -f "$location" ]; then
        echo "Found existing Clippy snippets at: $location"
        echo "Backing up existing snippets..."
        copy_file "$location" "backup_latest/clippy/snippets.xml.backup"
        break
    fi
done

# Restore snippets from repo
echo "Restoring snippets from repository..."
for location in "${CLIPY_LOCATIONS[@]}"; do
    # Create directory if it doesn't exist
    mkdir -p "$(dirname "$location")"
    copy_file "$REPO_SNIPPETS" "$location"
done

# Also update the backup
copy_file "$REPO_SNIPPETS" "backup_latest/clippy/snippets.xml"

# Restart Clippy to apply changes
if pgrep -x "Clipy" > /dev/null; then
    echo "Restarting Clippy to apply changes..."
    killall Clipy
    open -a Clipy
fi

echo "Clippy snippets setup complete"
