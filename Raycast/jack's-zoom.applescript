#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Jack's Zoom
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.description Join meeting room and paste link
# @raycast.author Jack Hobhouse
# @raycast.authorURL https://github.com/hobhouse

set the clipboard to "https://indigolighthouse.zoom.us/j/5449113923?pwd=TWdWaXNsSHA2RTdLZEpFOFR1VHI5Zz09"


tell application "OtherApp" to activate

tell application "System Events"

          tell process "OtherApp"


keystroke "v" usingcommand down


keystroke return

            end tell

  end tell
