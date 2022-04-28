#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Copy playing song URL
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.description Cop
# @raycast.author Jack Hobhouse
# @raycast.authorURL https://github.com/hobhouse

tell application "Spotify"
	set spotifyURL to spotify url of the current track
end tell

set AppleScript's text item delimiters to ":"
set idPart to third text item of spotifyURL

set the clipboard to ("https://open.spotify.com/track/" & idPart)
log "Copied to clipboard"