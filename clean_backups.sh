#!/bin/bash

# Script to remove state.vscdb and state.vscdb.backup files from backup_* directories
# This helps clean up sensitive data that might have been accidentally backed up

echo "🔍 Searching for state.vscdb files in backup_* directories..."

# Find all matching files and store in an array
files=($(find backup_* -name "state.vscdb*" 2>/dev/null))

if [ ${#files[@]} -eq 0 ]; then
    echo "✅ No matching files found"
    exit 0
fi

echo "Found ${#files[@]} matching files:"
for file in "${files[@]}"; do
    echo "  - $file"
done

echo -e "\n⚠️  These files will be permanently deleted."
read -p "Do you want to continue? (y/N) " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
    for file in "${files[@]}"; do
        rm -v "$file"
    done
    echo "✅ Cleanup complete"
else
    echo "❌ Operation cancelled"
    exit 1
fi
