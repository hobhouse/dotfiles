#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to check if Mail app is running
check_mail_running() {
    if pgrep -x "Mail" > /dev/null; then
        echo -e "${RED}Error: Mail app is running. Please quit Mail before proceeding.${NC}"
        exit 1
    fi
}

# Function to backup Mail data
backup_mail() {
    local backup_dir="$1"

    echo -e "${YELLOW}Starting Mail backup...${NC}"

    # Create backup directory if it doesn't exist
    mkdir -p "$backup_dir"

    # Backup Mail data
    echo "Backing up Mail data..."
    cp -R ~/Library/Mail "$backup_dir/"
    cp ~/Library/Preferences/com.apple.mail.plist "$backup_dir/"
    cp -R ~/Library/Containers/com.apple.mail "$backup_dir/"

    echo -e "${GREEN}Backup completed successfully to: $backup_dir${NC}"
}

# Function to restore Mail data
restore_mail() {
    local backup_dir="$1"

    echo -e "${YELLOW}Starting Mail restore...${NC}"

    # Check if backup directory exists
    if [ ! -d "$backup_dir" ]; then
        echo -e "${RED}Error: Backup directory not found at: $backup_dir${NC}"
        exit 1
    fi

    # Restore Mail data
    echo "Restoring Mail data..."
    cp -R "$backup_dir/Mail" ~/Library/
    cp "$backup_dir/com.apple.mail.plist" ~/Library/Preferences/
    cp -R "$backup_dir/com.apple.mail" ~/Library/Containers/

    echo -e "${GREEN}Restore completed successfully from: $backup_dir${NC}"
}

# Main script
echo -e "${YELLOW}Mail Backup/Restore Script${NC}"
echo "This script will backup or restore your Mail app data."
echo

# Check if Mail is running
check_mail_running

# Get the external drive path
read -p "Enter the path to your external drive (e.g., /Volumes/MyDrive): " drive_path

# Create backup directory path
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
        restore_mail "$backup_dir"
        ;;
    *)
        echo -e "${RED}Invalid choice. Please run the script again and select 1 or 2.${NC}"
        exit 1
        ;;
esac

echo
echo -e "${GREEN}Done!${NC}"
echo "Note: You may need to restart your Mac after restoring Mail data."
