#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open in Safari
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.author Jack Hobhouse
# @raycast.authorURL https://github.com/hobhouse


# Get the current active URL from Google Chrome using AppleScript
url=$(osascript -e 'tell application "Google Chrome" to get URL of active tab of front window')
# osascript -e 'tell application "Google Chrome" to get URL of active tab of front window' |  xargs -t /System/Volumes/Preboot/Cryptexes/App/System/Applications/Safari.app --args --incognito --new-window


osascript -e '
  tell application "Safari"
    activate
    delay 0.5
    tell application "System Events"
        keystroke "n" using {command down, shift down}
    end tell
end tell
'
open "$url" -a Safari --args -Private


# if [ -n "$url" ]; then
#   # Open the URL in Safari Private Browsing mode using AppleScript
#   # osascript -e "tell application \"Safari\" to tell window 1 to set current tab to (make new tab with properties {URL:\"$url\"})"
#   # osascript -e 'tell application Safari to tell window 1 to make new tab with properties {URL: "$url"}'
#   osascript -e 'tell application "Safari"
#     activate
#     make new document with properties {URL:"$URL"} in private browsing
# end tell'
# else
#   echo "No URL found in Google Chrome."
# fi
