#!/bin/bash

# Create backup directory with timestamp
BACKUP_DIR="backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

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

# Function to backup system preferences
backup_system_prefs() {
    local domain="$1"
    local output_file="$2"
    echo "Backing up $domain preferences..."
    defaults read "$domain" > "$output_file" 2>/dev/null || echo "No preferences found for $domain"
}

# Create system settings directory
mkdir -p "$BACKUP_DIR/system"

# System Preferences
echo "Backing up system preferences..."
backup_system_prefs "com.apple.systempreferences" "$BACKUP_DIR/system/system_preferences.plist"
backup_system_prefs "com.apple.dock" "$BACKUP_DIR/system/dock.plist"
backup_system_prefs "com.apple.finder" "$BACKUP_DIR/system/finder.plist"
backup_system_prefs "com.apple.spaces" "$BACKUP_DIR/system/spaces.plist"
backup_system_prefs "com.apple.screensaver" "$BACKUP_DIR/system/screensaver.plist"
backup_system_prefs "com.apple.universalaccess" "$BACKUP_DIR/system/universal_access.plist"
backup_system_prefs "com.apple.sound.beep" "$BACKUP_DIR/system/sound.plist"
backup_system_prefs "com.apple.menuextra.clock" "$BACKUP_DIR/system/menu_bar_clock.plist"
backup_system_prefs "com.apple.menuextra.battery" "$BACKUP_DIR/system/menu_bar_battery.plist"

# Keyboard and Input Settings
backup_system_prefs "com.apple.keyboard" "$BACKUP_DIR/system/keyboard.plist"
backup_system_prefs "com.apple.HIToolbox" "$BACKUP_DIR/system/input_sources.plist"
backup_system_prefs "com.apple.symbolichotkeys" "$BACKUP_DIR/system/keyboard_shortcuts.plist"

# Trackpad and Mouse Settings
backup_system_prefs "com.apple.AppleMultitouchTrackpad" "$BACKUP_DIR/system/trackpad.plist"
backup_system_prefs "com.apple.driver.AppleBluetoothMultitouch.trackpad" "$BACKUP_DIR/system/bluetooth_trackpad.plist"
backup_system_prefs "com.apple.mouse" "$BACKUP_DIR/system/mouse.plist"

# Network Settings
backup_system_prefs "com.apple.airport.preferences" "$BACKUP_DIR/system/airport.plist"
backup_system_prefs "com.apple.network.identification" "$BACKUP_DIR/system/network.plist"

# Backup installed fonts
echo "Backing up custom fonts..."
if [ -d "$HOME/Library/Fonts" ]; then
    mkdir -p "$BACKUP_DIR/system/fonts"
    cp -R "$HOME/Library/Fonts"/* "$BACKUP_DIR/system/fonts/" 2>/dev/null || echo "No custom fonts found"
fi

# Backup custom keyboard shortcuts
echo "Backing up custom keyboard shortcuts..."
defaults read -g NSUserKeyEquivalents > "$BACKUP_DIR/system/custom_keyboard_shortcuts.plist" 2>/dev/null || echo "No custom keyboard shortcuts found"

# Backup login items
echo "Backing up login items..."
osascript -e 'tell application "System Events" to get the name of every login item' > "$BACKUP_DIR/system/login_items.txt" 2>/dev/null || echo "No login items found"

# Backup system version and hardware info
echo "Backing up system information..."
sw_vers > "$BACKUP_DIR/system/system_version.txt"
system_profiler SPHardwareDataType > "$BACKUP_DIR/system/hardware_info.txt"

# Backup Time Machine settings
echo "Backing up Time Machine settings..."
tmutil destinationinfo > "$BACKUP_DIR/system/timemachine_destinations.txt" 2>/dev/null || echo "No Time Machine destinations found"

# Backup Energy Saver settings
echo "Backing up Energy Saver settings..."
pmset -g > "$BACKUP_DIR/system/power_settings.txt"

# Shell and Git settings
copy_file "$HOME/.zshrc" "$BACKUP_DIR/zshrc"
copy_file "$HOME/.zshenv" "$BACKUP_DIR/zshenv"
copy_file "$HOME/.gitconfig" "$BACKUP_DIR/gitconfig"
copy_file "$HOME/.gitignore_global" "$BACKUP_DIR/gitignore_global"

# SSH settings
if [ -d "$HOME/.ssh" ]; then
    mkdir -p "$BACKUP_DIR/ssh"
    cp "$HOME/.ssh/config" "$BACKUP_DIR/ssh/config" 2>/dev/null || echo "No SSH config found"
fi

# Application settings
copy_file "$HOME/Library/Application Support/Code/User/settings.json" "$BACKUP_DIR/vscode_settings.json"
copy_file "$HOME/Library/Application Support/Code/User/keybindings.json" "$BACKUP_DIR/vscode_keybindings.json"

# Cursor settings
echo "Backing up Cursor settings..."
if [ -d "$HOME/Library/Application Support/Cursor" ]; then
    mkdir -p "$BACKUP_DIR/cursor"
    # Backup main settings
    copy_file "$HOME/Library/Application Support/Cursor/User/settings.json" "$BACKUP_DIR/cursor/settings.json"
    copy_file "$HOME/Library/Application Support/Cursor/User/keybindings.json" "$BACKUP_DIR/cursor/keybindings.json"
    # Backup snippets
    if [ -d "$HOME/Library/Application Support/Cursor/User/snippets" ]; then
        mkdir -p "$BACKUP_DIR/cursor/snippets"
        cp -R "$HOME/Library/Application Support/Cursor/User/snippets"/* "$BACKUP_DIR/cursor/snippets/" 2>/dev/null || echo "No Cursor snippets found"
    fi
    # Backup extensions
    if [ -d "$HOME/Library/Application Support/Cursor/User/extensions" ]; then
        mkdir -p "$BACKUP_DIR/cursor/extensions"
        cp -R "$HOME/Library/Application Support/Cursor/User/extensions"/* "$BACKUP_DIR/cursor/extensions/" 2>/dev/null || echo "No Cursor extensions found"
    fi
    # Backup workspace settings
    if [ -d "$HOME/Library/Application Support/Cursor/User/workspaceStorage" ]; then
        mkdir -p "$BACKUP_DIR/cursor/workspaceStorage"
        cp -R "$HOME/Library/Application Support/Cursor/User/workspaceStorage"/* "$BACKUP_DIR/cursor/workspaceStorage/" 2>/dev/null || echo "No Cursor workspace settings found"
    fi
    # Backup state
    if [ -d "$HOME/Library/Application Support/Cursor/User/globalStorage" ]; then
        mkdir -p "$BACKUP_DIR/cursor/globalStorage"
        cp -R "$HOME/Library/Application Support/Cursor/User/globalStorage"/* "$BACKUP_DIR/cursor/globalStorage/" 2>/dev/null || echo "No Cursor global storage found"
    fi
fi

# iTerm2 settings
if [ -f "$HOME/Library/Preferences/com.googlecode.iterm2.plist" ]; then
    echo "Backing up iTerm2 settings..."
    defaults read com.googlecode.iterm2 > "$BACKUP_DIR/iterm2_settings.plist"
fi

# Raycast settings
if [ -d "$HOME/Library/Application Support/Raycast" ]; then
    mkdir -p "$BACKUP_DIR/raycast"
    cp -R "$HOME/Library/Application Support/Raycast"/* "$BACKUP_DIR/raycast/" 2>/dev/null || echo "No Raycast settings found"
fi

# npm settings
copy_file "$HOME/.npmrc" "$BACKUP_DIR/npmrc"

# Ruby settings
copy_file "$HOME/.gemrc" "$BACKUP_DIR/gemrc"
if [ -f "$HOME/.rbenv/version" ]; then
    cp "$HOME/.rbenv/version" "$BACKUP_DIR/rbenv_version"
fi

# Node settings
if [ -f "$HOME/.nvm/alias/default" ]; then
    cp "$HOME/.nvm/alias/default" "$BACKUP_DIR/nvm_default"
fi

# List of installed Homebrew packages
echo "Backing up Homebrew packages..."
brew list > "$BACKUP_DIR/brew_packages.txt"
brew list --cask > "$BACKUP_DIR/brew_casks.txt"

# List of installed npm packages
echo "Backing up global npm packages..."
npm list -g --depth=0 > "$BACKUP_DIR/npm_packages.txt"

# List of installed Ruby gems
echo "Backing up Ruby gems..."
gem list > "$BACKUP_DIR/gem_packages.txt"

# List of installed Python packages
echo "Backing up Python packages..."
pip list > "$BACKUP_DIR/pip_packages.txt" 2>/dev/null || echo "No pip packages found"

# Create a summary file with system information
echo "System Settings Backup Summary" > "$BACKUP_DIR/system/backup_summary.txt"
echo "=============================" >> "$BACKUP_DIR/system/backup_summary.txt"
echo "Backup completed at: $(date)" >> "$BACKUP_DIR/system/backup_summary.txt"
echo "macOS Version: $(sw_vers -productVersion)" >> "$BACKUP_DIR/system/backup_summary.txt"
echo "Hardware Model: $(sysctl hw.model | awk '{print $2}')" >> "$BACKUP_DIR/system/backup_summary.txt"
echo "" >> "$BACKUP_DIR/system/backup_summary.txt"
echo "Backed up system preferences:" >> "$BACKUP_DIR/system/backup_summary.txt"
find "$BACKUP_DIR/system" -type f -name "*.plist" | sort >> "$BACKUP_DIR/system/backup_summary.txt"
echo "" >> "$BACKUP_DIR/system/backup_summary.txt"
echo "Backed up system files:" >> "$BACKUP_DIR/system/backup_summary.txt"
find "$BACKUP_DIR/system" -type f -not -name "*.plist" | sort >> "$BACKUP_DIR/system/backup_summary.txt"

echo "✨ System settings backup completed!"
echo "System settings are stored in $BACKUP_DIR/system"
echo "Review the files for any sensitive information before committing to your repository!"
echo "Note: Some system settings may need to be manually configured on the new machine."
