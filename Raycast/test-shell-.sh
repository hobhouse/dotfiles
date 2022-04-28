#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Test Shell
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.author Jack Hobhouse
# @raycast.authorURL https://github.com/hobhouse

AUTH_URL="https://accounts.spotify.com/authorize?client_id=f35257754d7748fe951271a4be52a142&redirect_uri=https%3A%2F%2Fexample.com%2F&scope=user-library-modify%20user-read-email&response_type=token&state=123"

osascript -e "tell application \"Google Chrome\"
    tell front window to make new tab at after (get active tab) with properties {$AUTH_URL} -- open a new tab after the current tab
end tell" | pbcopy


URL=$(pbpaste)

echo $URL
