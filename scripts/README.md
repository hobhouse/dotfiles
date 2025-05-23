# Dotfiles Scripts

This directory contains various utility scripts for managing and automating tasks on macOS. Below is a comprehensive list of available scripts and their purposes.

## System Management Scripts

### `macos.sh`
Configures macOS system preferences and settings. Includes settings for:
- Dock behavior
- Finder preferences
- Security settings
- System appearance
- And many more system-level configurations

### `brew.sh`
Manages Homebrew package manager installation and updates. Installs essential command-line tools and utilities.

### `cask.sh`
Installs and manages macOS applications through Homebrew Cask. Includes popular applications like:
- MonitorControl
- Brave Browser
- Transmission
- OneDrive
- And many more

### `mas.sh`
Manages Mac App Store applications installation.

## Development Environment Scripts

### Language-specific Setup
- `python.sh` - Python development environment setup
- `go.sh` - Go development environment setup
- `ruby.sh` - Ruby development environment setup
- `node.sh` - Node.js development environment setup

### IDE and Editor Scripts
- `vscode.sh` - Visual Studio Code setup and extensions
- `cursor.sh` - Cursor IDE setup
- `sublime.sh` - Sublime Text setup
- `iterm2.sh` - iTerm2 configuration

## Utility Scripts

### Backup and Restore
- `mail-backup.sh` - Backup and restore Mail app data
  ```bash
  # Usage:
  ./mail-backup.sh
  # Follow the prompts to:
  # 1. Backup Mail data to external drive
  # 2. Restore Mail data from backup
  ```
  Features:
  - Creates dated backups
  - Handles Mail app data, preferences, and containers
  - Includes safety checks
  - Color-coded output

- `backup_settings.sh` - Backup system settings and preferences
- `restore_settings.sh` - Restore system settings from backup

### Git and GitHub Utilities
- `checkout-pr.sh` - Checkout GitHub pull requests locally
- `checkout.sh` - Git branch management utilities
- `compare_branch_on_github.sh` - Compare branches on GitHub
- `merge_and_destroy_pr` - Merge and clean up pull requests

### Automation Scripts
- `mute-zoom.applescript` - Automate Zoom muting
- `play-discover-weekly.applescript` - Spotify Discover Weekly automation
- `clippy.sh` - Clipboard management utility

### Shell Configuration
- `shell.sh` - Shell environment setup and configuration

## Secure Transfer
The `secure_transfer/` directory contains scripts for secure file transfer operations.

## Usage

Most scripts can be run directly from the terminal:
```bash
./scripts/script-name.sh
```

For scripts that require specific permissions or system access, you may need to run them with sudo:
```bash
sudo ./scripts/script-name.sh
```

## Best Practices

1. Always review script contents before running
2. Back up important data before running system modification scripts
3. Some scripts may require specific dependencies to be installed first
4. Check the script's output for any required user input or confirmation
5. For backup scripts, ensure you have sufficient storage space

## Contributing

Feel free to modify these scripts to suit your needs. When making changes:
1. Test thoroughly on a non-production system
2. Document any new features or changes
3. Update this README if necessary
4. Consider adding error handling and user feedback

## Notes

- Some scripts may require specific macOS versions
- Certain scripts may need to be run in a specific order
- Always ensure you have a backup before running system modification scripts
- Scripts are designed for personal use and may need modification for different environments
