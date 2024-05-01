#!/bin/bash

# Get the URL of the Git remote origin
remote_url=$(git remote get-url origin | sed 's/git@github.com:/https:\/\/github.com\//' | sed 's/\.git$//')

# Get the name of the current Git branch
branch_name=$(git branch --show-current)

# Open the URL in default web browser
echo "Opening $remote_url/tree/$branch_name"

open "$remote_url/compare/master.../$branch_name"

# You can save this script in a file, make it executable with `chmod +x <filename>`, and then run it in your Git repository to open the corresponding URL in your default web browser.