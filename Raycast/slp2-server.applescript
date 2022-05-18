#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title SLP2 Server
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.description Run bundle yarn etc and start new server
# @raycast.author Jack Hobhouse
# @raycast.authorURL https://github.com/hobhouse

tell application "iTerm"
	--Create a second & tird tab in the initial window
	tell current window
		create tab with default profile
	end tell

	tell current window
		create tab with default profile
	end tell

	--Send a command to the first tab
	tell current session of tab 1 of current window
		write text "j slp"
		write text "yarn"
		write text "yarn dev"
	end tell

	--Send a couple of commands to the second tab
	tell current session of tab 2 of current window
    write text "bundle"
    write text "rails db:migrate"
		write text "s"
	end tell

  	--Select the first tab
	tell tab 3 of current window
		select
	end tell
end tell
