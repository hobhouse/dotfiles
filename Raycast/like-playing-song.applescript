#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Like playing song
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.description Added the current song to the liked playlist
# @raycast.author Jack Hobhouse
# @raycast.authorURL https://github.com/hobhouse

# get token
https://accounts.spotify.com/authorize\?client_id\=f35257754d7748fe951271a4be52a142\&redirect_uri\=https%3A%2F%2Fexample.com%2F\&scope\=user-library-modify%20user-read-email\&response_type\=token\&state\=123

tell application \"Spotify\" to get id of current track"

set playlist_id to "0gy99jNKNdBmDUfWnALlAI"

set oauth_id to "971fb5fb576b48f6b5b406d84cc71d3c"

-- do shell script "curl -i -X POST 'https://api.spotify.com/v1/users/11151060056/playlists/" & playlist_id & "/tracks?uris=" & track_id & "' -H 'Authorization: Bearer " & oauth_id & "' -H 'Accept: application/json'"

do shell script "curl -i -X PUT 'https://api.spotify.com/v1/me/tracks?ids=" & track_id & "' -H 'Accept: application/json' -H 'Content-Type: application/json' -H 'Authorization: Bearer BQCz5TDafvcvKIN58nxhN9L7oaK5e1y6DWompTvTsmF-F7p0_3z_E21_9JyQOrTVeM2ntc_MhqR2m-MrMTT4hSjDkLMprgbqzYMByV50nwFIrXusp8ImI72p6BPVMy1HUPnPz4VrnZN9DuRLRkXXN9rNoWu1yTf-bRnbaVg58LC1yaoOiIjj-TrNForpEi1yjz-tfB0JD2saQa18K8jro8ws47JER_JUR4faKzVw2ycoKpndUxtdndW4wb_Uo9D3CLPeos1lt1s9-smjCZGcXLo'"
