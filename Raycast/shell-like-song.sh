#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Shell like song
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.author Jack Hobhouse
# @raycast.authorURL https://github.com/hobhouse


OAUTHTOKEN="BQDbIa1yVzNIgTNUdQk7Q5WM5HhNXruSByVGOOq8K_2IGulAZYtEsWqmGd_8pFyp2O9J3TkLsek27ScYdb0bGNhMtLgR6RJlJHMNbmFRTXk4ctYdzIi67Ep5mvJGF8EmmPNzs6Uoaia2kARZkLrE24KvNm1F9U6q"
FULL_TRACK_ID=$(osascript -e "tell application \"Spotify\" to get id of current track")
SHORT_TRACK_ID=${FULL_TRACK_ID##*:}

curl -i -X PUT "https://api.spotify.com/v1/me/tracks?ids=$SHORT_TRACK_ID" -H 'Accept: application/json' -H 'Content-Type: application/json' -H "Authorization: Bearer $OAUTHTOKEN"
