#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Airpods
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.description Set Jack's airpods as the ourput device
# @raycast.author Jack Hobhouse
# @raycast.authorURL https://github.com/hobhouse

blueutil --connect  2c-76-00-e1-26-d4

SwitchAudioSource -a -t output -s "Jack’s AirPods Pro"
