#!/usr/bin/env sh

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Checkout PR
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.description Take the PR number from Chrome and use GH to checkout in VScode
# @raycast.author Hobhouse
# @raycast.authorURL https://github.com/hobhouse

osascript -e 'tell application "Google Chrome" to get URL of active tab of first window' | pbcopy

URL=$(pbpaste)

# if [[ "$URL" == *"files"* ]]; then
#   gsub("/files", "", $URL)
# fi

PR_NUMBER=${URL//[!0-9]/}

set -e

cd /Users/jackhobhouse/Projects/Work/slp2 && gh pr checkout $PR_NUMBER && code .
