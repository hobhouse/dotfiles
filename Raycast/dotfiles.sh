#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Edit Dotfiles
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/vscode-logo.png
# @raycast.packageName Developer Utilities

# @Documentation:
# @raycast.author Jack Hobhouse
# @raycast.authorURL https://github.com/hobhouse
# @raycast.description Open dotfiles in VSCode and SourceTree.

dotfiles_path=~/projects/personal/dotfiles

code $dotfiles_path