#!/bin/bash

echo "==> 🔄 Restoring additional system settings"

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

# Function to restore system preferences
restore_system_prefs() {
    local domain="$1"
    local backup_file="$2"
    if [ -f "$backup_file" ]; then
        echo "Restoring $domain preferences..."
        defaults write "$domain" "$(cat "$backup_file")"
    fi
}

# Check if backup exists
if [ ! -d "backup_latest" ]; then
    echo "No backup found in 'backup_latest' directory. Please run backup_settings.sh first."
    exit 1
fi

# Restore system preferences
if [ -d "backup_latest/system" ]; then
    echo "Restoring system preferences..."

    # Restore plist files
    for plist in backup_latest/system/*.plist; do
        if [ -f "$plist" ]; then
            domain=$(basename "$plist" .plist)
            restore_system_prefs "com.apple.$domain" "$plist"
        fi
    done

    # Restore custom fonts
    if [ -d "backup_latest/system/fonts" ]; then
        echo "Restoring custom fonts..."
        mkdir -p "$HOME/Library/Fonts"
        cp -R "backup_latest/system/fonts"/* "$HOME/Library/Fonts/" 2>/dev/null || echo "No fonts to restore"
    fi

    # Restore custom keyboard shortcuts
    if [ -f "backup_latest/system/custom_keyboard_shortcuts.plist" ]; then
        echo "Restoring custom keyboard shortcuts..."
        defaults write -g NSUserKeyEquivalents "$(cat "backup_latest/system/custom_keyboard_shortcuts.plist")"
    fi

    # Restore login items
    if [ -f "backup_latest/system/login_items.txt" ]; then
        echo "Restoring login items..."
        while IFS= read -r item; do
            osascript -e "tell application \"System Events\" to make login item at end with properties {path:\"$item\", hidden:true}"
        done < "backup_latest/system/login_items.txt"
    fi
fi

# Restore Raycast settings
if [ -d "backup_latest/raycast" ]; then
    echo "Restoring Raycast settings..."
    mkdir -p "$HOME/Library/Application Support/Raycast"
    cp -R "backup_latest/raycast"/* "$HOME/Library/Application Support/Raycast/" 2>/dev/null || echo "No Raycast settings to restore"
fi

# Restore SSH settings
if [ -d "backup_latest/ssh" ]; then
    echo "Restoring SSH settings..."
    mkdir -p "$HOME/.ssh"
    copy_file "backup_latest/ssh/config" "$HOME/.ssh/config"
fi

# Restore npm settings
if [ -f "backup_latest/npmrc" ]; then
    echo "Restoring npm settings..."
    copy_file "backup_latest/npmrc" "$HOME/.npmrc"
fi

# Restore Ruby settings
if [ -f "backup_latest/gemrc" ]; then
    echo "Restoring Ruby settings..."
    copy_file "backup_latest/gemrc" "$HOME/.gemrc"
fi

# Install npm packages
if [ -f "backup_latest/npm_packages.txt" ]; then
    echo "Installing global npm packages..."
    while IFS= read -r package; do
        if [[ $package != *"npm@"* ]]; then  # Skip npm itself
            npm install -g "$package"
        fi
    done < "backup_latest/npm_packages.txt"
fi

# Install Ruby gems
if [ -f "backup_latest/gem_packages.txt" ]; then
    echo "Installing Ruby gems..."
    while IFS= read -r gem; do
        if [[ $gem != *"*"* ]]; then  # Skip the asterisk line
            gem install "$gem"
        fi
    done < "backup_latest/gem_packages.txt"
fi

# Install Python packages
if [ -f "backup_latest/pip_packages.txt" ]; then
    echo "Installing Python packages..."
    while IFS= read -r package; do
        if [[ $package != *"Package"* && $package != *"---"* ]]; then  # Skip header lines
            pip install "$package"
        fi
    done < "backup_latest/pip_packages.txt"
fi

echo "✨ Additional settings restored successfully!"
echo "Some settings may require a system restart to take effect."
