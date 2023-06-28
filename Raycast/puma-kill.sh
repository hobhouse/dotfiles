#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title puma-kill
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.description Stop Puma
# @raycast.author Jack Hobhouse
# @raycast.authorURL https://github.com/hobhouse

pkill -9 -f puma
