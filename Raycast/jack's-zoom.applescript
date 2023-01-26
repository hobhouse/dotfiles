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

tell application "Chrome" to activate

tell application "slack" to activate

tell application "System Events" to keystroke "v" using command down

tell application "zoom.us" to activate

delay 0.5

tell application "System Events"
    tell process "zoom.us"

        set StartMeeting to menu item "Start Meeting" of menu "zoom.us" of menu bar 0

        repeat while not enabled of StartMeeting
            delay 0.25
        end repeat

        click StartMeeting

    end tell
end tell
