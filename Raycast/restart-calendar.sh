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

launchctl stop com.apple.CalendarAgent
launchctl start com.apple.CalendarAgent
