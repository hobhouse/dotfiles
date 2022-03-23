#!/usr/bin/env sh

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title SLP2 Dev
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.description Open Iterm and VS code with SLP2
# @raycast.author Jack Hobhouse
# @raycast.authorURL https://github.com/hobhouse

set -e

cd ~/Projects/Work/slp2

open -a iTerm .

code . && gem install solargraph && gem install annotate
