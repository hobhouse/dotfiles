# dotfiles [![Lint](https://github.com/hobhouse/dotfiles/actions/workflows/lint.yml/badge.svg)](https://github.com/hobhouse/dotfiles/actions/workflows/lint.yml) [![Scripts](https://github.com/hobhouse/dotfiles/actions/workflows/scripts.yml/badge.svg)](https://github.com/hobhouse/dotfiles/actions/workflows/scripts.yml)

My macOS setup.

## Install

1. In Finder press <kbd>cmd</kbd> + <kbd>shift</kbd> + <kbd>.</kbd> to show hidden files then restore [backup files](#backup-files) (optional)

2. Install [Homebrew](https://brew.sh/)

3. Clone repo (if not restored from backup) to `~/projects/personal/dotfiles`

4. Run the following command from `~/projects/personal/dotfiles`:

    ```sh
    ~/projects/personal/dotfiles/setup.sh
    ```

5. Complete [manual steps](#manual-steps)

### Manual Steps

1. Modify macOS settings

    - In Finder sidebar enable `alec` and `Alec's MacBook`, disable Tags and add `~/projects` to Favorites
    - Map <kbd>⇪</kbd> key to <kbd>Ctrl</kbd> at `Keyboard > Modifier Keys`
    - Disable double-space period at `Keyboard > Text`
    - Enable "Show Percentage" at `Dock & Menu Bar > Battery`
    - Enable "Remote Login" in `Sharing` for SSH access
    - Search for and add printer in "Printers & Scanners"

2. Set up remote connections

    - Set up GitHub connection with `gh auth login`
    - Import GPG keys or create with `gpg --full-generate-key` and [add to GitHub](https://docs.github.com/en/github/authenticating-to-github/generating-a-new-gpg-key)
    - Set up Heroku connection with `heroku login` and `heroku keys:add`
    - Copy SSH keys from each machine on local network with `ssh-copy-id`

3. Set up other apps

    - Import Raycast settings from dotfiles
    - Disable "Hardware Media Key Handling" in `brave://flags`
    - Sourcetree
        - General: Disable modifying of global `.gitconfig`
        - General: Set terminal app to iTerm2
        - General: Enable "Open links on GitHub.com with Sourcetree"
        - Diff: Set font to Fira Code 12pt
        - Diff: Set diff tool to Kaleidoscope
        - Diff: Allow `Gemfile.lock` in "Ignore File Patterns"
        - Git: Enable "Use rebase instead of merge by default for tracked branches"
        - Advanced: Enable "Allow force push"
    - Change Kaleidoscope settings to use Fira Code 12pt font
    - Install Sonos S2 app

### Backup Files

Things to backup to an external drive if moving from an old machine:

- `~/Desktop`
- `~/Downloads`
- `~/My Drive`
- `~/projects`
- `~/.aws`
- `~/.extra`
- `~/.ssh`
- `~/.zsh_history`
- [Exported](https://gpgtools.tenderapp.com/kb/gpg-keychain-faq/backup-or-transfer-your-keys#backup-single-key) GPG keys
- [Exported](https://localwp.com/help-docs/getting-started/how-to-export-a-wordpress-site-on-local/) Local sites

### Backup and Restore Scripts

The repository includes several scripts to help manage the transfer of settings and sensitive files between machines:

#### General Settings

- `backup_settings.sh`: Backs up general configuration files and settings
- `restore_settings.sh`: Restores the backed up settings to the new machine

To use these scripts:
1. On the old machine, run `./backup_settings.sh` to create a backup
2. Transfer the backup directory to the new machine
3. On the new machine, run `./restore_settings.sh` to restore the settings

#### Sensitive Files

For secure transfer of sensitive files (SSH keys, GPG keys, etc.):

- `backup_keys.sh`: Securely backs up sensitive keys and certificates
- `restore_keys.sh`: Restores the sensitive keys to the new machine

⚠️ **Important Security Notes:**
- These scripts handle sensitive information and should be used with caution
- The backup directory is automatically excluded from version control via `.gitignore_global`
- SSL certificates are explicitly excluded from the backup process
- Always verify the integrity of transferred files
- Consider using a secure transfer method (like a password-protected USB drive) for the sensitive files

### Utility Scripts

The `scripts/` directory contains various utility scripts for managing and automating tasks on macOS. These scripts are organized into several categories:

#### System Management
- `macos.sh`: Configures macOS system preferences and settings
- `brew.sh`: Manages Homebrew package manager
- `cask.sh`: Installs and manages macOS applications
- `mas.sh`: Manages Mac App Store applications

#### Development Environment
- Language-specific setup scripts (Python, Go, Ruby, Node.js)
- IDE and editor configuration (VS Code, Cursor, Sublime Text, iTerm2)

#### Utilities
- `mail-backup.sh`: Backup and restore Mail app data
- Git and GitHub utilities for PR management
- Automation scripts for Zoom and Spotify
- Shell configuration

For detailed documentation about each script, including usage instructions and best practices, see the [scripts/README.md](scripts/README.md).
