#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to check if running as root
check_root() {
    if [ "$EUID" -ne 0 ]; then
        echo -e "${RED}This operation requires root privileges.${NC}"
        echo -e "${YELLOW}Please run the script with sudo:${NC}"
        echo "sudo $0"
        exit 1
    fi
}

# Function to check if Mail app is running
check_mail_running() {
    if pgrep -x "Mail" > /dev/null; then
        echo -e "${RED}Error: Mail app is running. Please quit Mail before proceeding.${NC}"
        exit 1
    fi
}

# Function to check if a path is writable
check_path_writable() {
    local path="$1"
    if [ ! -w "$path" ]; then
        echo -e "${RED}Error: No write permission for: $path${NC}"
        echo -e "${YELLOW}Please check the drive permissions and try again.${NC}"
        echo -e "You might need to:"
        echo -e "1. Eject and reconnect the drive"
        echo -e "2. Check if the drive is read-only"
        echo -e "3. Run 'diskutil info $path' to check drive status"
        exit 1
    fi
}

# Function to list available drives
list_available_drives() {
    echo -e "${BLUE}Available drives:${NC}"
    echo "----------------"
    ls -1 /Volumes/ | grep -v "Macintosh HD" | while read -r drive; do
        if [ -d "/Volumes/$drive" ]; then
            # Get drive info
            size=$(df -h "/Volumes/$drive" | awk 'NR==2 {print $2}')
            used=$(df -h "/Volumes/$drive" | awk 'NR==2 {print $3}')
            avail=$(df -h "/Volumes/$drive" | awk 'NR==2 {print $4}')
            echo -e "${YELLOW}$drive${NC}"
            echo -e "  Size: $size"
            echo -e "  Used: $used"
            echo -e "  Available: $avail"
            echo "----------------"
        fi
    done
    echo
}

# Function to backup Mail data
backup_mail() {
    local backup_dir="$1"
    local error_occurred=false

    echo -e "${YELLOW}Starting Mail backup...${NC}"

    # Check if we can write to the drive
    check_path_writable "$(dirname "$backup_dir")"

    # Create backup directory if it doesn't exist
    if ! mkdir -p "$backup_dir" 2>/dev/null; then
        echo -e "${RED}Error: Could not create backup directory: $backup_dir${NC}"
        exit 1
    fi

    # Backup Mail data with error checking
    echo "Backing up Mail data..."

    # Check if source directories exist
    if [ ! -d "$HOME/Library/Mail" ]; then
        echo -e "${RED}Error: Mail directory not found at: $HOME/Library/Mail${NC}"
        error_occurred=true
    fi

    if [ ! -f "$HOME/Library/Preferences/com.apple.mail.plist" ]; then
        echo -e "${RED}Error: Mail preferences not found at: $HOME/Library/Preferences/com.apple.mail.plist${NC}"
        error_occurred=true
    fi

    if [ ! -d "$HOME/Library/Containers/com.apple.mail" ]; then
        echo -e "${RED}Error: Mail containers not found at: $HOME/Library/Containers/com.apple.mail${NC}"
        error_occurred=true
    fi

    if [ "$error_occurred" = true ]; then
        echo -e "${RED}Backup failed due to missing source files.${NC}"
        rm -rf "$backup_dir"
        exit 1
    fi

    # Perform the actual backup with error checking
    if ! cp -R "$HOME/Library/Mail" "$backup_dir/" 2>/dev/null; then
        echo -e "${RED}Error: Failed to backup Mail directory${NC}"
        error_occurred=true
    fi

    if ! cp "$HOME/Library/Preferences/com.apple.mail.plist" "$backup_dir/" 2>/dev/null; then
        echo -e "${RED}Error: Failed to backup Mail preferences${NC}"
        error_occurred=true
    fi

    if ! cp -R "$HOME/Library/Containers/com.apple.mail" "$backup_dir/" 2>/dev/null; then
        echo -e "${RED}Error: Failed to backup Mail containers${NC}"
        error_occurred=true
    fi

    if [ "$error_occurred" = true ]; then
        echo -e "${RED}Backup failed. Cleaning up...${NC}"
        rm -rf "$backup_dir"
        exit 1
    fi

    # Verify backup was successful
    if [ ! -d "$backup_dir/Mail" ] || [ ! -f "$backup_dir/com.apple.mail.plist" ] || [ ! -d "$backup_dir/com.apple.mail" ]; then
        echo -e "${RED}Error: Backup verification failed. Some files were not copied correctly.${NC}"
        rm -rf "$backup_dir"
        exit 1
    fi

    echo -e "${GREEN}Backup completed successfully to: $backup_dir${NC}"
    echo -e "${YELLOW}Backup size: $(du -sh "$backup_dir" | cut -f1)${NC}"
}

# Function to find latest backup
find_latest_backup() {
    local drive_path="$1"
    local latest_backup=""
    local latest_date=0

    # Find all mail backup directories
    for backup in "$drive_path"/mail_backup_*; do
        if [ -d "$backup" ]; then
            # Extract date from directory name
            date_str=$(basename "$backup" | sed 's/mail_backup_//')
            if [[ $date_str =~ ^[0-9]{8}$ ]]; then
                # Convert to timestamp for comparison
                timestamp=$(date -j -f "%Y%m%d" "$date_str" "+%s" 2>/dev/null)
                if [ $? -eq 0 ] && [ $timestamp -gt $latest_date ]; then
                    latest_date=$timestamp
                    latest_backup="$backup"
                fi
            fi
        fi
    done

    echo "$latest_backup"
}

# Function to restore Mail data
restore_mail() {
    local drive_path="$1"
    local error_occurred=false
    local backup_dir=""
    local current_user=$(whoami)

    echo -e "${YELLOW}Starting Mail restore...${NC}"

    # Check if running as root
    check_root

    # Find the latest backup
    backup_dir=$(find_latest_backup "$drive_path")

    if [ -z "$backup_dir" ]; then
        echo -e "${RED}Error: No backup found on drive: $drive_path${NC}"
        echo -e "${YELLOW}Available backups:${NC}"
        ls -1 "$drive_path"/mail_backup_* 2>/dev/null || echo "  None found"
        echo
        echo -e "${YELLOW}Please:${NC}"
        echo "1. Make sure you've created a backup first (option 1)"
        echo "2. Check if the backup directory exists"
        echo "3. Verify the drive is properly connected"
        exit 1
    fi

    echo -e "${BLUE}Found backup: $(basename "$backup_dir")${NC}"
    echo -e "${YELLOW}Backup size: $(du -sh "$backup_dir" | cut -f1)${NC}"

    # Ask for confirmation
    echo
    echo -e "${RED}Warning: This will overwrite your current Mail data.${NC}"
    read -p "Are you sure you want to restore from this backup? (y/N): " confirm
    if [[ ! $confirm =~ ^[Yy]$ ]]; then
        echo -e "${YELLOW}Restore cancelled.${NC}"
        exit 0
    fi

    # Check if backup directory exists and is readable
    if [ ! -d "$backup_dir" ]; then
        echo -e "${RED}Error: Backup directory not found at: $backup_dir${NC}"
        exit 1
    fi

    if [ ! -r "$backup_dir" ]; then
        echo -e "${RED}Error: No read permission for backup directory: $backup_dir${NC}"
        exit 1
    fi

    # Verify backup contents
    echo "Verifying backup contents..."
    if [ ! -d "$backup_dir/Mail" ]; then
        echo -e "${RED}Error: Mail directory missing from backup${NC}"
        error_occurred=true
    fi

    if [ ! -f "$backup_dir/com.apple.mail.plist" ]; then
        echo -e "${RED}Error: Mail preferences missing from backup${NC}"
        error_occurred=true
    fi

    if [ ! -d "$backup_dir/com.apple.mail" ]; then
        echo -e "${RED}Error: Mail containers missing from backup${NC}"
        error_occurred=true
    fi

    if [ "$error_occurred" = true ]; then
        echo -e "${RED}Error: Invalid backup. Required files are missing.${NC}"
        exit 1
    fi

    # Create backup of current Mail data before restore
    echo "Creating backup of current Mail data..."
    local current_backup="/Users/$current_user/Library/Mail_backup_$(date +%Y%m%d_%H%M%S)"
    if ! mkdir -p "$current_backup" 2>/dev/null; then
        echo -e "${RED}Error: Could not create backup of current Mail data${NC}"
        exit 1
    fi

    # Backup current data with proper permissions
    if [ -d "/Users/$current_user/Library/Mail" ]; then
        cp -R "/Users/$current_user/Library/Mail" "$current_backup/" 2>/dev/null
        chown -R "$current_user:staff" "$current_backup/Mail" 2>/dev/null
    fi
    if [ -f "/Users/$current_user/Library/Preferences/com.apple.mail.plist" ]; then
        cp "/Users/$current_user/Library/Preferences/com.apple.mail.plist" "$current_backup/" 2>/dev/null
        chown "$current_user:staff" "$current_backup/com.apple.mail.plist" 2>/dev/null
    fi
    if [ -d "/Users/$current_user/Library/Containers/com.apple.mail" ]; then
        cp -R "/Users/$current_user/Library/Containers/com.apple.mail" "$current_backup/" 2>/dev/null
        chown -R "$current_user:staff" "$current_backup/com.apple.mail" 2>/dev/null
    fi

    echo -e "${GREEN}Current Mail data backed up to: $current_backup${NC}"

    # Restore Mail data with error checking
    echo "Restoring Mail data..."

    # Remove existing Mail data with proper permissions
    rm -rf "/Users/$current_user/Library/Mail" 2>/dev/null
    rm -f "/Users/$current_user/Library/Preferences/com.apple.mail.plist" 2>/dev/null
    rm -rf "/Users/$current_user/Library/Containers/com.apple.mail" 2>/dev/null

    # Copy new data with proper permissions
    if ! cp -R "$backup_dir/Mail" "/Users/$current_user/Library/" 2>/dev/null; then
        echo -e "${RED}Error: Failed to restore Mail directory${NC}"
        error_occurred=true
    else
        chown -R "$current_user:staff" "/Users/$current_user/Library/Mail" 2>/dev/null
    fi

    if ! cp "$backup_dir/com.apple.mail.plist" "/Users/$current_user/Library/Preferences/" 2>/dev/null; then
        echo -e "${RED}Error: Failed to restore Mail preferences${NC}"
        error_occurred=true
    else
        chown "$current_user:staff" "/Users/$current_user/Library/Preferences/com.apple.mail.plist" 2>/dev/null
    fi

    if ! cp -R "$backup_dir/com.apple.mail" "/Users/$current_user/Library/Containers/" 2>/dev/null; then
        echo -e "${RED}Error: Failed to restore Mail containers${NC}"
        error_occurred=true
    else
        chown -R "$current_user:staff" "/Users/$current_user/Library/Containers/com.apple.mail" 2>/dev/null
    fi

    if [ "$error_occurred" = true ]; then
        echo -e "${RED}Restore failed. Attempting to restore from backup...${NC}"
        # Restore from the backup we made
        if [ -d "$current_backup/Mail" ]; then
            cp -R "$current_backup/Mail" "/Users/$current_user/Library/" 2>/dev/null
            chown -R "$current_user:staff" "/Users/$current_user/Library/Mail" 2>/dev/null
        fi
        if [ -f "$current_backup/com.apple.mail.plist" ]; then
            cp "$current_backup/com.apple.mail.plist" "/Users/$current_user/Library/Preferences/" 2>/dev/null
            chown "$current_user:staff" "/Users/$current_user/Library/Preferences/com.apple.mail.plist" 2>/dev/null
        fi
        if [ -d "$current_backup/com.apple.mail" ]; then
            cp -R "$current_backup/com.apple.mail" "/Users/$current_user/Library/Containers/" 2>/dev/null
            chown -R "$current_user:staff" "/Users/$current_user/Library/Containers/com.apple.mail" 2>/dev/null
        fi
        echo -e "${YELLOW}Original Mail data restored from: $current_backup${NC}"
        exit 1
    fi

    # Set proper permissions for all restored files
    chmod -R 700 "/Users/$current_user/Library/Mail" 2>/dev/null
    chmod 600 "/Users/$current_user/Library/Preferences/com.apple.mail.plist" 2>/dev/null
    chmod -R 700 "/Users/$current_user/Library/Containers/com.apple.mail" 2>/dev/null

    echo -e "${GREEN}Restore completed successfully from: $backup_dir${NC}"
    echo -e "${YELLOW}Your previous Mail data was backed up to: $current_backup${NC}"
    echo -e "${BLUE}You may need to restart your Mac for changes to take effect.${NC}"
}

# Main script
echo -e "${YELLOW}Mail Backup/Restore Script${NC}"
echo "This script will backup or restore your Mail app data."
echo

# Check if Mail is running
check_mail_running

# List available drives
list_available_drives

# Get the external drive path
echo -e "${BLUE}Please enter the drive name from the list above (e.g., 'Crucial X9'):${NC}"
read -p "Drive name: " drive_name

# Construct the full path
drive_path="/Volumes/$drive_name"

# Validate drive path
if [ ! -d "$drive_path" ]; then
    echo -e "${RED}Error: Drive not found: $drive_path${NC}"
    echo -e "${YELLOW}Please make sure:${NC}"
    echo "1. The drive is properly connected"
    echo "2. You entered the exact drive name from the list above"
    echo "3. The drive is mounted in /Volumes/"
    exit 1
fi

# Create backup directory path (handle spaces in path)
backup_dir="$drive_path/mail_backup_$(date +%Y%m%d)"

# Ask user what they want to do
echo
echo "What would you like to do?"
echo "1) Backup Mail data"
echo "2) Restore Mail data"
read -p "Enter your choice (1 or 2): " choice

case $choice in
    1)
        backup_mail "$backup_dir"
        ;;
    2)
        restore_mail "$drive_path"
        ;;
    *)
        echo -e "${RED}Invalid choice. Please run the script again and select 1 or 2.${NC}"
        exit 1
        ;;
esac

echo
echo -e "${GREEN}Done!${NC}"
echo "Note: You may need to restart your Mac after restoring Mail data."
