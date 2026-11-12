#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Airpods
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.description Set Jack's airpods as the ourput device
# @raycast.author Jack Hobhouse
# @raycast.authorURL https://github.com/hobhouse


# Prerequisites
# brew install blueutil
# brew install switchaudio-osx


# blueutil --connect  2c-76-00-e1-26-d4
blueutil --connect  bc-80-4e-ac-b5-44

SwitchAudioSource -a -t output -s "Jack’s AirPods Pro #2"
