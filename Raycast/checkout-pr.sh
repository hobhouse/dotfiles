#!/usr/bin/env sh

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Checkout PR
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.description Take the PR number from Chrome and use GH to checkout in VScode (BROKEN)
# @raycast.author Hobhouse
# @raycast.authorURL https://github.com/hobhouse

osascript -e 'tell application "Google Chrome" to get URL of active tab of first window' | pbcopy

URL=$(pbpaste)

PR_NUMBER=${URL##*/}

command="\"gh pr checkout $PR_NUMBER \""


echo "{ \"command\": \"workbench.action.terminal.sendSequence\", \"args\": { \"text\": $command } }" | websocat ws://localhost:3710
