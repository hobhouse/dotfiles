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

OLD_COPY=$(pbpaste)

osascript -e 'tell application "Google Chrome" to get URL of active tab of first window' | pbcopy

URL=$(pbpaste)

# Determine the repo path based on the URL
if [[ "$URL" == *"starfish"* ]]; then
  REPO_PATH="/Users/jackhobhouse/Projects/Work/slp2"
elif [[ "$URL" == *"sdo"* ]]; then
  REPO_PATH="/Users/jackhobhouse/Projects/Work/sdo"
else
  echo "$OLD_COPY" | pbcopy
  echo "No matching repository found for the URL."
  exit 1
fi

BRANCH_NAME=$(echo "$URL" | sed -E 's#^.*/compare/master\.\.\.(.*)$#\1#')
PR_NUMBER=${URL//[!0-9]/}

set -e

if [ -n "$PR_NUMBER" ]; then
  cd "$REPO_PATH" && gh pr checkout "$PR_NUMBER" && code .
elif [ -n "$BRANCH_NAME" ]; then
  cd "$REPO_PATH" && git checkout "$BRANCH_NAME" && code .
else
  echo "$OLD_COPY" | pbcopy
  echo "No PR number or branch name found in the URL."
  exit 1
fi

echo "$OLD_COPY" | pbcopy
