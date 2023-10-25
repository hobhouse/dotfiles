#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Play Discover Weekly
# @raycast.mode silent

# Optional parameters:
# @raycast.icon /Users/jackhobhouse/Projects/Personal/spotify-player/assets/spotify-icon.svg

# Documentation:
# @raycast.author Hobhouse
# @raycast.authorURL https://github.com/hobhouse

property uri: "spotify:playlist:37i9dQZEVXcS0qByLuPolD"

tell application "Spotify" to play track uri