#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Mute-Zoom
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.description Mute/Zoom
# @raycast.author Jack Hobhouse
# @raycast.authorURL https://github.com/hobhouse

on run
	tell application "zoom.us"
		activate
		tell application "System Events" to tell process "zoom.us" to keystroke "a" using {shift down, command down}
	end tell
end run