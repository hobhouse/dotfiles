#!/bin/sh

# Ignore ShellCheck SC1090 error
# shellcheck source=/dev/null

# Run all setup scripts
. ./scripts/brew.sh
. ./scripts/shell.sh
. ./scripts/node.sh
. ./scripts/python.sh
. ./scripts/ruby.sh
. ./scripts/iterm2.sh
. ./scripts/vscode.sh
. ./scripts/cursor.sh
# . ./scripts/sublime.sh
. ./scripts/cask.sh
. ./scripts/mas.sh
. ./scripts/macos.sh
. ./scripts/clippy.sh
. ./scripts/restore_settings.sh

echo "Follow this link to insatll the latest version of Clippy - https://github.com/ian4hu/Clipy/releases/latest"

echo "✨ Completed setup - please restart machine"
