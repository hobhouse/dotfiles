#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title SLP2 Dev
# @raycast.mode compact

# Optional parameters:
# @raycast.icon ðŸ¤–

# Documentation:
# @raycast.description Open Iterm and VS code with SLP2
# @raycast.author Jack Hobhouse
# @raycast.authorURL https://github.com/hobhouse


-- tell application "iTerm"
--     activate
--     set myterm to (make new terminal)
--     tell myterm
--         launch session "Default Session"
--         tell the last session
--             write text "cd ~/Projects/Work/slp2"
--             write text "make foo"
--         end tell
--         launch session "Default Session"
--         tell the last session
--             write text "cd ~/Projects/Work/slp2"
--             write text "make bar"
--         end tell
--     end tell
-- end tell

tell application "iTerm2"
  tell current window
    create tab with profile ÒdefaultÓ
  end tell

  tell first session of current tab of current window
    write text "cd ~/Projects/Work/slp2"
  end tell
end tell
