#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Jack's Zoom
# @raycast.mode compact

# Optional parameters:
# @raycast.icon ??

# Documentation:
# @raycast.description Join meeting room and paste link
# @raycast.author Jack Hobhouse
# @raycast.authorURL https://github.com/hobhouse

set zoomLink to "https://indigolighthouse.zoom.us/j/5449113923?pwd=TWdWaXNsSHA2RTdLZEpFOFR1VHI5Zz09"
set the clipboard to zoomLink

set meetingURL to "zoommtg://zoom.us/join?confno=5449113923&pwd=TWdWaXNsSHA2RTdLZEpFOFR1VHI5Zz09"

-- Open Zoom link using the default handler (usually Zoom app)
open location meetingURL
delay 1

-- Activate Slack and paste the link
tell application "Slack" to activate
delay 0.5
tell application "System Events"
    keystroke "v" using command down
end tell
