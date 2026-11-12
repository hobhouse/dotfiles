#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Restart Calendar
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.description Kill the Calendar Sync process
# @raycast.author Jack Hobhouse
# @raycast.authorURL https://github.com/hobhouse


set -e

launchctl stop com.apple.CalendarAgent || echo "Failed to stop CalendarAgent"
launchctl start com.apple.CalendarAgent || echo "Failed to start CalendarAgent"

echo "✅ CalendarAgent restart attempted."